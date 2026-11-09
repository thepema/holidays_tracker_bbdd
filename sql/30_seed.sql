INSERT INTO usuarios (nombre, apellidos, cargo) VALUES
    ('Ana', 'García López', 'Administradora'),
    ('Luis', 'Martínez Ruiz', 'Desarrollador'),
    ('Marta', 'Sánchez Pérez', 'Recursos Humanos');

INSERT INTO vacaciones (usuario_id, anio, fecha) VALUES
    (1, 2026, DATE '2026-08-10'),
    (1, 2026, DATE '2026-08-11'),
    (2, 2026, DATE '2026-12-24'),
    (3, 2026, DATE '2026-07-20');
