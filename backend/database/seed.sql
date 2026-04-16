-- ROLES
INSERT INTO Rol (id, nombre, requiere_pje) VALUES
(1, 'Juez', TRUE),
(2, 'Especialista', TRUE),
(3, 'Actor', FALSE),
(4, 'Demandado', FALSE),
(5, 'Defensor', FALSE),
(6, 'Representante Legal', FALSE);

-- PERSONAS (30)
INSERT INTO Persona (id, nombre, pertenece_pje) VALUES
-- Jueces
(1, 'Juan Perez', TRUE),
(2, 'Laura Mendoza', TRUE),

-- Especialistas
(3, 'Maria Lopez', TRUE),
(4, 'Carlos Herrera', TRUE),

-- Actores (10)
(5, 'Carlos Mendoza García', FALSE),
(6, 'Luis Fernando Ramírez Soto', FALSE),
(7, 'José Antonio Hernández Cruz', FALSE),
(8, 'Miguel Ángel Torres López', FALSE),
(9, 'Ricardo Chávez Morales', FALSE),
(10, 'Daniel Ortega Vargas', FALSE),
(11, 'Jorge Alberto Castillo Reyes', FALSE),
(12, 'Fernando Salinas Romero', FALSE),
(13, 'Eduardo Navarro Peña', FALSE),
(14, 'Víctor Hugo Ríos Delgado', FALSE),

-- Demandados (8)
(15, 'María Guadalupe Sánchez Pérez', FALSE),
(16, 'Ana Sofía Torres Hernández', FALSE),
(17, 'Patricia López Martínez', FALSE),
(18, 'Laura Jiménez Castillo', FALSE),
(19, 'Verónica Morales Ruiz', FALSE),
(20, 'Gabriela Ortiz Flores', FALSE),
(21, 'Claudia Rivera Mendoza', FALSE),
(22, 'Rosa Elena Vargas Soto', FALSE),

-- Defensores (5)
(23, 'Lic. Roberto Díaz Campos', FALSE),
(24, 'Lic. Alejandro Paredes Silva', FALSE),
(25, 'Lic. Manuel Cárdenas Rubio', FALSE),
(26, 'Lic. Sergio Domínguez Nieto', FALSE),
(27, 'Lic. Héctor Beltrán Fuentes', FALSE),

-- Representantes (3)
(28, 'Lic. Adriana Velasco Cruz', FALSE),
(29, 'Lic. Daniela Castro Mejía', FALSE),
(30, 'Lic. Karla Ivonne Méndez Lara', FALSE);

-- EXPEDIENTES
INSERT INTO Expediente (id, numero, anio, tipo, accion_principal) VALUES
(1, 1001, 2026, 'Ordinario', 'Despido injustificado'),
(2, 1002, 2026, 'Especial', 'Pago de prestaciones'),
(3, 1003, 2026, 'Huelga', 'Conflicto colectivo'),
(4, 1004, 2026, 'Ordinario', 'Rescisión de contrato'),
(5, 1005, 2026, 'Especial', 'Indemnización');

-- SALAS
INSERT INTO Sala (id, nombre) VALUES
(1, 'Sala 1'),
(2, 'Sala 2'),
(3, 'Sala 3');

-- RELACIONES EXPEDIENTE-PERSONA (MEJORADAS)
INSERT INTO ExpedientePersona (id, expediente_id, persona_id, rol_id) VALUES

-- 🔹 EXPEDIENTE 1 (3 actores, 2 demandados)
(1,1,5,3),
(2,1,6,3),
(3,1,7,3),
(4,1,15,4),
(5,1,16,4),
(6,1,23,5),
(7,1,28,6),

-- 🔹 EXPEDIENTE 2 (2 actores, 1 demandado)
(8,2,8,3),
(9,2,9,3),
(10,2,17,4),
(11,2,24,5),
(12,2,29,6),

-- 🔹 EXPEDIENTE 3 (3 actores, 3 demandados)
(13,3,10,3),
(14,3,11,3),
(15,3,12,3),
(16,3,18,4),
(17,3,19,4),
(18,3,20,4),
(19,3,25,5),

-- 🔹 EXPEDIENTE 4 (2 actores, 2 demandados)
(20,4,13,3),
(21,4,14,3),
(22,4,21,4),
(23,4,22,4),
(24,4,26,5),

-- 🔹 EXPEDIENTE 5 (3 actores, 1 demandado)
(25,5,5,3),
(26,5,9,3),
(27,5,12,3),
(28,5,15,4),
(29,5,27,5),
(30,5,30,6);

-- AUDIENCIAS (pasadas y futuras)
INSERT INTO Audiencia (id, expediente_id, fecha, hora, sala_id, juez_id, especialista_id) VALUES
(1,1,'2026-05-20','10:00',1,1,3),
(2,2,'2026-05-25','11:00',2,2,4),
(3,3,'2026-06-10','09:00',3,1,4),
(4,4,'2026-07-01','12:00',1,2,3),
(5,5,'2026-07-10','10:30',2,1,3);

-- FASES (cada expediente en diferente estado)
INSERT INTO Fase (id, expediente_id, nombre, fecha) VALUES
-- Exp 1 (terminado)
(1,1,'Recepción de demanda','2026-05-01'),
(2,1,'Audiencia','2026-05-20'),
(3,1,'Resolución','2026-05-30'),

-- Exp 2 (en audiencia)
(4,2,'Recepción de demanda','2026-05-05'),
(5,2,'Audiencia','2026-05-25'),

-- Exp 3 (en proceso)
(6,3,'Recepción de demanda','2026-05-10'),

-- Exp 4 (recién iniciado)
(7,4,'Recepción de demanda','2026-06-20'),

-- Exp 5 (avanzado)
(8,5,'Recepción de demanda','2026-05-15'),
(9,5,'Audiencia','2026-06-10');

-- RESOLUCIONES (solo expedientes finalizados)
INSERT INTO Resolucion (id, expediente_id, decision) VALUES
(1,1,'Procedente');