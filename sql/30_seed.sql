INSERT INTO usuarios (nombre, apellidos, cargo, email, tipo_vacaciones) VALUES
    ('Ana', 'García López', 'Administradora', 'ana.garcia@example.test', 'estandar'),
    ('Luis', 'Martínez Ruiz', 'Desarrollador', 'luis.martinez@example.test', 'estandar'),
    ('Marta', 'Sánchez Pérez', 'Recursos Humanos', 'marta.sanchez@example.test', 'estandar');

INSERT INTO vacaciones (usuario_id, anio, fecha) VALUES
    (1, 2026, DATE '2026-08-10'),
    (1, 2026, DATE '2026-08-11'),
    (2, 2026, DATE '2026-12-24'),
    (3, 2026, DATE '2026-07-20');
