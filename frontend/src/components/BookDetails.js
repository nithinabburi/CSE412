import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import axios from "axios";

const BookDetails = () => {
  const { isbn } = useParams(); // Get ISBN from the route
  const [book, setBook] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const API_URL = process.env.REACT_APP_API_URL || "http://localhost:5001";

  useEffect(() => {
    const fetchBookDetails = async () => {
      try {
        const token = localStorage.getItem("token");
        const response = await axios.get(`${API_URL}/api/books/${isbn}`, {
          headers: { Authorization: `Bearer ${token}` },
        });
        setBook(response.data);
        setError(null);
      } catch (err) {
        console.error("Error fetching book details:", err.message);
        setError("Failed to fetch book details. Please try again later.");
      } finally {
        setLoading(false);
      }
    };

    fetchBookDetails();
  }, [isbn, API_URL]);

  if (loading) return <p>Loading book details...</p>;
  if (error) return <p style={{ color: "red" }}>{error}</p>;

  return (
    <div style={{ padding: "20px", fontFamily: "Arial, sans-serif" }}>
      {book && (
        <>
          <h1>{book.name}</h1>
          <p><strong>ISBN:</strong> {book.isbn}</p>
          <p><strong>Description:</strong> {book.description}</p>
          <p><strong>Price:</strong> ${book.price}</p>
          <button style={{ padding: "10px", fontSize: "16px" }}>Buy Now</button>
        </>
      )}
    </div>
  );
};

export default BookDetails;


