\set ON_ERROR_STOP on

-- Reinicializa el esquema y los datos de desarrollo.
-- Ejecutar con psql desde el contenedor de PostgreSQL.

DROP TABLE IF EXISTS vacaciones, sesiones, usuarios, equipos CASCADE;
DROP FUNCTION IF EXISTS actualizar_updated_at() CASCADE;

\i /docker-entrypoint-initdb.d/00_tables.sql
\i /docker-entrypoint-initdb.d/10_constraints.sql
\i /docker-entrypoint-initdb.d/20_triggers.sql
\i /docker-entrypoint-initdb.d/30_seed.sql
