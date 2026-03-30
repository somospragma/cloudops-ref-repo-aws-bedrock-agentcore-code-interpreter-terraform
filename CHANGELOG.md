# Changelog

All notable changes to this module will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0] - 2026-03-27

### Added

- Initial release of the Bedrock AgentCore Code Interpreter module.
- Support for creating multiple Code Interpreter instances via `for_each` with `map(object)`.
- Network configuration support: `PUBLIC`, `SANDBOX`, and `VPC` modes.
- Optional VPC configuration with security groups and subnets.
- Optional execution role ARN injection.
- Governance naming via `locals.tf` (PC-IAC-003).
- Tag management with `Name` and `additional_tags` merge (PC-IAC-004).
- Provider alias `aws.project` (PC-IAC-005).
- Granular outputs: ARNs, IDs, and names (PC-IAC-007).
