const sqlite3 = require('sqlite3').verbose();
const path = require('path');

const dbPath = path.resolve(__dirname, '../database/database.db');

const db = new sqlite3.Database(dbPath, (err) => {
    if (err) {
        console.error('Error conectando a DB', err);
    } else {
        console.log('Conectado a SQLite');
    }
});

module.exports = db;