provider "aws" {
  region = "us-east-1"  # Specify the AWS region
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
 
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
 
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
 
resource "aws_instance" "example" {
  ami           = "ami-0c2b8ca1dad447f8a"  # Example AMI ID; replace with a valid one for your region
  instance_type = "t2.micro"
  security_groups = [aws_security_group.allow_ssh.name]
 
  tags = {
    Name = "TerraformExample"
  }
}
resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "network"
  subnets            = [for subnet in aws_subnet.public : subnet-0a26d92eb585e3ff0.id]

  enable_deletion_protection = true

  tags = {
    Environment = "production"
  }
}