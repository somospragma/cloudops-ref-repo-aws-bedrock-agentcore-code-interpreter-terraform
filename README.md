# Bedrock AgentCore Code Interpreter Module

Módulo de Referencia Terraform para la creación y gestión de instancias de **Amazon Bedrock AgentCore Code Interpreter**. Este servicio proporciona un entorno seguro para que los agentes de IA ejecuten código Python, habilitando análisis de datos, cálculos y procesamiento de archivos.

## Uso

```hcl
module "code_interpreters" {
  source = "git::https://github.com/org/bedrock-agentcore-code-interpreter-module.git?ref=v1.0.0"

  providers = {
    aws.project = aws.principal
  }

  client      = var.client
  project     = var.project
  environment = var.environment

  code_interpreters = local.code_interpreters_transformed
}
```

## Inputs

| Variable | Tipo | Requerido | Default | Descripción |
|----------|------|-----------|---------|-------------|
| `client` | `string` | Sí | - | Nombre del cliente (máx. 10 caracteres). |
| `project` | `string` | Sí | - | Nombre del proyecto (máx. 15 caracteres). |
| `environment` | `string` | Sí | - | Ambiente de despliegue: `dev`, `qa`, `pdn`. |
| `code_interpreters` | `map(object)` | No | `{}` | Mapa de configuraciones de Code Interpreter. |

### Estructura de `code_interpreters`

| Atributo | Tipo | Requerido | Default | Descripción |
|----------|------|-----------|---------|-------------|
| `description` | `string` | No | `""` | Descripción del Code Interpreter. |
| `network_mode` | `string` | Sí | - | Modo de red: `PUBLIC`, `SANDBOX`, `VPC`. |
| `execution_role_arn` | `string` | No | `""` | ARN del rol IAM de ejecución. |
| `vpc_security_groups` | `list(string)` | No | `[]` | Security Groups (requerido si `network_mode = VPC`). |
| `vpc_subnets` | `list(string)` | No | `[]` | Subnets (requerido si `network_mode = VPC`). |
| `additional_tags` | `map(string)` | No | `{}` | Tags adicionales para el recurso. |

## Outputs

| Output | Tipo | Descripción |
|--------|------|-------------|
| `code_interpreter_arns` | `map(string)` | Mapa de ARNs de los Code Interpreters. |
| `code_interpreter_ids` | `map(string)` | Mapa de IDs de los Code Interpreters. |
| `code_interpreter_names` | `map(string)` | Mapa de nombres de los Code Interpreters. |

## Requisitos

| Requisito | Versión |
|-----------|---------|
| Terraform | `>= 1.5.0` |
| AWS Provider | `>= 5.70.0` |

## Modos de Red

- **PUBLIC**: Permite acceso a recursos de internet público. No requiere rol de ejecución.
- **SANDBOX**: Entorno aislado con acceso limitado a red externa. Requiere `execution_role_arn`.
- **VPC**: Configuración dentro de una VPC existente. Requiere `vpc_security_groups`, `vpc_subnets` y `execution_role_arn`.

## Cumplimiento PC-IAC

| Regla | Implementación |
|-------|----------------|
| PC-IAC-001 | Estructura completa de 10 archivos raíz + 8 archivos en `sample/`. |
| PC-IAC-002 | Variables con `type`, `description`, `validation`. Uso de `map(object)` con `optional()`. |
| PC-IAC-003 | Nomenclatura `{client}-{project}-{environment}-baci-{key}` construida en `locals.tf`. |
| PC-IAC-004 | Tag `Name` explícito + merge con `additional_tags` en cada recurso. |
| PC-IAC-005 | Provider alias `aws.project` declarado en `versions.tf` y referenciado en recursos. |
| PC-IAC-010 | Uso de `for_each` con `map(object)` para estabilidad del estado. |
| PC-IAC-014 | Bloque `dynamic` para `vpc_config` condicional según `network_mode`. |
| PC-IAC-020 | Modo `SANDBOX` por defecto recomendado. VPC mode para aislamiento máximo. |
| PC-IAC-023 | Solo crea recursos intrínsecos al Code Interpreter. IAM Roles, SGs y VPCs se inyectan. |
| PC-IAC-026 | Directorio `sample/` con patrón de transformación completo. |

## Decisiones de Diseño

1. **Abreviatura de recurso `baci`**: Se utiliza `baci` (Bedrock AgentCore Code Interpreter) como abreviatura estándar para mantener los nombres dentro del límite de 28 caracteres.
2. **Rol de ejecución como variable de entrada**: Siguiendo PC-IAC-023, el módulo no crea roles IAM. El ARN del rol se recibe como variable, delegando la responsabilidad al dominio de Seguridad.
3. **VPC config como bloque dinámico**: Se usa `dynamic` (PC-IAC-014) para generar el bloque `vpc_config` solo cuando `network_mode = VPC`, evitando configuraciones innecesarias.
4. **Validaciones cruzadas**: Se valida que cuando `network_mode = VPC`, los campos `vpc_security_groups` y `vpc_subnets` no estén vacíos, previniendo errores en tiempo de plan.
