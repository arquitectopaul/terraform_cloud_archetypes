terraform {
  backend "s3" {
    bucket  = "uw2devbucketdesignpatterns01"
    key     = "commons/eks/terraform.tfstate"
    encrypt = true
  }
}
