const express = require("express");
const router = express.Router();
const pool = require("../db"); 

router.get("/:email", async (req, res) => { 
    const { email } = req.params; 

    if (!email) {
        return res.status(400).json({ error: "Email is required" });
    }

    try {
        const result = await pool.query(
            "SELECT * FROM public.purchases WHERE email = $1 ORDER BY purchase_date DESC",
            [email]
        );
        res.json(result.rows);
    } catch (err) {
        console.error("Error retrieving orders:", err.message);
        res.status(500).json({ error: "Internal server error" });
    }
});

module.exports = router;