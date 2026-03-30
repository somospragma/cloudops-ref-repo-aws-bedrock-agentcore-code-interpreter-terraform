# =============================================================================
# Transformations and Dynamic Injection (PC-IAC-009, PC-IAC-025, PC-IAC-026)
# =============================================================================

locals {
  # Governance prefix (PC-IAC-025)
  governance_prefix = "${var.client}-${var.project}-${var.environment}"

  # Transform code_interpreters config: inject execution_role_arn from data source
  # when the field is empty (PC-IAC-009, PC-IAC-026)
  code_interpreters_transformed = {
    for key, config in var.code_interpreters : key => merge(config, {
      execution_role_arn = length(config.execution_role_arn) > 0 ? config.execution_role_arn : (
        config.network_mode != "PUBLIC" ? data.aws_iam_role.code_interpreter_execution.arn : ""
      )
    })
  }
}
