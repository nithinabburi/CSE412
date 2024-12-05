require("dotenv").config(); 
const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const { Pool } = require("pg");
const searchRoutes = require('./routes/SearchRoutes');
const userRoutes = require("./routes/userRoutes");
const loginRoutes = require("./routes/loginRoutes"); 
const purchaseRoutes = require('./routes/purchaseRoutes');
console.log("userRoutes:", userRoutes); 
console.log("loginRoutes:", loginRoutes); 

const app = express();


app.use(cors()); 
app.use(bodyParser.json()); 


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


app.use("/users", userRoutes);


app.use('/api/purchase', purchaseRoutes);
console.log("Purchase route hit");



app.use("/users/login", (req, res, next) => {
  console.log(`Request received at /login: ${req.method} ${req.originalUrl}`);
  next(); 
});

app.use("/users/login", loginRoutes);



app.use('/api/search', searchRoutes);

app.get("/api/books", async (req, res) => {
  try {
    console.log("Fetching books from the database...");
    const result = await pool.query("SELECT * FROM book ORDER BY isbn ASC");
    console.log("Query result:", result.rows); 
    res.status(200).json(result.rows); 
  } catch (error) {
    console.error("Error fetching books from the database:", error.message);
    res.status(500).json({ error: "Internal Server Error" });
  }
});




app.get("/api/books/:isbn", async (req, res) => {
  const { isbn } = req.params; 
  try {
    console.log(`Fetching details for book with ISBN: ${isbn}`);
    const result = await pool.query(
      "SELECT isbn, name, description, price FROM book WHERE isbn = $1",
      [isbn]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Book not found" });
    }

    res.status(200).json(result.rows[0]); 
  } catch (error) {
    console.error("Error fetching book details from the database:", error.message);
    res.status(500).json({ error: "Internal Server Error" });
  }
});


app.get("/api/books-authors", async (req, res) => {
  try {
    console.log("Fetching books with authors...");
    const query = `
    SELECT 
    b.name AS book_name, 
    a.name AS author_name, 
    c.condition
  FROM 
    written_by wb
  JOIN 
    book b ON wb.isbn = b.isbn
  JOIN 
    author a ON wb.author_id = a.author_id
  JOIN 
    copy c ON b.isbn = c.isbn
  ORDER BY b.name ASC;
`;

    const result = await pool.query(query);
    console.log("Books with authors fetched:", result.rows); 
    res.status(200).json(result.rows); 
  } catch (error) {
    console.error("Error fetching books with authors:", error.message);
    res.status(500).json({ error: "Internal Server Error" });
  }
});


app.use((req, res) => {
  res.status(404).json({ error: "Route not found" });
});


const PORT = process.env.PORT || 5000; 
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});



