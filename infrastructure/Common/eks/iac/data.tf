data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = local.terraform_remote_state_bucket_name
    key    = "commons/vpc/terraform.tfstate"
  }
}

data "aws_iam_policy" "aws_admin_access_policy" {
  name = "AdministratorAccess"
}
