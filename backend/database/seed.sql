INSERT INTO Rol (id, nombre, requiere_pje) VALUES
(1, 'Juez', TRUE),
(2, 'Especialista', TRUE),
(3, 'Actor', FALSE),
(4, 'Demandado', FALSE),
(5, 'Defensor', FALSE),
(6, 'Representante Legal', FALSE);

INSERT INTO Persona (id, nombre, pertenece_pje) VALUES
(1, 'Juan Perez', TRUE),     -- juez
(2, 'Maria Lopez', TRUE),    -- especialista
(3, 'Carlos Ruiz', FALSE),   -- actor
(4, 'Ana Torres', FALSE),    -- demandado
(5, 'Luis Gomez', FALSE),    -- defensor
(6, 'Sofia Ramirez', FALSE); -- representante legal

INSERT INTO Expediente (id, numero, anio, tipo, accion_principal) VALUES
(1, 1001, 2026, 'Ordinario', 'Despido injustificado'),
(2, 1002, 2026, 'Especial', 'Pago de prestaciones'),
(3, 1003, 2026, 'Huelga', 'Conflicto colectivo'),
(4, 1004, 2026, 'Ordinario', 'Rescision de contrato'),
(5, 1005, 2026, 'Especial', 'Indemnizacion');

INSERT INTO Sala (id, nombre) VALUES
(1, 'Sala 1'),
(2, 'Sala 2'),
(3, 'Sala 3');

INSERT INTO ExpedientePersona (id, expediente_id, persona_id, rol_id) VALUES
-- Expediente 1
(1, 1, 3, 3), -- actor
(2, 1, 4, 4), -- demandado
(3, 1, 5, 5), -- defensor
(4, 1, 6, 6), -- representante

-- Expediente 2
(5, 2, 3, 3),
(6, 2, 4, 4),
(7, 2, 5, 5),

-- Expediente 3
(8, 3, 3, 3),
(9, 3, 4, 4),
(10, 3, 5, 5),

-- Expediente 4
(11, 4, 3, 3),
(12, 4, 4, 4),
(13, 4, 5, 5),

-- Expediente 5
(14, 5, 3, 3),
(15, 5, 4, 4),
(16, 5, 5, 5);


INSERT INTO Audiencia (id, expediente_id, fecha, hora, sala_id, juez_id, especialista_id) VALUES
(1, 1, '2026-06-01', '10:00', 1, 1, 2),
(2, 2, '2026-06-01', '11:00', 3, 1, 2),
(3, 3, '2026-06-02', '10:00', 2, 1, 2),
(4, 4, '2026-06-02', '11:00', 3, 1, 2),
(5, 5, '2026-06-03', '10:00', 1, 1, 2);

INSERT INTO Fase (id, expediente_id, nombre, fecha) VALUES
(1, 1, 'Recepcion de demanda', '2024-05-01'),
(2, 1, 'Audiencia inicial', '2024-06-01'),
(3, 2, 'Recepcion de demanda', '2024-05-02'),
(4, 3, 'Recepcion de demanda', '2024-05-03'),
(5, 4, 'Recepcion de demanda', '2024-05-04');

INSERT INTO Resolucion (id, expediente_id, decision) VALUES
(1, 1, 'Procedente'),
(2, 2, 'Improcedente'),
(3, 3, 'Procedente'),
(4, 4, 'Improcedente'),
(5, 5, 'Procedente');