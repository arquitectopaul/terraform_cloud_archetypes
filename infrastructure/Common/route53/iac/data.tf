data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = local.terraform_remote_state_bucket_name
    key    = "commons/vpc/terraform.tfstate"
  }
}

data "aws_route53_zone" "this" {
  name = var.domain_name
}
