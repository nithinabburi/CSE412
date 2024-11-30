const express = require("express");
const router = express.Router();
const bcrypt = require("bcrypt");
const pool = require("../db"); // Import database connection

// User Registration
router.post("/register", async (req, res) => {
  const { email, password, name } = req.body;

  // Validate input fields
  if (!email || !password || !name) {
    console.error("Missing required fields:", { email, password, name });
    return res.status(400).json({ error: "All fields are required." });
  }

  try {
    // Check if the email already exists
    const existingUser = await pool.query("SELECT * FROM user_account WHERE email = $1", [email]);
    if (existingUser.rows.length > 0) {
      console.error("Email already registered:", email);
      return res.status(400).json({ error: "Email already registered." });
    }

    // Hash the password
    const hashedPassword = bcrypt.hashSync(password, 10);
    console.log("Hashed Password:", hashedPassword);

    // Insert the user into the database
    const result = await pool.query(
      "INSERT INTO user_account (email, password_hash, name) VALUES ($1, $2, $3) RETURNING *",
      [email, hashedPassword, name]
    );

    res.status(201).json({
      message: "User registered successfully.",
      user: { email: result.rows[0].email, name: result.rows[0].name },
    });
  } catch (error) {
    console.error("Error during signup:", error.message);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

module.exports = router;