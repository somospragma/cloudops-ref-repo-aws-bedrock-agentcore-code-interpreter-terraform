# =============================================================================
# Outputs (PC-IAC-007, PC-IAC-014)
# Granular outputs exposing only ARNs, IDs, and names.
# =============================================================================

output "code_interpreter_arns" {
  description = "Map of Code Interpreter ARNs keyed by configuration key."
  value = {
    for key, ci in aws_bedrockagentcore_code_interpreter.this :
    key => ci.code_interpreter_arn
  }
}

output "code_interpreter_ids" {
  description = "Map of Code Interpreter IDs keyed by configuration key."
  value = {
    for key, ci in aws_bedrockagentcore_code_interpreter.this :
    key => ci.code_interpreter_id
  }
}

output "code_interpreter_names" {
  description = "Map of Code Interpreter names keyed by configuration key."
  value = {
    for key, ci in aws_bedrockagentcore_code_interpreter.this :
    key => ci.name
  }
}
