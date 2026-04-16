CREATE TABLE Persona (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    pertenece_pje BOOLEAN NOT NULL
);

CREATE TABLE Rol (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    requiere_pje BOOLEAN NOT NULL
);

CREATE TABLE Expediente (
    id INT PRIMARY KEY,
    numero INT NOT NULL,
    anio INT NOT NULL,
    tipo VARCHAR(100) NOT NULL,
    accion_principal VARCHAR(100) NOT NULL,
    UNIQUE (numero, anio)
);

CREATE TABLE ExpedientePersona (
    id INT PRIMARY KEY,
    expediente_id INT NOT NULL,
    persona_id INT NOT NULL,
    rol_id INT NOT NULL,

    FOREIGN KEY (expediente_id) REFERENCES Expediente(id),
    FOREIGN KEY (persona_id) REFERENCES Persona(id),
    FOREIGN KEY (rol_id) REFERENCES Rol(id),

    UNIQUE (expediente_id, persona_id, rol_id)
);

CREATE TABLE Sala (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Audiencia (
    id INT PRIMARY KEY,
    expediente_id INT NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    sala_id INT NOT NULL,
    juez_id INT NOT NULL,
    especialista_id INT NOT NULL,

    FOREIGN KEY (expediente_id) REFERENCES Expediente(id),
    FOREIGN KEY (sala_id) REFERENCES Sala(id),
    FOREIGN KEY (juez_id) REFERENCES Persona(id),
    FOREIGN KEY (especialista_id) REFERENCES Persona(id),

    -- REGLA PARA QUE EN LA SALA SOLO HAYA UNA AUDIENCIA A LA VEZ
    UNIQUE (fecha, hora, sala_id),

    -- EL JUEZ Y EL ESPECIALISTA SOLO PUEDEN ESTAR EN UNA AUDIENCIA EN ESA HORA Y FECHA
    UNIQUE (fecha, hora, juez_id),
    UNIQUE (fecha, hora, especialista_id)
);

CREATE TABLE Fase (
    id INT PRIMARY KEY,
    expediente_id INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    fecha DATE NOT NULL,

    FOREIGN KEY (expediente_id) REFERENCES Expediente(id)
);

CREATE TABLE Resolucion (
    id INT PRIMARY KEY,
    expediente_id INT NOT NULL UNIQUE,
    decision VARCHAR(100) NOT NULL,

    FOREIGN KEY (expediente_id) REFERENCES Expediente(id)
);