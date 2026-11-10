ALTER TABLE usuarios
    ADD CONSTRAINT usuarios_nombre_no_vacio CHECK (length(trim(nombre)) > 0),
    ADD CONSTRAINT usuarios_apellidos_no_vacios CHECK (length(trim(apellidos)) > 0),
    ADD CONSTRAINT usuarios_cargo_no_vacio CHECK (length(trim(cargo)) > 0),
    ADD CONSTRAINT usuarios_email_formato CHECK (
        email ~ '^[^[:space:]@]+@[^[:space:]@]+\.[^[:space:]@]+$'
    ),
    ADD CONSTRAINT usuarios_email_unico UNIQUE (email),
    ADD CONSTRAINT usuarios_tipo_vacaciones_no_vacio CHECK (length(trim(tipo_vacaciones)) > 0);

ALTER TABLE sesiones
    ADD CONSTRAINT sesiones_usuario_fk
        FOREIGN KEY (usuario_id) REFERENCES usuarios (id),
    ADD CONSTRAINT sesiones_usuario_unico UNIQUE (usuario_id),
    ADD CONSTRAINT sesiones_token_hash_unico UNIQUE (token_hash),
    ADD CONSTRAINT sesiones_request_token_hash_unico UNIQUE (request_token_hash),
    ADD CONSTRAINT sesiones_recovery_token_hash_unico UNIQUE (recovery_token_hash),
    ADD CONSTRAINT sesiones_token_hash_sha256 CHECK (token_hash ~ '^[0-9a-f]{64}$'),
    ADD CONSTRAINT sesiones_request_token_hash_sha256
        CHECK (request_token_hash ~ '^[0-9a-f]{64}$'),
    ADD CONSTRAINT sesiones_recovery_token_hash_sha256
        CHECK (recovery_token_hash IS NULL OR recovery_token_hash ~ '^[0-9a-f]{64}$'),
    ADD CONSTRAINT sesiones_estado_valido
        CHECK (estado IN ('solicitado', 'proceso', 'autorizado'));

ALTER TABLE vacaciones
    ADD CONSTRAINT vacaciones_usuario_fk
        FOREIGN KEY (usuario_id) REFERENCES usuarios (id),
    ADD CONSTRAINT vacaciones_anio_valido CHECK (anio BETWEEN 1900 AND 2200),
    ADD CONSTRAINT vacaciones_fecha_corresponde_anio CHECK (EXTRACT(YEAR FROM fecha)::SMALLINT = anio),
    ADD CONSTRAINT vacaciones_usuario_fecha_unica UNIQUE (usuario_id, fecha);

CREATE INDEX vacaciones_usuario_anio_idx ON vacaciones (usuario_id, anio);
