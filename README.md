# AWS Deployment

Repositorio enfocado en automatizar despliegues de infraestructura en AWS mediante Infraestructura como Código, pipelines CI/CD y Bash scripting para el bootstrap de servidores.

## Objetivo

Construir una base reproducible de despliegue que permita:

- Aprovisionar infraestructura en AWS con Terraform.
- Separar configuraciones por ambientes.
- Automatizar la configuración inicial del servidor con Bash.
- Preparar el proyecto para validación y despliegue continuo con GitHub Actions.

## Estado actual

Estado documentado al 27 de agosto de 2026.

### IaC con Terraform

La capa de infraestructura ya evolucionó desde una definición plana a una estructura modular por ambientes dentro de `infraestructure/`.

Hoy existen estos bloques principales:

- `modules/`: módulo reutilizable con la definición base de red y cómputo.
- `environments/testing/`: composición del módulo para ambiente de pruebas.
- `environments/production/`: composición del módulo para ambiente productivo.

El módulo actual incluye:

- Provider AWS configurado por variables.
- VPC principal.
- Subred pública.
- Internet Gateway.
- Tabla de rutas pública.
- Security Group para SSH, HTTP y HTTPS.
- Key Pair para acceso a EC2.
- Instancia EC2 `server_demo`.
- Outputs de red e instancia.

La EC2 utiliza `user_data` para ejecutar el bootstrap del sistema operativo durante el aprovisionamiento.

### Bash scripting

La automatización del servidor ya está más avanzada y hoy se apoya en estos scripts:

- `scripts/01_install_dependencies.sh`: actualiza el sistema e instala dependencias base.
- `scripts/02_dev_tools.sh`: instala herramientas operativas y de desarrollo.
- `scripts/03_nginx_install.sh`: instala y habilita Nginx.
- `scripts/bootstrap.sh`: orquesta el bootstrap completo, registra logs y valida que el entorno sea Ubuntu con `apt`.

En el estado actual, `bootstrap.sh` es el punto de entrada principal del aprovisionamiento de la instancia.

### CI/CD

La estructura de pipelines ya existe en `.github/workflows/`, pero todavía no está implementada a nivel funcional:

- `CI.yml`: workflow base de ejemplo generado por GitHub Actions.
- `deploy-production.yml`: placeholder para el flujo de despliegue a producción.
- `infraestructure.yml`: archivo creado, aún sin jobs configurados.

Esto significa que la automatización de integración y despliegue todavía está pendiente, aunque la base del repositorio ya está preparada para integrarla.

### Componentes complementarios

## Estructura del proyecto

```text
.
|-- .github/
|   `-- workflows/                 # Pipelines CI/CD
|-- infraestructure/
|   |-- environments/
|   |   |-- production/            # Terraform para producción
|   |   `-- testing/               # Terraform para pruebas
|   `-- modules/                   # Módulo reutilizable de infraestructura
|-- scripts/                       # Bootstrap y aprovisionamiento del servidor
`-- README.md
```

## Flujo de trabajo actual

El enfoque actual del proyecto sigue esta secuencia:

1. Seleccionar un ambiente en `infraestructure/environments/`.
2. Ejecutar Terraform usando el módulo común ubicado en `infraestructure/modules/`.
3. Crear la infraestructura base en AWS.
4. Lanzar una instancia EC2 que ejecuta `scripts/bootstrap.sh` mediante `user_data`.
5. Dejar el servidor con dependencias base, herramientas operativas y Nginx instalado.

## Ejecución de Terraform por ambiente

Ejemplo para ambiente de pruebas:

```bash
cd infraestructure/environments/testing
terraform init
terraform plan -var-file="test.tfvars"
terraform apply -var-file="test.tfvars"
```

Ejemplo para ambiente de producción:

```bash
cd infraestructure/environments/production
terraform init
terraform plan -var-file="prod.tfvars"
terraform apply -var-file="prod.tfvars"
```

## Variables y configuración

La infraestructura utiliza variables para definir:

- Región AWS.
- Credenciales de acceso.
- AMI por ambiente.
- Tipo de instancia por ambiente.
- Tags de proyecto, equipo, entorno y propiedad.

Los valores específicos por ambiente se encuentran actualmente en:

- `infraestructure/environments/testing/test.tfvars`
- `infraestructure/environments/production/prod.tfvars`

## Status resumido por componente

- `Terraform`: implementado y modularizado.
- `Ambientes testing/production`: creados.
- `Bootstrap Bash`: implementado de forma inicial y funcional.
- `Nginx`: automatizado en el bootstrap.
- `CI/CD`: estructura creada, implementación pendiente.

## Siguientes pasos recomendados

1. Completar los workflows de GitHub Actions para validar Terraform, scripts y frontend.
2. Definir manejo seguro de credenciales y estado remoto de Terraform.
3. Ajustar diferencias entre ambientes más allá del tipo de instancia y la AMI.
4. Añadir validaciones, linting y políticas de despliegue antes de producción.

## Resumen

El proyecto ya cuenta con una base real para desplegar infraestructura en AWS usando Terraform modular, separación por ambientes y bootstrap automático con Bash. El siguiente salto de madurez planificado es cerrar la capa de CI/CD y endurecer la operación de infraestructura para ambientes más cercanos a producción.
