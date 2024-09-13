provider "aws" {
  region = "us-east-1"  # Specify the AWS region
}

resource "aws_lb" "gfg_lb" {
  name               = "gfg-network-loadbalancer"
  internal           = false
  load_balancer_type = "network"
  subnets = ["subnet-0a26d92eb585e3ff0","subnet-0f3d084ff783d9348"]
}