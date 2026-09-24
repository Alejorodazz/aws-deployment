#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 2 || $# -gt 3 ]]; then
  echo "Uso: $0 <testing|production> <init|validate|plan|apply|destroy> [archivo.tfvars]" >&2
  exit 64
fi

environment="$1"
command="$2"
var_file="${3:-}"
script_directory="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
project_directory="$(cd -- "${script_directory}/.." && pwd)"
env_file="${project_directory}/.env"
environment_directory="${script_directory}/environments/${environment}"

case "${environment}" in
  testing|production) ;;
  *)
    echo "Ambiente no valido: ${environment}" >&2
    exit 64
    ;;
esac

case "${command}" in
  init|validate|plan|apply|destroy) ;;
  *)
    echo "Comando no valido: ${command}" >&2
    exit 64
    ;;
esac

if [[ ! -f "${env_file}" ]]; then
  echo "No se encontro .env en ${env_file}." >&2
  exit 1
fi

# Load simple KEY=VALUE entries without evaluating .env as shell code.
while IFS= read -r line || [[ -n "${line}" ]]; do
  line="${line%$'\r'}"
  [[ -z "${line}" || "${line}" == \#* ]] && continue
  line="${line#export }"

  if [[ "${line}" != *=* ]]; then
    echo "Entrada .env invalida." >&2
    exit 1
  fi

  key="${line%%=*}"
  value="${line#*=}"
  key="${key//[[:space:]]/}"
  value="${value#"${value%%[![:space:]]*}"}"
  value="${value%"${value##*[![:space:]]}"}"

  if [[ "${value}" =~ ^\".*\"$ || "${value}" =~ ^\'.*\'$ ]]; then
    value="${value:1:${#value}-2}"
  fi

  export "${key}=${value}"
done < "${env_file}"

if [[ -z "${CLOUDFLARE_API_TOKEN:-}" ]]; then
  echo ".env debe definir CLOUDFLARE_API_TOKEN." >&2
  exit 1
fi

terraform_arguments=("${command}")
case "${command}" in
  plan)
    if [[ -n "${var_file}" ]]; then
      terraform_arguments+=("-var-file=${var_file}")
    fi
    ;;
  apply|destroy)
    terraform_arguments+=("-auto-approve")
    if [[ -n "${var_file}" ]]; then
      terraform_arguments+=("-var-file=${var_file}")
    fi
    ;;
esac

cd "${environment_directory}"
terraform "${terraform_arguments[@]}"
