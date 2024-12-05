import React, { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import axios from "axios";
import './BookDetails.css';

const BookDetails = () => {
  const { isbn } = useParams(); 
  const navigate = useNavigate(); 
  const [book, setBook] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const API_URL = process.env.REACT_APP_API_URL || "http://localhost:5001";

  useEffect(() => {
    const fetchBookDetails = async () => {
      try {
        const response = await axios.get(`${API_URL}/api/books/${isbn}`, {
        });
  
        const bookResponse = response.data;
  
        
        const authorResponse = await axios.get(`${API_URL}/api/books-authors`, {
        });
  
        
        const author = authorResponse.data.find((entry) => entry.book_name === bookResponse.name);
  
        setBook({ ...bookResponse, author_name: author?.author_name || "Unknown Author", condition: author?.condition || "Condition Not Available" });
        setError(null);
      } catch (err) {
        console.error("Error fetching book or author details:", err.message);
        setError("Failed to fetch book details. Please try again later.");
      } finally {
        setLoading(false);
      }
    };
  
    fetchBookDetails();
  }, [isbn, API_URL]);
  
  const handleBuyNowClick = () => {
    if (book) {
      navigate("/checkout", { state: { book } }); 
    } else {
      console.error("Book details are missing");
    }
  };

  if (loading) return <p>Loading book details...</p>;
  if (error) return <p style={{ color: "red" }}>{error}</p>;

  return (
    <div className="book-details-container">
      {book && (
        <>
          <h1 className="book-title">{book.name}</h1>
          <p className="book-info"><strong>ISBN:</strong> {book.isbn}</p>
          <p className="book-info"><strong>Description:</strong> {book.description}</p>
          <p className="book-info"><strong>Price:</strong> ${book.price}</p>
          <p className="book-info"><strong>Author:</strong> {book.author_name}</p>
          <p className="book-info"><strong>Condition:</strong> {book.condition}</p>
          <button
            className="buy-now-button"
            onClick={handleBuyNowClick}
          >
            Buy Now
          </button>
        </>
      )}
    </div>
  );
};

export default BookDetails;


