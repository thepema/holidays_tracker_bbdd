#!/usr/bin/env sh
set -eu

# Elimina el volumen de PostgreSQL y lo vuelve a crear desde cero.
# Los scripts de ./sql se ejecutarán nuevamente al inicializar el volumen.

if [ "${1:-}" != "--yes" ]; then
  printf '%s\n' 'ADVERTENCIA: esto borrará permanentemente todos los datos de la base PostgreSQL.'
  printf '%s' 'Escribe ELIMINAR para continuar: '
  IFS= read -r confirmacion
  if [ "$confirmacion" != 'ELIMINAR' ]; then
    printf '%s\n' 'Cancelado; no se modificó la base de datos.'
    exit 1
  fi
fi

docker compose down --volumes
docker compose up -d
