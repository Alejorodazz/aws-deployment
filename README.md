# AWS Deployment

Proyecto orientado a la automatización de infraestructura en AWS mediante IaC, flujos CI/CD y Bash scripting para acelerar el aprovisionamiento, la configuración inicial y la futura operación del entorno.

## Objetivo del proyecto

Construir una base de despliegue reproducible para AWS que permita:

- Definir infraestructura como código con Terraform.
- Automatizar validaciones, builds y despliegues con pipelines CI/CD.
- Usar Bash scripting para el bootstrap de servidores y la instalación de componentes base.
- Dejar una estructura reutilizable para ambientes de laboratorio, pruebas y evolución hacia producción.

## Status actual del proyecto

Estado documentado al 27 de agosto de 2026.

### 1. Infraestructura como código (IaC)

Actualmente el repositorio ya cuenta con una base funcional en Terraform dentro de `infraestructure/` para aprovisionar recursos en AWS:

- Provider AWS configurado por variables.
- VPC principal.
- Subred pública.
- Subred privada.
- Internet Gateway.
- Tabla de rutas pública y asociación.
- Security Group con reglas para SSH, HTTP y HTTPS.
- Key Pair para acceso a la instancia.
- Instancia EC2 `server_demo`.
- Outputs para IP pública, tipo de instancia y bloque CIDR de la VPC.

En este momento, la instancia EC2 consume un script Bash vía `user_data` para instalar Nginx al momento del aprovisionamiento.

### 2. Bash scripting

La carpeta `scripts/` ya define la intención de automatizar la configuración inicial del servidor:

- `03_nginx_install.sh`: instala, habilita y arranca Nginx.
- `01_install_dependencies.sh`: incluye una base inicial para actualización del sistema e instalación de dependencias.
- `02_dev_tools.sh`: creado pero aún sin contenido.
- `bootstrap.sh`: creado pero aún sin contenido.

Esto indica que el proyecto ya empezó a integrar aprovisionamiento declarativo con configuración automatizada del sistema operativo, aunque los scripts todavía están en fase inicial.

### 3. Pipelines CI/CD

La estructura de GitHub Actions ya existe en `.github/workflows/`, pero su implementación todavía está incompleta:

- `CI.yml`: pipeline base generado, hoy solo ejecuta pasos de ejemplo.
- `deploy-production.yml`: archivo placeholder para despliegue a producción.
- `infraestructure.yml`: archivo creado, actualmente vacío.

Conclusión: el pipeline está planteado a nivel estructural, pero aún no automatiza validación de Terraform, linting, testing, build ni despliegues reales.

### 4. Componentes complementarios

El repositorio también incluye piezas de soporte que todavía están en evolución:

- `react-app/`: aplicación base con React + Vite.
- `docker/`: archivos iniciales para contenerización.

Por ahora, estos componentes funcionan más como base de trabajo que como una solución cerrada e integrada con la infraestructura.

## Estado general resumido

El proyecto ya tiene una dirección técnica clara y una primera implementación de IaC en AWS. La parte más avanzada hoy es Terraform, seguida por el uso inicial de Bash para bootstrap. La capa de CI/CD aún está en etapa de diseño y necesita completarse para cerrar el ciclo de automatización.

## Objetivo inmediato

Las siguientes metas consolidan el alcance actual del repositorio:

1. Completar los scripts de bootstrap para dejar la instancia lista automáticamente.
2. Formalizar pipelines de CI para validar Terraform, scripts y frontend.
3. Crear pipelines de CD para desplegar infraestructura de forma controlada por ambiente.
4. Mejorar la integración entre infraestructura, aplicación y contenedores.
5. Evolucionar el proyecto desde un laboratorio funcional hacia una base operativa más cercana a producción.

## Estructura principal

```text
.
|-- .github/workflows/      # Pipelines CI/CD
|-- infraestructure/        # Terraform para AWS
|-- scripts/                # Bash scripting para bootstrap
|-- docker/                 # Base de contenedorización
|-- react-app/              # Aplicación frontend de ejemplo
`-- README.md
```

## Resumen ejecutivo

Este repositorio documenta un proyecto en desarrollo para montar infraestructura en AWS con enfoque DevOps. Ya existe una base de Terraform para levantar red y cómputo, junto con primeros scripts Bash para configuración del servidor. El siguiente paso clave es completar la automatización CI/CD para convertir esta base en un flujo de despliegue repetible, validable y escalable.
