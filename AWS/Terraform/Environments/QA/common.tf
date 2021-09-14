provider "aws" {
  version = "~> 3.32.0"

  region                  = var.region
  shared_credentials_file = "./../credentials"
  profile                 = "default"
} 