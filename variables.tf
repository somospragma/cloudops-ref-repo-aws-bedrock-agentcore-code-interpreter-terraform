# =============================================================================
# Governance Variables (PC-IAC-002, PC-IAC-003)
# =============================================================================

variable "client" {
  description = "Client or business unit name used for resource naming and tagging."
  type        = string

  validation {
    condition     = length(var.client) > 0 && length(var.client) <= 10
    error_message = "The 'client' variable must be between 1 and 10 characters."
  }
}

variable "project" {
  description = "Project name used for resource naming and tagging."
  type        = string

  validation {
    condition     = length(var.project) > 0 && length(var.project) <= 15
    error_message = "The 'project' variable must be between 1 and 15 characters."
  }
}

variable "environment" {
  description = "Deployment environment identifier (dev, qa, pdn)."
  type        = string

  validation {
    condition     = contains(["dev", "qa", "pdn"], var.environment)
    error_message = "The 'environment' variable must be one of: dev, qa, pdn."
  }
}

# =============================================================================
# Resource Configuration (PC-IAC-002, PC-IAC-009, PC-IAC-010)
# =============================================================================

variable "code_interpreters" {
  description = <<-EOT
    Map of Bedrock AgentCore Code Interpreter configurations.
    Each key represents a unique Code Interpreter instance.
    The key is used as the {key} component in the naming convention.
  EOT

  type = map(object({
    description         = optional(string, "")
    network_mode        = string
    execution_role_arn  = optional(string, "")
    vpc_security_groups = optional(list(string), [])
    vpc_subnets         = optional(list(string), [])
    additional_tags     = optional(map(string), {})
  }))

  default = {}

  validation {
    condition = alltrue([
      for key, config in var.code_interpreters :
      contains(["PUBLIC", "SANDBOX", "VPC"], config.network_mode)
    ])
    error_message = "The 'network_mode' must be one of: PUBLIC, SANDBOX, VPC."
  }

  validation {
    condition = alltrue([
      for key, config in var.code_interpreters :
      config.network_mode != "VPC" || (length(config.vpc_security_groups) > 0 && length(config.vpc_subnets) > 0)
    ])
    error_message = "When 'network_mode' is VPC, 'vpc_security_groups' and 'vpc_subnets' must be provided."
  }

  validation {
    condition = alltrue([
      for key, config in var.code_interpreters :
      length(key) > 0 && length(key) <= 20
    ])
    error_message = "Each Code Interpreter key must be between 1 and 20 characters."
  }
}
