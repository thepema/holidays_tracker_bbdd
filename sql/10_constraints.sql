ALTER TABLE oficinas
    ADD CONSTRAINT oficinas_nombre_no_vacio CHECK (length(trim(nombre)) > 0),
    ADD CONSTRAINT oficinas_nombre_unico UNIQUE (nombre);

ALTER TABLE usuarios
    ADD CONSTRAINT usuarios_nombre_no_vacio CHECK (length(trim(nombre)) > 0),
    ADD CONSTRAINT usuarios_apellidos_no_vacios CHECK (length(trim(apellidos)) > 0),
    ADD CONSTRAINT usuarios_cargo_no_vacio CHECK (length(trim(cargo)) > 0),
    ADD CONSTRAINT usuarios_email_formato CHECK (
        email ~ '^[^[:space:]@]+@[^[:space:]@]+\.[^[:space:]@]+$'
    ),
    ADD CONSTRAINT usuarios_email_unico UNIQUE (email),
    ADD CONSTRAINT usuarios_codigo_positivo CHECK (codigo IS NULL OR codigo > 0),
    ADD CONSTRAINT usuarios_codigo_unico UNIQUE (codigo),
    ADD CONSTRAINT usuarios_tipo_vacaciones_no_vacio CHECK (length(trim(tipo_vacaciones)) > 0),
    ADD CONSTRAINT usuarios_oficina_fk
        FOREIGN KEY (oficina_id) REFERENCES oficinas (id) ON DELETE SET NULL;

ALTER TABLE usuarios_equipos
    ADD CONSTRAINT usuarios_equipos_usuario_fk
        FOREIGN KEY (usuario_id) REFERENCES usuarios (id) ON DELETE CASCADE,
    ADD CONSTRAINT usuarios_equipos_equipo_fk
        FOREIGN KEY (equipo_id) REFERENCES equipos (id) ON DELETE CASCADE;

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

ALTER TABLE calendarios_oficina
    ADD CONSTRAINT calendarios_oficina_oficina_fk
        FOREIGN KEY (oficina_id) REFERENCES oficinas (id) ON DELETE CASCADE,
    ADD CONSTRAINT calendarios_oficina_anio_valido CHECK (anio BETWEEN 1900 AND 2200),
    ADD CONSTRAINT calendarios_oficina_anio_unico UNIQUE (oficina_id, anio);

ALTER TABLE dias_festivos
    ADD CONSTRAINT dias_festivos_calendario_fk
        FOREIGN KEY (calendario_id) REFERENCES calendarios_oficina (id) ON DELETE CASCADE,
    ADD CONSTRAINT dias_festivos_nombre_no_vacio CHECK (length(trim(nombre)) > 0),
    ADD CONSTRAINT dias_festivos_fecha_unica UNIQUE (calendario_id, fecha);

CREATE INDEX usuarios_equipos_equipo_id_idx ON usuarios_equipos (equipo_id);
CREATE INDEX usuarios_oficina_id_idx ON usuarios (oficina_id);
CREATE INDEX vacaciones_fecha_idx ON vacaciones (fecha);
CREATE INDEX vacaciones_usuario_anio_idx ON vacaciones (usuario_id, anio);
CREATE INDEX calendarios_oficina_anio_idx ON calendarios_oficina (anio);
