const express = require('express');
const { Pool } = require('pg');
const cors = require('cors'); // Ajoutez cette ligne

const app = express();
const port = 3000;

// Configuration de la connexion PostgreSQL
const pool = new Pool({
    user: 'postgres',        // Utilisateur PostgreSQL
    host: 'bdd',   // Hôte où la base de données est exécutée
    database: 'mydatabase', // Nom de la base de données
    password: 'mysecretpassword', // Mot de passe
    port: 5432,          // Port par défaut de PostgreSQL
});

app.use(cors({
    origin: ['http://localhost:4200', 'http://front:80', 'http://localhost:80', 'http://front', 'http://localhost']
}));

// Route pour récupérer et incrémenter le compteur
app.get('/counter', async (req, res) => {
    const client = await pool.connect();

    try {
        // Insertion d'une nouvelle ligne pour incrémenter le compteur
        await client.query('INSERT INTO compteur (nombre) VALUES (DEFAULT);');

        // Récupérer le compteur total
        const result = await client.query('SELECT COUNT(*) AS nombre FROM compteur;');
        res.json({ nombre: result.rows[0].nombre });
    } catch (err) {
        console.error('Error executing query', err.stack);
        res.status(500).send('Error occurred');
    } finally {
        client.release();
    }
});

app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});