#!/usr/bin/env bash

set -Eeuo pipefail

BASE_PACKAGES=(
  apt-transport-https
  bash-completion
  ca-certificates
  curl
  gnupg
  lsb-release
  software-properties-common
  tar
  unzip
  wget
  zip
)

if [[ "${EUID}" -ne 0 ]]; then
  echo "Este script debe ejecutarse como root o con sudo."
  exit 1
fi

export DEBIAN_FRONTEND=noninteractive

log() {
  echo "[01] $1"
}

require_apt() {
  if ! command -v apt-get >/dev/null 2>&1; then
    echo "Ubuntu Server LTS con apt es requerido para este script." >&2
    exit 1
  fi
}

update_system() {
  apt-get update -y
  apt-get upgrade -y
}

install_base_dependencies() {
  apt-get install -y "${BASE_PACKAGES[@]}"
}

main() {
  require_apt

  log "Actualizando repositorios y paquetes del sistema..."
  update_system

  log "Instalando dependencias base..."
  install_base_dependencies

  log "Dependencias base instaladas."
}

main "$@"


