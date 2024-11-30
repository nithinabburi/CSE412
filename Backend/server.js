require("dotenv").config(); // Load environment variables from .env
const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const jwt = require("jsonwebtoken");
const { Pool } = require("pg");

const userRoutes = require("./routes/userRoutes");
const loginRoutes = require("./routes/loginRoutes"); // Import loginRoutes.js
console.log("userRoutes:", userRoutes); // Debug log
console.log("loginRoutes:", loginRoutes); // Debug log

const app = express();

// Middleware
app.use(cors()); // Enable Cross-Origin Resource Sharing
app.use(bodyParser.json()); // Parse JSON request bodies

// PostgreSQL Connection Pool
const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_DATABASE,
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT,
});

// Test database connection
pool.connect((err, client, release) => {
  if (err) {
    console.error("Error connecting to the database:", err.message);
  } else {
    console.log("Successfully connected to the PostgreSQL database");
    release();
  }
});

// Add user routes
app.use("/users", userRoutes);

// Add login routes
app.use("/users/login", (req, res, next) => {
  console.log(`Request received at /login: ${req.method} ${req.originalUrl}`);
  next(); // Proceed to the login route
});

app.use("/users/login", loginRoutes);


// JWT Middleware to protect routes
const authenticateToken = (req, res, next) => {
  const authHeader = req.headers["authorization"];
  const token = authHeader && authHeader.split(" ")[1]; // Extract token from "Bearer <token>"
  if (!token) return res.status(401).json({ error: "Access denied. No token provided." });

  jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
    if (err) return res.status(403).json({ error: "Invalid token." });
    req.user = user; // Attach the user payload to the request
    next(); // Proceed to the next middleware or route
  });
};

// Example Protected Route
app.get("/protected", authenticateToken, (req, res) => {
  res.status(200).json({ message: "Welcome to the protected route!", user: req.user });
});

// API Endpoint to fetch all authors from the 'author' table
app.get("/api/data", async (req, res) => {
  try {
    console.log("Fetching data from the database...");
    const result = await pool.query("SELECT * FROM author");
    console.log("Query result:", result.rows); // Log the query result
    res.status(200).json(result.rows);
  } catch (error) {
    console.error("Error fetching data from the database:", error.message); // Log the error
    res.status(500).json({ error: "Internal Server Error" });
  }
});

// API Endpoint to insert a new author into the 'author' table
app.post("/api/data", async (req, res) => {
  const { author_id, name } = req.body; // Use 'author_id' and 'name' columns
  try {
    const result = await pool.query(
      "INSERT INTO author (author_id, name) VALUES ($1, $2) RETURNING *",
      [author_id, name]
    );
    res.status(201).json(result.rows[0]); // Return the inserted row
  } catch (error) {
    console.error("Error inserting data into database:", error.message);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

// Handle 404 for unmatched routes
app.use((req, res) => {
  res.status(404).json({ error: "Route not found" });
});

// Start the server
const PORT = process.env.PORT || 5000; // Use PORT from .env or default to 5000
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
