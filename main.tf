terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-099543e8a36a7890c"
  instance_type = "t2.micro"
  subnet_id = "subnet-0f83fd875df60928a"

  tags = {
    Name = "<YOUR-NAME>-test-instance"
    CreatorName = <aws_username_given_with_your_key>
  }
}