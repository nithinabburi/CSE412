const express = require("express");
const router = express.Router();
const pool = require("../db"); 



router.post("/", async (req, res) => {
    console.log("Request Body:", req.body);
    const { email, book_isbn, book_name } = req.body;
    console.log("Received purchase data:", req.body); 
    if (!email || !book_isbn || !book_name) {
        console.log("Missing required fields:", { email, book_isbn, book_name });
        return res.status(400).json({ error: "Missing required fields" });
    }

    try {
        const result = await pool.query(
            "INSERT INTO purchases (email, book_isbn, book_name) VALUES ($1, $2, $3) RETURNING *",
            [email, book_isbn, book_name]
        );

        res.status(201).json({ message: "Purchase stored successfully", purchase: result.rows[0] });
    } catch (err) {
        console.error("Error storing purchase:", err.message);
        res.status(500).json({ error: "Failed to store purchase" });
    }
});

module.exports = router;
