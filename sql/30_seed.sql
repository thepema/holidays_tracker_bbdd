INSERT INTO usuarios (nombre, apellidos, cargo, email, tipo_vacaciones) VALUES
    ('Ana', 'García López', 'Administradora', 'ana.garcia@example.test', 'estandar'),
    ('Luis', 'Martínez Ruiz', 'Desarrollador', 'luis.martinez@example.test', 'estandar'),
    ('Marta', 'Sánchez Pérez', 'Recursos Humanos', 'marta.sanchez@example.test', 'estandar'),
    ('Carlos', 'Fernández Martín', 'Desarrollador', 'carlos.fernandez@example.test', 'estandar'),
    ('Lucía', 'Gómez Navarro', 'Diseñadora UX', 'lucia.gomez@example.test', 'estandar'),
    ('Javier', 'Díaz Romero', 'Analista de datos', 'javier.diaz@example.test', 'estandar'),
    ('Elena', 'Álvarez Torres', 'Responsable de producto', 'elena.alvarez@example.test', 'estandar'),
    ('Pablo', 'Moreno Gil', 'Desarrollador', 'pablo.moreno@example.test', 'estandar'),
    ('Sara', 'Jiménez Ortega', 'Especialista de marketing', 'sara.jimenez@example.test', 'estandar'),
    ('Diego', 'Ruiz Castro', 'Administrador de sistemas', 'diego.ruiz@example.test', 'estandar'),
    ('Paula', 'Hernández Muñoz', 'Contable', 'paula.hernandez@example.test', 'estandar'),
    ('Andrés', 'Romero Iglesias', 'Desarrollador', 'andres.romero@example.test', 'estandar'),
    ('Nerea', 'Navarro Rubio', 'Técnica de soporte', 'nerea.navarro@example.test', 'estandar'),
    ('Miguel', 'Torres Molina', 'Arquitecto de software', 'miguel.torres@example.test', 'estandar'),
    ('Claudia', 'Domínguez Serrano', 'Diseñadora gráfica', 'claudia.dominguez@example.test', 'estandar'),
    ('Alberto', 'Vázquez Ramos', 'Responsable de ventas', 'alberto.vazquez@example.test', 'estandar'),
    ('Irene', 'Ramos Blanco', 'Especialista de comunicación', 'irene.ramos@example.test', 'estandar'),
    ('Sergio', 'Gil Santos', 'Desarrollador', 'sergio.gil@example.test', 'estandar'),
    ('Ainhoa', 'Castro Pascual', 'Técnica de selección', 'ainhoa.castro@example.test', 'estandar'),
    ('Raúl', 'Molina Vidal', 'Analista financiero', 'raul.molina@example.test', 'estandar'),
    ('Carmen', 'Morales León', 'Gestora de proyectos', 'carmen.morales@example.test', 'estandar'),
    ('Iván', 'Ortega Delgado', 'Desarrollador', 'ivan.ortega@example.test', 'estandar'),
    ('Noelia', 'Delgado Ortiz', 'Especialista de atención al cliente', 'noelia.delgado@example.test', 'estandar'),
    ('Marcos', 'Ortiz Marín', 'Ingeniero de calidad', 'marcos.ortiz@example.test', 'estandar'),
    ('Beatriz', 'Rubio Núñez', 'Abogada', 'beatriz.rubio@example.test', 'estandar'),
    ('Óscar', 'Serrano Medina', 'Administrador de bases de datos', 'oscar.serrano@example.test', 'estandar'),
    ('Patricia', 'Iglesias Cortés', 'Responsable de operaciones', 'patricia.iglesias@example.test', 'estandar'),
    ('Adrián', 'Medina Garrido', 'Desarrollador', 'adrian.medina@example.test', 'estandar'),
    ('Teresa', 'Cortés Castillo', 'Responsable de calidad', 'teresa.cortes@example.test', 'estandar'),
    ('Hugo', 'Santos Lozano', 'Técnico de soporte', 'hugo.santos@example.test', 'estandar');

-- Se asocian las vacaciones por email, no por IDs asumidos. Cada persona
-- recibe seis días laborables consecutivos (se omiten sábados y domingos).
WITH periodos (email, fecha_inicio) AS (
    VALUES
        ('ana.garcia@example.test', DATE '2026-08-10'),
        ('luis.martinez@example.test', DATE '2026-12-14'),
        ('marta.sanchez@example.test', DATE '2026-07-20'),
        ('carlos.fernandez@example.test', DATE '2026-06-08'),
        ('lucia.gomez@example.test', DATE '2026-09-07'),
        ('javier.diaz@example.test', DATE '2026-05-04'),
        ('elena.alvarez@example.test', DATE '2026-08-17'),
        ('pablo.moreno@example.test', DATE '2026-10-05'),
        ('sara.jimenez@example.test', DATE '2026-07-06'),
        ('diego.ruiz@example.test', DATE '2026-11-02'),
        ('paula.hernandez@example.test', DATE '2026-06-15'),
        ('andres.romero@example.test', DATE '2026-09-14'),
        ('nerea.navarro@example.test', DATE '2026-08-03'),
        ('miguel.torres@example.test', DATE '2026-05-18'),
        ('claudia.dominguez@example.test', DATE '2026-10-19'),
        ('alberto.vazquez@example.test', DATE '2026-07-13'),
        ('irene.ramos@example.test', DATE '2026-06-22'),
        ('sergio.gil@example.test', DATE '2026-09-21'),
        ('ainhoa.castro@example.test', DATE '2026-11-09'),
        ('raul.molina@example.test', DATE '2026-08-24'),
        ('carmen.morales@example.test', DATE '2026-05-25'),
        ('ivan.ortega@example.test', DATE '2026-10-26'),
        ('noelia.delgado@example.test', DATE '2026-07-27'),
        ('marcos.ortiz@example.test', DATE '2026-06-01'),
        ('beatriz.rubio@example.test', DATE '2026-09-28'),
        ('oscar.serrano@example.test', DATE '2026-12-07'),
        ('patricia.iglesias@example.test', DATE '2026-08-31'),
        ('adrian.medina@example.test', DATE '2026-05-11'),
        ('teresa.cortes@example.test', DATE '2026-10-12'),
        ('hugo.santos@example.test', DATE '2026-07-20')
)
INSERT INTO vacaciones (usuario_id, anio, fecha)
SELECT u.id, 2026, dias.fecha::date
FROM periodos p
JOIN usuarios u ON u.email = p.email
CROSS JOIN LATERAL (
    SELECT dia AS fecha
    FROM generate_series(
        p.fecha_inicio::timestamp,
        (p.fecha_inicio + 10)::timestamp,
        INTERVAL '1 day'
    ) AS dia
    WHERE EXTRACT(ISODOW FROM dia) BETWEEN 1 AND 5
    ORDER BY dia
    LIMIT 6
) AS dias;
