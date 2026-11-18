INSERT INTO oficinas (nombre)
VALUES ('Madrid'), ('Sevilla')
ON CONFLICT (nombre) DO NOTHING;

INSERT INTO calendarios_oficina (oficina_id, anio)
SELECT o.id, a.anio
FROM oficinas o
CROSS JOIN (VALUES (2026), (2027)) AS a(anio)
WHERE o.nombre IN ('Madrid', 'Sevilla')
ON CONFLICT (oficina_id, anio) DO NOTHING;

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
        ('Madrid', 2026, DATE '2026-12-25', 'Navidad'),
        ('Madrid', 2027, DATE '2027-01-01', 'Año Nuevo'),
        ('Madrid', 2027, DATE '2027-01-06', 'Epifanía del Señor'),
        ('Madrid', 2027, DATE '2027-03-25', 'Jueves Santo'),
        ('Madrid', 2027, DATE '2027-03-26', 'Viernes Santo'),
        ('Madrid', 2027, DATE '2027-05-01', 'Fiesta del Trabajo'),
        ('Madrid', 2027, DATE '2027-10-12', 'Fiesta Nacional de España'),
        ('Madrid', 2027, DATE '2027-12-25', 'Navidad'),
        ('Sevilla', 2026, DATE '2026-01-01', 'Año Nuevo'),
        ('Sevilla', 2026, DATE '2026-01-06', 'Epifanía del Señor'),
        ('Sevilla', 2026, DATE '2026-02-28', 'Día de Andalucía'),
        ('Sevilla', 2026, DATE '2026-04-02', 'Jueves Santo'),
        ('Sevilla', 2026, DATE '2026-04-03', 'Viernes Santo'),
        ('Sevilla', 2026, DATE '2026-05-01', 'Fiesta del Trabajo'),
        ('Sevilla', 2026, DATE '2026-10-12', 'Fiesta Nacional de España'),
        ('Sevilla', 2026, DATE '2026-12-25', 'Navidad'),
        ('Sevilla', 2027, DATE '2027-01-01', 'Año Nuevo'),
        ('Sevilla', 2027, DATE '2027-01-06', 'Epifanía del Señor'),
        ('Sevilla', 2027, DATE '2027-03-25', 'Jueves Santo'),
        ('Sevilla', 2027, DATE '2027-03-26', 'Viernes Santo'),
        ('Sevilla', 2027, DATE '2027-05-01', 'Fiesta del Trabajo'),
        ('Sevilla', 2027, DATE '2027-10-12', 'Fiesta Nacional de España'),
        ('Sevilla', 2027, DATE '2027-12-25', 'Navidad')
) AS festivos(oficina, anio, fecha, nombre)
WHERE calendarios.nombre = festivos.oficina
  AND calendarios.anio = festivos.anio
ON CONFLICT (calendario_id, fecha) DO NOTHING;
