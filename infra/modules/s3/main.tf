
# --- FRONTEND: S3 & CLOUDFRONT ---
# 1. Create an S3 Bucket to host the resume website.
resource "aws_s3_bucket" "resume" {
  bucket = var.bucket_name
} 

# Disable Public Access Block for the S3 Bucket.
resource "aws_s3_bucket_public_access_block" "block_public" {
  bucket = aws_s3_bucket.resume.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Configure the S3 Bucket for static website hosting.
resource "aws_s3_bucket_website_configuration" "resume" {
  bucket = aws_s3_bucket.resume.id

  index_document {
    suffix = "index.html"
  }
}

