terraform {
    backend "s3" {
    bucket  = "ue2devbucketdesignpatterns01"
    key     = "authz-rbac/terraform.tfstate"
    region  = "us-east-2"
  }
}