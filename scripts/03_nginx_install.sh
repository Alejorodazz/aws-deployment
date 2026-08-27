#!/usr/bin/env bash

set -Eeuo pipefail

NGINX_PACKAGES=(
  nginx
)

if [[ "${EUID}" -ne 0 ]]; then
  echo "Este script debe ejecutarse como root o con sudo."
  exit 1
fi

log() {
  echo "[03] $1"
}

require_apt() {
  if ! command -v apt-get >/dev/null 2>&1; then
    echo "Ubuntu Server LTS con apt es requerido para este script." >&2
    exit 1
  fi
}

install_nginx() {
  apt-get install -y "${NGINX_PACKAGES[@]}"
}

configure_nginx_service() {
  systemctl enable nginx
  systemctl restart nginx
  nginx -t
}

main() {
  require_apt

  log "Instalando Nginx..."
  install_nginx

  log "Activando servicio Nginx..."
  configure_nginx_service

  log "Nginx listo."
}

main "$@"
