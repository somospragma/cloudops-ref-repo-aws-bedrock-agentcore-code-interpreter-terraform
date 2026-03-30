# =============================================================================
# Bedrock AgentCore Code Interpreter Resources
# (PC-IAC-010: for_each, PC-IAC-020: Security Hardening, PC-IAC-023: Single Responsibility)
# =============================================================================

resource "aws_bedrockagentcore_code_interpreter" "this" {
  provider = aws.project
  for_each = var.code_interpreters

  name        = replace("${local.code_interpreter_names[each.key]}", "-", "_")
  description = length(each.value.description) > 0 ? each.value.description : "Bedrock AgentCore Code Interpreter - ${each.key}"

  execution_role_arn = length(each.value.execution_role_arn) > 0 ? each.value.execution_role_arn : null

  network_configuration {
    network_mode = each.value.network_mode

    dynamic "vpc_config" {
      for_each = each.value.network_mode == "VPC" ? [1] : []
      content {
        security_groups = each.value.vpc_security_groups
        subnets         = each.value.vpc_subnets
      }
    }
  }

  tags = merge(
    { Name = local.code_interpreter_names[each.key] },
    each.value.additional_tags
  )
}
