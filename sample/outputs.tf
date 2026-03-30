# =============================================================================
# Outputs (PC-IAC-007)
# =============================================================================

output "code_interpreter_arns" {
  description = "Map of Code Interpreter ARNs."
  value       = module.code_interpreters.code_interpreter_arns
}

output "code_interpreter_ids" {
  description = "Map of Code Interpreter IDs."
  value       = module.code_interpreters.code_interpreter_ids
}

output "code_interpreter_names" {
  description = "Map of Code Interpreter names."
  value       = module.code_interpreters.code_interpreter_names
}
