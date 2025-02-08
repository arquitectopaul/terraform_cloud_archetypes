terraform {
  backend "s3" {
    bucket  = "uw2devbucketdesignpatterns01"
    key     = "commons/route53/terraform.tfstate"
    encrypt = true
  }
}
