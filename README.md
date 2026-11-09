# Holiday Tracker database

Scripts de inicialización PostgreSQL para Holiday Tracker. El esquema separa tablas, constraints, triggers y datos de prueba. Los tokens se almacenan como hashes SHA-256; nunca guardes tokens en texto plano.

## Requisitos

- Docker Engine y Docker Compose v2.
- Puerto local `5432` disponible (o configura `POSTGRES_PORT` en `.env`).

## Iniciar la base de datos

```sh
cp .env.example .env
# Cambia POSTGRES_PASSWORD por una contraseña local segura.
docker network create --internal backend-network
docker compose up -d
```

Compose monta `sql/` en `/docker-entrypoint-initdb.d`; PostgreSQL ejecuta los scripts por orden al crear el volumen por primera vez. La base queda accesible desde contenedores en `backend-network` con host `holiday-tracker-db`, puerto `5432`. Para el backend configura `DB_HOST=holiday-tracker-db`, `DB_PORT=5432`, `DB_NAME`, `DB_USER` y `DB_PASSWORD` según `.env`.

Desde el host, el puerto se publica solo en `127.0.0.1`. Comprueba el servicio con:

```sh
docker compose ps
docker compose exec db pg_isready -U "$POSTGRES_USER" -d "$POSTGRES_DB"
```

## Estructura

- `sql/00_tables.sql`: definición de tablas.
- `sql/10_constraints.sql`: claves foráneas, unicidad y validaciones.
- `sql/20_triggers.sql`: actualización automática de `updated_at`.
- `sql/30_seed.sql`: usuarios y vacaciones de prueba.

`usuarios` contiene nombre, apellidos, cargo, email único con validación de formato y auditoría temporal (`created_at`, `updated_at`). `sesiones` tiene una relación 1:1 con usuario, token de sesión, token de recuperación opcional y estado (`solicitado`, `proceso`, `autorizado`). `vacaciones` registra fechas por usuario y año.

Los datos de prueba no incluyen credenciales ni sesiones válidas. Si se agrega autenticación, almacena la contraseña como hash resistente (por ejemplo Argon2id) y los tokens como hashes; nunca uses los valores de prueba en producción.

## Reinicializar en desarrollo

Los scripts de `/docker-entrypoint-initdb.d` solo se ejecutan cuando el directorio de datos está vacío. Para borrar todos los datos y reiniciar **solo en desarrollo**:

```sh
sh reset-db.sh
```

No ejecutes el reinicio en un entorno con datos que quieras conservar. Mantén `.env` fuera de Git y cambia todas las credenciales de ejemplo antes de cualquier despliegue real.
