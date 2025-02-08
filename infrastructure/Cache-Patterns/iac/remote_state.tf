terraform {
  backend "s3" {
    bucket  = "ue2devbucketdesignpatterns01"
    key     = "cacheelastic-redis/terraform.tfstate"
    encrypt        = true
  }
}