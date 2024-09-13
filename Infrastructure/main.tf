name: Terraform-04
 
on:
  push:
    branches:
      - main  
  pull_request:
 
jobs:
  terraform:
    name: 'Terraform'
    runs-on: ubuntu-latest
 
    env:
      AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
      AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
      AWS_DEFAULT_REGION: 'us-east-1'  
 
    steps:
    - name: Checkout Repository
      uses: actions/checkout@v2
 
    - name: Setup Terraform
      uses: hashicorp/setup-terraform@v2
      with:
        terraform_version: '1.4.6'  
 
    - name: Terraform Init
      working-directory: Infrastructure/s3
      run: |
        terraform init
 
    - name: Terraform Validate
      working-directory: Infrastructure/s3
      run: |
        terraform validate
 
    - name: Terraform Plan
      working-directory: Infrastructure/s3
      run: |
        terraform plan
 
    - name: Terraform Apply
      if: github.ref == 'refs/heads/main'  # Only apply on main branch
      working-directory: Infrastructure/s3
      run: |
        terraform apply -auto-approve
 
provider "aws" {

  region = "us-east-1"  # Specify your desired region

}
 
resource "aws_instance" "example" {

  ami           = "ami-0c55b159cbfafe1f0"  # Replace with the desired AMI ID

  instance_type = "t2.micro"              # Specify the instance type
 
  key_name = "my-key-pair"                # Ensure the key pair is already created in the AWS region
 
  security_groups = ["my-security-group"]  # Specify the security group name
 
  tags = {

    Name = "MyEC2Instance"

  }

}

 