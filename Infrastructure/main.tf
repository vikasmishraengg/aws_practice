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
  count         = 2
  ami           = "ami-0c2b8ca1dad447f8a"  # Example AMI ID; replace with a valid one for your region
  instance_type = "t2.micro"
  security_groups = [aws_security_group.allow_ssh.name]
 
  tags = {
    Name = "ExampleInstance-${count.index+1}"
  }
}