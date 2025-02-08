terraform {
  required_version = ">= 1.0.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.38"
    }
  }
}

provider "aws" {
  default_tags {
    tags = local.default_tags
  }
}
