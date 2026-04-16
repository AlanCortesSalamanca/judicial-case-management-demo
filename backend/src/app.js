const express = require('express');
const fs = require('fs');
const path = require('path');
const db = require('./db');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

const PORT = 3000;

// 📌 Cargar schema y seed
const schema = fs.readFileSync(path.join(__dirname, '../database/schema.sql'), 'utf8');
const seed = fs.readFileSync(path.join(__dirname, '../database/seed.sql'), 'utf8');

db.exec(schema, (err) => {
    if (err) console.error('Error en schema', err);
    else console.log('Schema cargado');
});

db.exec(seed, (err) => {
    if (err) console.error('Error en seed', err);
    else console.log('Seed cargado');
});

// 👉 Obtener todos los expedientes
app.get('/expedientes', (req, res) => {
    db.all('SELECT * FROM Expediente', [], (err, rows) => {
        if (err) return res.status(500).json(err);
        res.json(rows);
    });
});

// 👉 Obtener detalle completo de un expediente
app.get('/expedientes/full', (req, res) => {
    const queryExpedientes = `
        SELECT 
            e.id,
            e.numero,
            e.anio,
            e.tipo,
            e.accion_principal,

            a.fecha,
            a.hora,
            s.nombre AS sala,

            juez.nombre AS juez,
            esp.nombre AS especialista,

            r.decision AS resolucion

        FROM Expediente e
        LEFT JOIN Audiencia a ON e.id = a.expediente_id
        LEFT JOIN Sala s ON a.sala_id = s.id
        LEFT JOIN Persona juez ON a.juez_id = juez.id
        LEFT JOIN Persona esp ON a.especialista_id = esp.id
        LEFT JOIN Resolucion r ON e.id = r.expediente_id
    `;

    db.all(queryExpedientes, [], (err, expedientes) => {
        if (err) return res.status(500).json(err);

        db.all(`
            SELECT ep.expediente_id, p.nombre, rol.nombre AS rol
            FROM ExpedientePersona ep
            JOIN Persona p ON ep.persona_id = p.id
            JOIN Rol rol ON ep.rol_id = rol.id
        `, [], (err2, personas) => {
            if (err2) return res.status(500).json(err2);

            db.all(`
                SELECT * FROM Fase ORDER BY fecha ASC
            `, [], (err3, fases) => {
                if (err3) return res.status(500).json(err3);

                const resultado = expedientes.map(exp => {

                    const relacionados = personas.filter(p => p.expediente_id === exp.id);

                    const fasesExp = fases.filter(f => f.expediente_id === exp.id);

                    const getPorRol = (rol) =>
                        relacionados
                            .filter(r => r.rol === rol)
                            .map(r => r.nombre);
                    
                    const tieneResolucion = fasesExp.some(f => f.nombre === 'Resolución');

                    return {
                        ...exp,
                        actores: getPorRol('Actor'),
                        demandados: getPorRol('Demandado'),
                        defensores: getPorRol('Defensor'),
                        representantes: getPorRol('Representante Legal'),
                        fases: fasesExp,
                        estado: tieneResolucion ? 'Finalizado' : 'En proceso',
                        resolucion: tieneResolucion ? exp.resolucion : null
                        
                    };
                });

                res.json(resultado);
            });
        });
    });
});

// 🚀 Levantar servidor
app.listen(PORT, () => {
    console.log(`Servidor corriendo en http://localhost:${PORT}`);
});