terraform {
  backend "s3" {
    bucket  = "ue1devbucketexamensolucion01"
    key     = "common/vpc/terraform.tfstate"
    encrypt = true
  }
}
