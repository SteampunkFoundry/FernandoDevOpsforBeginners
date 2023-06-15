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
  ami           = "ami-0d86c69530d0a048e"
  instance_type = "t2.micro"
  subnet_id = "subnet-02a9c3397a0a8b78b"
  key_name ="<testingTerraform>"

  tags = {
    Name = "<TestInstance2"
    CreatorName ="<fquezado>"
  }
}

output "instance_ip" {
    value = aws_instance.app_server.public_ip
    description = "The public IP of the instance"
  }
