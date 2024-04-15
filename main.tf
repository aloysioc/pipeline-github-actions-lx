terraform {

  required_version = ">= 1.0.0"

  required_providers {

    # azurerm = {
    #   source  = "hashicorp/azurerm"
    #   version = "3.3.0"
    # }

    aws = {
      source  = "hashicorp/aws"
      version = "4.11.0"
    }
  }

  backend "s3" {
    bucket = "ce-mapfre"
    key    = "ce/aws-vm-lx/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      owner      = "Aloysio Coutinho"
      managed-by = "terraform"
      projeto    = "CE Mapfre"
    }
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "ce-mapfre"
    key    = "ce/aws-vpc/terraform.tfstate"
    region = "us-east-1"
  }
}