INSERT INTO usuarios (nombre, apellidos, cargo, email) VALUES
    ('Ana', 'García López', 'Administradora', 'ana.garcia@example.test'),
    ('Luis', 'Martínez Ruiz', 'Desarrollador', 'luis.martinez@example.test'),
    ('Marta', 'Sánchez Pérez', 'Recursos Humanos', 'marta.sanchez@example.test');

INSERT INTO vacaciones (usuario_id, anio, fecha) VALUES
    (1, 2026, DATE '2026-08-10'),
    (1, 2026, DATE '2026-08-11'),
    (2, 2026, DATE '2026-12-24'),
    (3, 2026, DATE '2026-07-20');
