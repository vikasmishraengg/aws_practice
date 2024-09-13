provider "aws" {
  region = "us-east-1" # Specify the AWS region
}
 
resource "aws_s3_bucket" "public_bucket" {
  bucket = "my-public-bucket-name" # Ensure the bucket name is unique
  acl    = "public-read" # Set the bucket to public read access
 
  tags = {
    Purpose = "Public Content"
    ManagedBy = "Terraform"
  }
}
 
# Bucket policy to enforce public read access
resource "aws_s3_bucket_policy" "public_bucket_policy" {
  bucket = aws_s3_bucket.public_bucket.id
 
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = ["s3:GetObject"]
        Resource = ["${aws_s3_bucket.public_bucket.arn}/*"]
      }
    ]
  })
}