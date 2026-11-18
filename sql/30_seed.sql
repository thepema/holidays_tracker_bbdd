-- Oficinas de Madrid y Sevilla
INSERT INTO oficinas (nombre)
VALUES ('Madrid'), ('Sevilla')
ON CONFLICT (nombre) DO NOTHING;

-- Calendarios anuales de ambas oficinas
INSERT INTO calendarios_oficina (oficina_id, anio)
SELECT o.id, a.anio
FROM oficinas o
CROSS JOIN (VALUES (2026), (2027)) AS a(anio)
WHERE o.nombre IN ('Madrid', 'Sevilla')
ON CONFLICT (oficina_id, anio) DO NOTHING;

-- Festivos oficiales de Madrid y Sevilla para 2026 y 2027
INSERT INTO dias_festivos (calendario_id, fecha, nombre)
WITH calendarios AS (
    SELECT c.id, o.nombre, c.anio
    FROM calendarios_oficina c
    JOIN oficinas o ON o.id = c.oficina_id
)
SELECT id, fecha, nombre
FROM calendarios
CROSS JOIN LATERAL (
    VALUES
        ('Madrid', 2026, DATE '2026-01-01', 'Año Nuevo'),
        ('Madrid', 2026, DATE '2026-01-06', 'Epifanía del Señor'),
        ('Madrid', 2026, DATE '2026-04-02', 'Jueves Santo'),
        ('Madrid', 2026, DATE '2026-04-03', 'Viernes Santo'),
        ('Madrid', 2026, DATE '2026-05-01', 'Fiesta del Trabajo'),
        ('Madrid', 2026, DATE '2026-05-02', 'Día de la Comunidad de Madrid'),
        ('Madrid', 2026, DATE '2026-05-15', 'San Isidro'),
        ('Madrid', 2026, DATE '2026-08-15', 'Asunción de la Virgen'),
        ('Madrid', 2026, DATE '2026-10-12', 'Fiesta Nacional de España'),
        ('Madrid', 2026, DATE '2026-11-02', 'Traslado de Todos los Santos'),
        ('Madrid', 2026, DATE '2026-11-09', 'Nuestra Señora de la Almudena'),
        ('Madrid', 2026, DATE '2026-12-07', 'Traslado del Día de la Constitución'),
        ('Madrid', 2026, DATE '2026-12-08', 'Inmaculada Concepción'),
        ('Madrid', 2026, DATE '2026-12-25', 'Navidad'),

        ('Madrid', 2027, DATE '2027-01-01', 'Año Nuevo'),
        ('Madrid', 2027, DATE '2027-01-06', 'Epifanía del Señor'),
        ('Madrid', 2027, DATE '2027-03-25', 'Jueves Santo'),
        ('Madrid', 2027, DATE '2027-03-26', 'Viernes Santo'),
        ('Madrid', 2027, DATE '2027-05-01', 'Fiesta del Trabajo'),
        ('Madrid', 2027, DATE '2027-05-03', 'Traslado del Día de la Comunidad de Madrid'),
        ('Madrid', 2027, DATE '2027-05-15', 'San Isidro'),
        ('Madrid', 2027, DATE '2027-08-16', 'Traslado de la Asunción de la Virgen'),
        ('Madrid', 2027, DATE '2027-10-12', 'Fiesta Nacional de España'),
        ('Madrid', 2027, DATE '2027-11-01', 'Todos los Santos'),
        ('Madrid', 2027, DATE '2027-11-09', 'Nuestra Señora de la Almudena'),
        ('Madrid', 2027, DATE '2027-12-06', 'Día de la Constitución'),
        ('Madrid', 2027, DATE '2027-12-08', 'Inmaculada Concepción'),
        ('Madrid', 2027, DATE '2027-12-25', 'Navidad'),

        ('Sevilla', 2026, DATE '2026-01-01', 'Año Nuevo'),
        ('Sevilla', 2026, DATE '2026-01-06', 'Epifanía del Señor'),
        ('Sevilla', 2026, DATE '2026-02-28', 'Día de Andalucía'),
        ('Sevilla', 2026, DATE '2026-04-02', 'Jueves Santo'),
        ('Sevilla', 2026, DATE '2026-04-03', 'Viernes Santo'),
        ('Sevilla', 2026, DATE '2026-04-22', 'Feria de Abril de Sevilla'),
        ('Sevilla', 2026, DATE '2026-05-01', 'Fiesta del Trabajo'),
        ('Sevilla', 2026, DATE '2026-06-04', 'Corpus Christi'),
        ('Sevilla', 2026, DATE '2026-08-15', 'Asunción de la Virgen'),
        ('Sevilla', 2026, DATE '2026-10-12', 'Fiesta Nacional de España'),
        ('Sevilla', 2026, DATE '2026-11-02', 'Traslado de Todos los Santos'),
        ('Sevilla', 2026, DATE '2026-12-07', 'Traslado del Día de la Constitución'),
        ('Sevilla', 2026, DATE '2026-12-08', 'Inmaculada Concepción'),
        ('Sevilla', 2026, DATE '2026-12-25', 'Navidad'),

        ('Sevilla', 2027, DATE '2027-01-01', 'Año Nuevo'),
        ('Sevilla', 2027, DATE '2027-01-06', 'Epifanía del Señor'),
        ('Sevilla', 2027, DATE '2027-03-01', 'Traslado del Día de Andalucía'),
        ('Sevilla', 2027, DATE '2027-03-25', 'Jueves Santo'),
        ('Sevilla', 2027, DATE '2027-03-26', 'Viernes Santo'),
        ('Sevilla', 2027, DATE '2027-04-14', 'Feria de Abril de Sevilla'),
        ('Sevilla', 2027, DATE '2027-05-01', 'Fiesta del Trabajo'),
        ('Sevilla', 2027, DATE '2027-05-27', 'Corpus Christi'),
        ('Sevilla', 2027, DATE '2027-08-16', 'Traslado de la Asunción de la Virgen'),
        ('Sevilla', 2027, DATE '2027-10-12', 'Fiesta Nacional de España'),
        ('Sevilla', 2027, DATE '2027-11-01', 'Todos los Santos'),
        ('Sevilla', 2027, DATE '2027-12-06', 'Día de la Constitución'),
        ('Sevilla', 2027, DATE '2027-12-08', 'Inmaculada Concepción'),
        ('Sevilla', 2027, DATE '2027-12-25', 'Navidad')
) AS festivos(oficina, anio, fecha, nombre)
WHERE calendarios.nombre = festivos.oficina
  AND calendarios.anio = festivos.anio
ON CONFLICT (calendario_id, fecha) DO NOTHING;

-- Usuarios de prueba: asignación aleatoria a Madrid o Sevilla
INSERT INTO usuarios (codigo, nombre, apellidos, cargo, email, tipo_vacaciones, oficina_id) VALUES
    (1, 'Ana', 'García López', 'Administradora', 'ana.garcia@example.test', 'Horas libre configuración', NULL),
    (2, 'Luis', 'Martínez Ruiz', 'Desarrollador', 'luis.martinez@example.test', 'Días inhabiles', NULL),
    (3, 'Marta', 'Sánchez Pérez', 'Recursos Humanos', 'marta.sanchez@example.test', 'Horas libre configuración', NULL),
    (4, 'Carlos', 'Fernández Martín', 'Desarrollador', 'carlos.fernandez@example.test', 'Días inhabiles', NULL),
    (5, 'Lucía', 'Gómez Navarro', 'Diseñadora UX', 'lucia.gomez@example.test', 'Horas libre configuración', NULL),
    (6, 'Javier', 'Díaz Romero', 'Analista de datos', 'javier.diaz@example.test', 'Días inhabiles', NULL),
    (7, 'Elena', 'Álvarez Torres', 'Responsable de producto', 'elena.alvarez@example.test', 'Horas libre configuración', NULL),
    (8, 'Pablo', 'Moreno Gil', 'Desarrollador', 'pablo.moreno@example.test', 'Días inhabiles', NULL),
    (9, 'Sara', 'Jiménez Ortega', 'Especialista de marketing', 'sara.jimenez@example.test', 'Horas libre configuración', NULL),
    (10, 'Diego', 'Ruiz Castro', 'Administrador de sistemas', 'diego.ruiz@example.test', 'Días inhabiles', NULL),
    (11, 'Paula', 'Hernández Muñoz', 'Contable', 'paula.hernandez@example.test', 'Horas libre configuración', NULL),
    (12, 'Andrés', 'Romero Iglesias', 'Desarrollador', 'andres.romero@example.test', 'Días inhabiles', NULL),
    (13, 'Nerea', 'Navarro Rubio', 'Técnica de soporte', 'nerea.navarro@example.test', 'Horas libre configuración', NULL),
    (14, 'Miguel', 'Torres Molina', 'Arquitecto de software', 'miguel.torres@example.test', 'Días inhabiles', NULL),
    (15, 'Claudia', 'Domínguez Serrano', 'Diseñadora gráfica', 'claudia.dominguez@example.test', 'Horas libre configuración', NULL),
    (16, 'Alberto', 'Vázquez Ramos', 'Responsable de ventas', 'alberto.vazquez@example.test', 'Días inhabiles', NULL),
    (17, 'Irene', 'Ramos Blanco', 'Especialista de comunicación', 'irene.ramos@example.test', 'Horas libre configuración', NULL),
    (18, 'Sergio', 'Gil Santos', 'Desarrollador', 'sergio.gil@example.test', 'Días inhabiles', NULL),
    (19, 'Ainhoa', 'Castro Pascual', 'Técnica de selección', 'ainhoa.castro@example.test', 'Horas libre configuración', NULL),
    (20, 'Raúl', 'Molina Vidal', 'Analista financiero', 'raul.molina@example.test', 'Días inhabiles', NULL),
    (21, 'Carmen', 'Morales León', 'Gestora de proyectos', 'carmen.morales@example.test', 'Horas libre configuración', NULL),
    (22, 'Iván', 'Ortega Delgado', 'Desarrollador', 'ivan.ortega@example.test', 'Días inhabiles', NULL),
    (23, 'Noelia', 'Delgado Ortiz', 'Especialista de atención al cliente', 'noelia.delgado@example.test', 'Horas libre configuración', NULL),
    (24, 'Marcos', 'Ortiz Marín', 'Ingeniero de calidad', 'marcos.ortiz@example.test', 'Días inhabiles', NULL),
    (25, 'Beatriz', 'Rubio Núñez', 'Abogada', 'beatriz.rubio@example.test', 'Horas libre configuración', NULL),
    (26, 'Óscar', 'Serrano Medina', 'Administrador de bases de datos', 'oscar.serrano@example.test', 'Días inhabiles', NULL),
    (27, 'Patricia', 'Iglesias Cortés', 'Responsable de operaciones', 'patricia.iglesias@example.test', 'Horas libre configuración', NULL),
    (28, 'Adrián', 'Medina Garrido', 'Desarrollador', 'adrian.medina@example.test', 'Días inhabiles', NULL),
    (29, 'Teresa', 'Cortés Castillo', 'Responsable de calidad', 'teresa.cortes@example.test', 'Horas libre configuración', NULL),
    (30, 'Hugo', 'Santos Lozano', 'Técnico de soporte', 'hugo.santos@example.test', 'Días inhabiles', NULL)
ON CONFLICT (email) DO NOTHING;

UPDATE usuarios AS u
SET oficina_id = (
    SELECT o.id
    FROM oficinas o
    WHERE o.nombre IN ('Madrid', 'Sevilla')
    ORDER BY md5(u.email || random()::text)
    LIMIT 1
)
WHERE u.oficina_id IS NULL;

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
