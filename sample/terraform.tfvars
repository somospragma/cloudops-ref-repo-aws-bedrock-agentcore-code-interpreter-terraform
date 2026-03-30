# =============================================================================
# Governance Variables
# =============================================================================

client      = "pragma"
project     = "aiplatform"
environment = "dev"
region      = "us-east-1"

deploy_role_arn = "arn:aws:iam::123456789012:role/terraform-deploy-role"

common_tags = {
  Client      = "pragma"
  Project     = "aiplatform"
  Environment = "dev"
  Owner       = "platform-team"
  CostCenter  = "CC-AI-001"
}

# =============================================================================
# Code Interpreter Configuration
# =============================================================================

code_interpreters = {
  "dataanalysis" = {
    description        = "Code Interpreter for data analysis workloads"
    network_mode       = "SANDBOX"
    execution_role_arn = "" # Injected dynamically from data source in locals.tf
    additional_tags = {
      Team    = "data-science"
      UseCase = "analytics"
    }
  }

  "publicapi" = {
    description  = "Code Interpreter with public network access"
    network_mode = "PUBLIC"
    additional_tags = {
      Team    = "backend"
      UseCase = "api-processing"
    }
  }
}
