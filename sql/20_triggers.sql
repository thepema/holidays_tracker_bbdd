CREATE FUNCTION actualizar_updated_at()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;

CREATE TRIGGER usuarios_actualizar_updated_at
BEFORE UPDATE ON usuarios
FOR EACH ROW
EXECUTE FUNCTION actualizar_updated_at();

CREATE TRIGGER sesiones_actualizar_updated_at
BEFORE UPDATE ON sesiones
FOR EACH ROW
EXECUTE FUNCTION actualizar_updated_at();

CREATE TRIGGER vacaciones_actualizar_updated_at
BEFORE UPDATE ON vacaciones
FOR EACH ROW
EXECUTE FUNCTION actualizar_updated_at();
