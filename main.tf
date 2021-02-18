terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "remote" {
    organization = "pomelo-test"

    workspaces {
      name = "AWS-Lambda-and-DynamoDB"
    }
  }
}

provider "aws" {
  region = "us-west-1"
}
