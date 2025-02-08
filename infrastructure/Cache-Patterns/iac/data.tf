data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "ue2devbucketdesignpatterns01"
    key    = "commons/vpc/terraform.tfstate"
    region = "us-east-2"
  }
}