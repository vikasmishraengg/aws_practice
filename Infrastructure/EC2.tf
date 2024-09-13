resource "aws_security_group5" "allow_ssh" {
  name        = "allow_ssh_2"
  description = "Allow SSH inbound 45"
 
  ingress {
    description      = "SMTP"
    from_port        = 25
    to_port          = 25
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
 
resource "aws_instance" "VikiEc" {
  ami           = "ami-0c2b8ca1dad447f8a"  # Example AMI ID; replace with a valid one for your region
  instance_type = "t2.micro"
  security_groups = [aws_security_group5.allow_ssh.name]
 
  tags = {
    Name = "VikiEC5"
  }
}