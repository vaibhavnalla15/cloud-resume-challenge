variable "aws_region" {
  default = "us-east-1"
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "lambda_role_arn" {
  description = "Existing IAM Role ARN for Lambda"
  type        = string
}