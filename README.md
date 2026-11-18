# Holiday Tracker database

Scripts de inicialización PostgreSQL para Holiday Tracker. El esquema separa tablas, constraints, triggers y datos de prueba.

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

Compose monta `sql/` en `/docker-entrypoint-initdb.d`; PostgreSQL ejecuta los scripts por orden al crear el volumen por primera vez.

## Estructura

- `sql/00_tables.sql`: definición de tablas.
- `sql/10_constraints.sql`: claves foráneas, unicidad y validaciones.
- `sql/20_triggers.sql`: actualización automática de `updated_at`.
- `sql/30_seed.sql`: oficinas, calendarios, usuarios y vacaciones de prueba.

`usuarios` contiene nombre, apellidos, cargo, email único con validación de formato, tipo de vacaciones, oficina asignada y auditoría temporal. `tipo_vacaciones` identifica la categoría de cada usuario.

La semilla crea las oficinas Madrid y Sevilla, sus calendarios de 2026 y 2027 y los días festivos asociados. También asigna aleatoriamente una oficina a los usuarios de prueba.

## Reinicializar en desarrollo

Los scripts de `/docker-entrypoint-initdb.d` solo se ejecutan cuando el directorio de datos está vacío. Para borrar todos los datos y reiniciar **solo en desarrollo**:

```sh
sh reset-db.sh
```

No ejecutes el reinicio en un entorno con datos que quieras conservar.
