#!/usr/bin/env bash

set -Eeuo pipefail

export DEBIAN_FRONTEND=noninteractive
BOOTSTRAP_LOG="/var/log/bootstrap.log"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
BOOTSTRAP_STEPS=(
  01_install_dependencies.sh
  02_dev_tools.sh
  03_nginx_install.sh
)

exec > >(tee -a "${BOOTSTRAP_LOG}") 2>&1

if [[ "${EUID}" -ne 0 ]]; then
  echo "Este script debe ejecutarse como root."
  exit 1
fi

log() {
  echo "[bootstrap] $1"
}

run_step() {
  local script_name="$1"
  local script_path="${SCRIPT_DIR}/${script_name}"

  if [[ ! -f "${script_path}" ]]; then
    echo "No se encontro el script requerido: ${script_path}" >&2
    exit 1
  fi

  log "Ejecutando ${script_name}..."
  bash "${script_path}"
}

main() {
  local step

  for step in "${BOOTSTRAP_STEPS[@]}"; do
    run_step "${step}"
  done

  log "Configuracion inicial finalizada."
}

main "$@"
