terraform {
  backend "s3" {
    bucket  = "ue1devbucketexamensolucion01"
    key     = "authn/terraform.tfstate"
    encrypt = true
  }
}
