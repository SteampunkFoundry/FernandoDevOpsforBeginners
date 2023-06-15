terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  required_version = ">= 0.15.3"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-022e1a32d3f742bd8"
  instance_type = "t2.micro"
  subnet_id = "subnet-0ec96671454815143"
  key_name ="PrivateKey6_15_2023"

  tags = {
    Name = "Testing Terraform Part 3"
    CreatorName ="fquezado"
  }
}

output "instance_ip" {
    value = aws_instance.app_server.public_dns
    description = "The public IP of the instance"
  }

