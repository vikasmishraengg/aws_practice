provider "aws" {
  region = "us-east-1"  # Specify the AWS region
}
 
resource "aws_s3_bucket" "my_bucket" {
  bucket = "S3test45744444329"  # Bucket names must be globally unique
  acl    = "private"                # Defines the access level of the bucket
 
  tags = {
    Name        = "My Bucket"
    Environment = "Production"
  }
}
 
# Optional: Enable versioning
resource "aws_s3_bucket_versioning" "my_bucket_versioning" {
  bucket = aws_s3_bucket.my_bucket.id
 
  versioning_configuration {
    status = "Enabled"
  }
}