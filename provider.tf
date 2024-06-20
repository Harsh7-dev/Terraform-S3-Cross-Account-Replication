terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
}

provider "aws" {
  shared_config_files      = ["/path/to/.aws/config"]
  shared_credentials_files = ["/path/to/.aws/credentials"]
  profile                  = "source"
  region                   = var.region
  alias                    = "source"
}

provider "aws" {
  shared_config_files      = ["/path/to/.aws/config"]
  shared_credentials_files = ["/path/to/.aws/credentials"]
  profile                  = "destination"
  region                   = var.region
  alias                    = "destination"
}
