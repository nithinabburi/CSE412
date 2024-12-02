import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import axios from "axios";
import SearchBar from "../components/SearchBar";

const Books = () => {
  const [books, setBooks] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const API_URL = process.env.REACT_APP_API_URL || "http://localhost:5001";

  // Fetch all books on component mount
  useEffect(() => {
    const fetchBooks = async () => {
      setLoading(true);
      try {
        const token = localStorage.getItem("token");
        const response = await axios.get(`${API_URL}/api/books`, {
          headers: { Authorization: `Bearer ${token}` },
        });
        setBooks(response.data);
        setError(null);
      } catch (err) {
        console.error("Error fetching books:", err.message);
        setError("Failed to fetch books. Please try again later.");
      } finally {
        setLoading(false);
      }
    };

    fetchBooks();
  }, [API_URL]);

  // Handle search functionality
  const handleSearch = async (query) => {
    console.log("Search Query Entered:", query); // Debugging log
  
    if (!query.trim()) {
      setError("Please enter a search term.");
      return;
    }
  
    setLoading(true);
    setError(null);
  
    try {
      const token = localStorage.getItem("token");
      console.log("Token Used:", token); // Debugging log
  
      const response = await axios.get(`${API_URL}/api/search`, {
        params: { q: query },
        headers: { Authorization: `Bearer ${token}` },
      });
  
      console.log("Search API Response:", response.data); // Debugging log
      setBooks(response.data);
    } catch (err) {
      console.error("Error during search:", err.message); // Debugging log
      setError("Failed to fetch search results. Please try again later.");
    } finally {
      setLoading(false);
    }
  };
  

  if (loading) return <p>Loading books...</p>;
  if (error) return <p style={{ color: "red" }}>{error}</p>;

  return (
    <div style={{ padding: "20px", fontFamily: "Arial, sans-serif" }}>
      <h2>Books List</h2>

      {/* Search Bar */}
      <SearchBar onSearch={handleSearch} />

      {books.length > 0 ? (
        <div
          style={{
            display: "grid",
            gridTemplateColumns: "repeat(auto-fit, minmax(200px, 1fr))",
            gap: "20px",
          }}
        >
          {books.map((book) => (
            <div
              key={book.isbn}
              style={{
                border: "1px solid #ccc",
                borderRadius: "8px",
                padding: "10px",
                textAlign: "center",
              }}
            >
              <img
                src={`https://via.placeholder.com/150?text=${book.name}`}
                alt={book.name}
                style={{ width: "100%", height: "150px", objectFit: "cover" }}
              />
              <h3 style={{ fontSize: "16px", margin: "10px 0" }}>{book.name}</h3>
              <Link
                to={`/book/${book.isbn}`}
                style={{
                  display: "inline-block",
                  marginTop: "10px",
                  padding: "8px 12px",
                  backgroundColor: "#007bff",
                  color: "#fff",
                  textDecoration: "none",
                  borderRadius: "4px",
                }}
              >
                View Details
              </Link>
            </div>
          ))}
        </div>
      ) : (
        <p>No books available.</p>
      )}
    </div>
  );
};

export default Books;
