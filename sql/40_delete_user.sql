-- Elimina un usuario y sus datos asociados (vacaciones y sesión).
-- Uso: psql "$DATABASE_URL" -v usuario_id=123 -f sql/40_delete_user.sql
-- Revisa el ID antes de ejecutar; la operación es irreversible una vez confirmada.

BEGIN;

DELETE FROM vacaciones
WHERE usuario_id = :'usuario_id'::BIGINT;

DELETE FROM sesiones
WHERE usuario_id = :'usuario_id'::BIGINT;

DELETE FROM usuarios
WHERE id = :'usuario_id'::BIGINT;

COMMIT;
