terraform {
  required_version = ">= 1.4.0"

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

provider "aws" {
  alias  = "virginia_region_provider"
  region = "us-east-1"

  default_tags {
    tags = local.default_tags
  }
}
