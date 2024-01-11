variable "cluster_name" {
  default = "karpenter-terraform"
}

# provider "aws" {
#   region = "ap-south-1"
# }

terraform {
  required_version = "~> 1.0"

  required_providers {
    # aws = {
    #   source  = "hashicorp/aws"
    #   version = "~> 4.0"
    # }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.6"
    }
  }
}
