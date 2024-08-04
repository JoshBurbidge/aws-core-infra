terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.60"
    }
  }
  backend "s3" {
    bucket = "575737149124-terraform-backend"
    key    = "core/tfstate"
    region = "us-east-1"
  }

  required_version = ">= 1.9.2"
}

locals {
  app_name = "core"
  tags = {
    app = local.app_name
  }
}

provider "aws" {
  region = "us-east-1"
}
