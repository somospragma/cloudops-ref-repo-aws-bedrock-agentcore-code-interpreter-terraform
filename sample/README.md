# Ejemplo de Uso - Bedrock AgentCore Code Interpreter Module

Este directorio contiene un ejemplo funcional que demuestra cómo consumir el módulo de referencia siguiendo el patrón de transformación PC-IAC-026.

## Flujo de Datos

```
terraform.tfvars → variables.tf → data.tf → locals.tf → main.tf → ../
```

## Pre-requisitos

- Terraform >= 1.5.0
- AWS CLI configurado con credenciales válidas
- VPC existente con tags de nomenclatura estándar (para modo VPC)
- Rol IAM existente con permisos para Bedrock AgentCore (para modos SANDBOX/VPC)

## Ejecución

```bash
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

## Limpieza

```bash
terraform destroy -var-file="terraform.tfvars"
```
