# =============================================================================
# Governance Variables
# =============================================================================

variable "client" {
  description = "Client or business unit name."
  type        = string

  validation {
    condition     = length(var.client) > 0 && length(var.client) <= 10
    error_message = "The 'client' variable must be between 1 and 10 characters."
  }
}

variable "project" {
  description = "Project name."
  type        = string

  validation {
    condition     = length(var.project) > 0 && length(var.project) <= 15
    error_message = "The 'project' variable must be between 1 and 15 characters."
  }
}

variable "environment" {
  description = "Deployment environment (dev, qa, pdn)."
  type        = string

  validation {
    condition     = contains(["dev", "qa", "pdn"], var.environment)
    error_message = "The 'environment' variable must be one of: dev, qa, pdn."
  }
}

variable "region" {
  description = "AWS region for deployment."
  type        = string
  default     = "us-east-1"
}

variable "deploy_role_arn" {
  description = "ARN of the IAM role to assume for deployment."
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to all resources via default_tags."
  type        = map(string)
  default     = {}
}

# =============================================================================
# Resource Configuration
# =============================================================================

variable "code_interpreters" {
  description = "Map of Code Interpreter configurations."
  type = map(object({
    description         = optional(string, "")
    network_mode        = string
    execution_role_arn  = optional(string, "")
    vpc_security_groups = optional(list(string), [])
    vpc_subnets         = optional(list(string), [])
    additional_tags     = optional(map(string), {})
  }))
  default = {}
}
