# =============================================================================
# Local Values and Transformations (PC-IAC-003, PC-IAC-009, PC-IAC-012)
# =============================================================================

locals {
  # Governance prefix for naming convention (PC-IAC-003)
  governance_prefix = "${var.client}-${var.project}-${var.environment}"

  # Resource type abbreviation for Code Interpreter
  resource_type = "baci"

  # Construct resource names for each Code Interpreter instance (PC-IAC-003)
  code_interpreter_names = {
    for key, config in var.code_interpreters :
    key => "${local.governance_prefix}-${local.resource_type}-${key}"
  }
}
