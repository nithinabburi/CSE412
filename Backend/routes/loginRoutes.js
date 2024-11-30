const express = require("express");
const router = express.Router();
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const pool = require("../db");
const { body, validationResult } = require("express-validator");

router.post(
  "/",
  [
    body("email").isEmail().withMessage("Invalid email address."),
    body("password").notEmpty().withMessage("Password is required."),
  ],
  async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { email, password } = req.body;
    console.log("Login attempt received for:", email);

    try {
      const result = await pool.query("SELECT * FROM user_account WHERE email = $1", [email]);

      if (result.rows.length === 0) {
        console.error("Email not found:", email);
        return res.status(400).json({ error: "Invalid email or password." });
      }

      const user = result.rows[0];
      const isMatch = await bcrypt.compare(password, user.password_hash);

      if (!isMatch) {
        console.error("Password mismatch for:", email);
        return res.status(400).json({ error: "Invalid email or password." });
      }

      const token = jwt.sign({ email: user.email, name: user.name }, process.env.JWT_SECRET, {
        expiresIn: "1h",
      });

      console.log("Login successful for:", email);
      res.status(200).json({
        message: "Login successful!",
        user: { email: user.email, name: user.name },
        token,
      });
    } catch (error) {
      console.error("Error during login:", error);
      res.status(500).json({ error: "Internal Server Error" });
    }
  }
);

module.exports = router;
