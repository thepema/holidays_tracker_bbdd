INSERT INTO usuarios (codigo, nombre, apellidos, cargo, email, tipo_vacaciones) VALUES
    (1, 'Ana', 'García López', 'Administradora', 'ana.garcia@example.test', 'Horas libre configuración'),
    (2, 'Luis', 'Martínez Ruiz', 'Desarrollador', 'luis.martinez@example.test', 'Días inhabiles'),
    (3, 'Marta', 'Sánchez Pérez', 'Recursos Humanos', 'marta.sanchez@example.test', 'Horas libre configuración'),
    (4, 'Carlos', 'Fernández Martín', 'Desarrollador', 'carlos.fernandez@example.test', 'Días inhabiles'),
    (5, 'Lucía', 'Gómez Navarro', 'Diseñadora UX', 'lucia.gomez@example.test', 'Horas libre configuración'),
    (6, 'Javier', 'Díaz Romero', 'Analista de datos', 'javier.diaz@example.test', 'Días inhabiles'),
    (7, 'Elena', 'Álvarez Torres', 'Responsable de producto', 'elena.alvarez@example.test', 'Horas libre configuración'),
    (8, 'Pablo', 'Moreno Gil', 'Desarrollador', 'pablo.moreno@example.test', 'Días inhabiles'),
    (9, 'Sara', 'Jiménez Ortega', 'Especialista de marketing', 'sara.jimenez@example.test', 'Horas libre configuración'),
    (10, 'Diego', 'Ruiz Castro', 'Administrador de sistemas', 'diego.ruiz@example.test', 'Días inhabiles'),
    (11, 'Paula', 'Hernández Muñoz', 'Contable', 'paula.hernandez@example.test', 'Horas libre configuración'),
    (12, 'Andrés', 'Romero Iglesias', 'Desarrollador', 'andres.romero@example.test', 'Días inhabiles'),
    (13, 'Nerea', 'Navarro Rubio', 'Técnica de soporte', 'nerea.navarro@example.test', 'Horas libre configuración'),
    (14, 'Miguel', 'Torres Molina', 'Arquitecto de software', 'miguel.torres@example.test', 'Días inhabiles'),
    (15, 'Claudia', 'Domínguez Serrano', 'Diseñadora gráfica', 'claudia.dominguez@example.test', 'Horas libre configuración'),
    (16, 'Alberto', 'Vázquez Ramos', 'Responsable de ventas', 'alberto.vazquez@example.test', 'Días inhabiles'),
    (17, 'Irene', 'Ramos Blanco', 'Especialista de comunicación', 'irene.ramos@example.test', 'Horas libre configuración'),
    (18, 'Sergio', 'Gil Santos', 'Desarrollador', 'sergio.gil@example.test', 'Días inhabiles'),
    (19, 'Ainhoa', 'Castro Pascual', 'Técnica de selección', 'ainhoa.castro@example.test', 'Horas libre configuración'),
    (20, 'Raúl', 'Molina Vidal', 'Analista financiero', 'raul.molina@example.test', 'Días inhabiles'),
    (21, 'Carmen', 'Morales León', 'Gestora de proyectos', 'carmen.morales@example.test', 'Horas libre configuración'),
    (22, 'Iván', 'Ortega Delgado', 'Desarrollador', 'ivan.ortega@example.test', 'Días inhabiles'),
    (23, 'Noelia', 'Delgado Ortiz', 'Especialista de atención al cliente', 'noelia.delgado@example.test', 'Horas libre configuración'),
    (24, 'Marcos', 'Ortiz Marín', 'Ingeniero de calidad', 'marcos.ortiz@example.test', 'Días inhabiles'),
    (25, 'Beatriz', 'Rubio Núñez', 'Abogada', 'beatriz.rubio@example.test', 'Horas libre configuración'),
    (26, 'Óscar', 'Serrano Medina', 'Administrador de bases de datos', 'oscar.serrano@example.test', 'Días inhabiles'),
    (27, 'Patricia', 'Iglesias Cortés', 'Responsable de operaciones', 'patricia.iglesias@example.test', 'Horas libre configuración'),
    (28, 'Adrián', 'Medina Garrido', 'Desarrollador', 'adrian.medina@example.test', 'Días inhabiles'),
    (29, 'Teresa', 'Cortés Castillo', 'Responsable de calidad', 'teresa.cortes@example.test', 'Horas libre configuración'),
    (30, 'Hugo', 'Santos Lozano', 'Técnico de soporte', 'hugo.santos@example.test', 'Días inhabiles');

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
