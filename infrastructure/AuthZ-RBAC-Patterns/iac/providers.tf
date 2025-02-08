terraform {
  required_version = ">= 1.4.2"

  required_providers {
    local = {
      source = "hashicorp/local"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.38"
    }
  }
}
/*
provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}*/

/*
provider "aws" {
  #alias = "virginia"
  region  = "us-east-2"
  default_tags {
    tags = local.tags
  }
}
*/

data "aws_region" "current" {}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "aws" {
  region = data.aws_region.current.id
  alias  = "default" # this should match the named profile you used if at all
}

provider "kubernetes" {
  experiments {
    manifest_resource = true
  }
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    token                  = data.aws_eks_cluster_auth.cluster.token
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  }
}