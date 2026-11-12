/**
 * Modelos TypeScript que reflejan las tablas PostgreSQL del proyecto.
 *
 * `BIGINT` se representa como `string` para evitar pérdida de precisión en JS.
 * Las fechas se expresan como strings ISO; adapta los tipos si el driver devuelve
 * objetos `Date` en tu capa de acceso a datos.
 *
 * Estos tipos describen las filas de la base de datos. No devuelvas los hashes
 * de sesión al cliente ni los aceptes directamente desde una petición pública.
 */

export type Id = string;
export type ISODate = string; // PostgreSQL DATE: YYYY-MM-DD
export type ISODateTime = string; // PostgreSQL TIMESTAMPTZ: ISO 8601

export type EstadoSesion = "solicitado" | "proceso" | "autorizado";

/** Fila de la tabla `equipos`. */
export interface Equipo {
  id: Id;
  nombre: string;
  created_at: ISODateTime;
  updated_at: ISODateTime;
}

/** Campos necesarios al insertar un equipo; los timestamps los genera la BD. */
export type NuevoEquipo = Pick<Equipo, "nombre">;

/** Campos modificables de `equipos`. */
export type ActualizacionEquipo = Partial<NuevoEquipo>;

/** Fila de la tabla `usuarios`. */
export interface Usuario {
  id: Id;
  nombre: string;
  apellidos: string;
  cargo: string;
  email: string;
  tipo_vacaciones: string;
  equipo_id: Id | null;
  created_at: ISODateTime;
  updated_at: ISODateTime;
}

/** Campos necesarios al insertar en `usuarios`; los timestamps los genera la BD. */
export type NuevoUsuario = Pick<
  Usuario,
  "nombre" | "apellidos" | "cargo" | "email" | "tipo_vacaciones"
> & Partial<Pick<Usuario, "equipo_id">>;

/** Campos modificables de `usuarios`. */
export type ActualizacionUsuario = Partial<NuevoUsuario>;

/** Fila de la tabla `sesiones`. Los hashes son internos y nunca deben exponerse. */
export interface Sesion {
  id: Id;
  usuario_id: Id;
  token_hash: string;
  request_token_hash: string;
  recovery_token_hash: string | null;
  estado: EstadoSesion;
  created_at: ISODateTime;
  updated_at: ISODateTime;
}

/** Datos internos para insertar una sesión; `estado` usa el default de la BD si se omite. */
export type NuevaSesion = Pick<
  Sesion,
  "usuario_id" | "token_hash" | "request_token_hash"
> & Partial<Pick<Sesion, "recovery_token_hash" | "estado">>;

/** Fila de la tabla `vacaciones`. */
export interface Vacacion {
  id: Id;
  usuario_id: Id;
  anio: number;
  fecha: ISODate;
  created_at: ISODateTime;
  updated_at: ISODateTime;
}

/** Campos necesarios al insertar una vacación. */
export type NuevaVacacion = Pick<Vacacion, "usuario_id" | "anio" | "fecha">;

/** Campos modificables de `vacaciones`. */
export type ActualizacionVacacion = Partial<Pick<Vacacion, "anio" | "fecha">>;

/** Correspondencia entre nombres de tabla y sus modelos de fila. */
export interface DatabaseTables {
  equipos: Equipo;
  usuarios: Usuario;
  sesiones: Sesion;
  vacaciones: Vacacion;
}
