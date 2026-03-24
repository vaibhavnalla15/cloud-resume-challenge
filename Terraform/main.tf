# --------------------------------------------
# THE CLOUD RESUME CHALLENGE
# --------------------------------------------

# --------------------------------------------
# 1. S3 BUCKET CREATION
# --------------------------------------------

resource "aws_s3_bucket" "resume_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "Cloud Resume Bucket"
    Environment = "Dev"
  }
}

# BLOCK ALL PUBLIC ACCESS

resource "aws_s3_bucket_public_access_block" "block_public" {
  bucket = aws_s3_bucket.resume_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# UPLOAD STATIC WEBSITE FILES TO S3
# This will upload all files from frontend/

resource "aws_s3_object" "website_files" {
  for_each = fileset("${path.module}/../frontend", "**")

  bucket = aws_s3_bucket.resume_bucket.id
  key    = each.value
  source = "${path.module}/../frontend/${each.value}"

  etag = filemd5("${path.module}/../frontend/${each.value}")

  content_type = lookup({
    html = "text/html"
    css  = "text/css"
    js   = "application/javascript"
    png  = "image/png"
    jpg  = "image/jpeg"
    jpeg = "image/jpeg"
    svg  = "image/svg+xml"
  }, split(".", each.value)[length(split(".", each.value)) - 1], "application/octet-stream")
}

# --------------------------------------------
# 2. CloudFront
# --------------------------------------------

# CREATE ORIGIN ACCESS CONTROL (OAC)
# This allows CloudFront to securely access S3

resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "resume-oac"
  description                       = "OAC for Cloud Resume S3"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# CREATE CLOUDFRONT DISTRIBUTION
# CDN to serve content from private S3

resource "aws_cloudfront_distribution" "cdn" {
  enabled             = true
  default_root_object = "index.html"

  origin {
    domain_name = aws_s3_bucket.resume_bucket.bucket_regional_domain_name
    origin_id   = "s3-origin"

    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  # CACHE BEHAVIOR (DISABLE CACHING FOR DEV)
  # Ensures updates reflect immediately

  default_cache_behavior {
    target_origin_id       = "s3-origin"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    # Disable caching (important for development)
    min_ttl     = 0
    default_ttl = 0
    max_ttl     = 0

    forwarded_values {
      query_string = true

      cookies {
        forward = "all"
      }
    }
  }

  # Default CloudFront SSL (we will upgrade later with custom domain)
  viewer_certificate {
    cloudfront_default_certificate = true
  }

  # No geo restriction
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name = "Cloud Resume CDN"
  }
}

# --------------------------------------------
# 3. S3 BUCKET POLICY
# --------------------------------------------

# ATTACH BUCKET POLICY USING TEMPLATE FILE
# Allows only CloudFront (OAC) to access S3

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.resume_bucket.id

  policy = templatefile("${path.module}/policy.json", {
    bucket_name      = aws_s3_bucket.resume_bucket.bucket
    distribution_arn = aws_cloudfront_distribution.cdn.arn
  })
}

# --------------------------------------------
# 4. DYNAMODB TABLE
# --------------------------------------------
# DYNAMODB TABLE (Visitor Counter)
# Stores number of visits to your website

resource "aws_dynamodb_table" "visitor_count" {
  name         = "visitor-count"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "id"

  attribute {
    name = "id"
    type = "S" # String
  }

  tags = {
    Name = "Visitor Counter Table"
  }
}

# --------------------------------------------
# 5. LAMBDA FUNCTION
# --------------------------------------------
# CREATE LAMBDA FUNCTION & USEING EXISTING IAM ROLE

resource "aws_lambda_function" "visitor_lambda" {
  function_name = "visitor-counter"

  filename = "${path.module}/../backend/Lambda/function.zip"
  handler  = "lambda_function.lambda_handler"
  runtime  = "python3.12"

  # 👇 Replace with your existing role ARN
  role = var.lambda_role_arn

  source_code_hash = filebase64sha256("${path.module}/../backend/Lambda/function.zip")

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.visitor_count.name
    }
  }
}

# --------------------------------------------
# 6. CREATE API GATEWAY (HTTP API)
# --------------------------------------------
resource "aws_apigatewayv2_api" "visitor_api" {
  name          = "visitor-api"
  protocol_type = "HTTP"

  cors_configuration {
    allow_origins = ["*"]
    allow_methods = ["GET"]
    allow_headers = ["*"]
  }
}

# --------------------------------------------
# CONNECT API GATEWAY TO LAMBDA
# --------------------------------------------
resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id = aws_apigatewayv2_api.visitor_api.id

  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.visitor_lambda.invoke_arn
}

# --------------------------------------------
# DEFINE ROUTE (ENDPOINT)
# --------------------------------------------
resource "aws_apigatewayv2_route" "get_count" {
  api_id    = aws_apigatewayv2_api.visitor_api.id
  route_key = "GET /visitor"

  target = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

# --------------------------------------------
# DEPLOY API (AUTO DEPLOY ENABLED)
# --------------------------------------------
resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.visitor_api.id
  name        = "$default"
  auto_deploy = true
}

# --------------------------------------------
# PERMISSION: API GATEWAY → LAMBDA
# --------------------------------------------
resource "aws_lambda_permission" "api_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.visitor_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.visitor_api.execution_arn}/*/*"
}