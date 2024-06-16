terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    docker = {
      source = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  profile  = var.profile 
  region   = var.region
}

# Configuration for Docker
provider "docker" {
  alias = "kreuzwerker"
  registry_auth {
    address  = local.aws_ecr_url 
    username = data.aws_ecr_authorization_token.token.user_name
    password = data.aws_ecr_authorization_token.token.password
  }
  
}