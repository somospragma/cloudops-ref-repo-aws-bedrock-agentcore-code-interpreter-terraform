# =============================================================================
# Data Sources for Dynamic ID Injection (PC-IAC-011, PC-IAC-017)
# =============================================================================

# Retrieve the IAM execution role for Code Interpreter by naming convention
data "aws_iam_role" "code_interpreter_execution" {
  provider = aws.principal
  name     = "${var.client}-${var.project}-${var.environment}-role-baci-execution"
}
