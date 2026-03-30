# Terraform and provider version requirements (PC-IAC-006)
# The provider alias `aws.project` is declared here for consumption (PC-IAC-005)

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 5.70.0"
      configuration_aliases = [aws.project]
    }
  }
}
