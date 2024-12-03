const express = require("express");
const router = express.Router();
const pool = require("../db"); 

router.get("/", async (req, res) => { 
    console.log("Search endpoint hit with query:", req.query.q);
    const { q } = req.query;

    if (!q) {
        return res.status(400).json({ error: "Search query is required" });
    }

    try {
        const result = await pool.query(
            "SELECT * FROM book WHERE name ILIKE $1",
            [`%${q}%`]
        );
        res.json(result.rows);
    } catch (err) {
        console.error("Error executing search query:", err.message);
        res.status(500).json({ error: "Internal server error" });
    }
});

module.exports = router;
