# =============================================================================
# Module Invocation (PC-IAC-013, PC-IAC-026)
# =============================================================================

module "code_interpreters" {
  # A. Source
  source = "../"

  # B. Providers (PC-IAC-005)
  providers = {
    aws.project = aws.principal
  }

  # C. Governance Variables (PC-IAC-003)
  client      = var.client
  project     = var.project
  environment = var.environment

  # E. Configuration - Transformed from locals (PC-IAC-026)
  code_interpreters = local.code_interpreters_transformed
}
