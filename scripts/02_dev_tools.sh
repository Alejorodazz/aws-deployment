#!/usr/bin/env bash

set -Eeuo pipefail

DEV_PACKAGES=(
  git
  htop
  jq
  nano
  neofetch
  neovim
  net-tools
  tree
)

if [[ "${EUID}" -ne 0 ]]; then
  echo "Este script debe ejecutarse como root o con sudo."
  exit 1
fi

log() {
  echo "[02] $1"
}

require_apt() {
  if ! command -v apt-get >/dev/null 2>&1; then
    echo "Ubuntu Server LTS con apt es requerido para este script." >&2
    exit 1
  fi
}

install_dev_tools() {
  apt-get install -y "${DEV_PACKAGES[@]}"
}

main() {
  require_apt

  log "Instalando herramientas operativas y de desarrollo..."
  install_dev_tools

  log "Herramientas instaladas."
}

main "$@"
