/*
Code in this file does following:
1. This is main file which has terraform providers, versions, backends details.
2. AWS provioder configuration, on which region resources will be deployed and credentials.
*/

terraform {
  required_version = "~> 1.8.3"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.51.0"
    }
  }

  # this bucket needs to create manually, with versioning enabled
  backend "s3" {
    bucket = "anz-tasks-trfm-bckend-statefile"
    region = "us-east-1"
    key    = "statefile/ec2/terraform.tstate"
  }
}

provider "aws" {
  profile = "default"
  region  = var.anz-tasks-trfm-aws_region
}