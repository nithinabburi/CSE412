require("dotenv").config(); 
const { Pool } = require("pg");


const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_DATABASE,
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT,
});


pool.connect((err, client, release) => {
  if (err) {
    console.error("Error connecting to the database:", err.message);
  } else {
    console.log("Successfully connected to the PostgreSQL database");
    release(); 
  }
});

module.exports = pool;
