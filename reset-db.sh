#!/usr/bin/env sh
set -eu

# Borra el esquema de la aplicación y lo reconstruye sin eliminar el volumen de PostgreSQL.

if [ "${1:-}" != "--yes" ]; then
  printf '%s\n' 'ADVERTENCIA: esto borrará permanentemente los datos de la base de datos.'
  printf '%s' 'Escribe ELIMINAR para continuar: '
  IFS= read -r confirmacion
  if [ "$confirmacion" != 'ELIMINAR' ]; then
    printf '%s\n' 'Cancelado; no se modificó la base de datos.'
    exit 1
  fi
fi

docker compose exec -T db sh -c 'psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d "$POSTGRES_DB"' <<'SQL'
DROP TABLE IF EXISTS vacaciones, sesiones, usuarios CASCADE;
DROP FUNCTION IF EXISTS actualizar_updated_at() CASCADE;
SQL

docker compose exec -T db sh -c '
  for archivo in /docker-entrypoint-initdb.d/*.sql; do
    psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f "$archivo"
  done
'

printf '%s\n' 'Base de datos reinicializada.'
