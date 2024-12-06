import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import axios from "axios";
import SearchBar from "../components/SearchBar";
import { useNavigate, useSearchParams } from "react-router-dom";
import './books.css';


const Books = () => {
  const [books, setBooks] = useState([]);
  const [allBooks, setAllBooks] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const navigate = useNavigate();
  const [searchParams] = useSearchParams(); 
  const API_URL = process.env.REACT_APP_API_URL || "http://localhost:5001";

  
  useEffect(() => {
    const fetchBooks = async () => {
      setLoading(true);
      try {
        const response = await axios.get(`${API_URL}/api/books`, {
        });
        console.log("Fetched books:", response.data); 
        setBooks(response.data);
        setAllBooks(response.data);
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

  
  
  const handleSearch = async (query) => {
    console.log("Search Query Entered:", query); 
  
    if (!query.trim()) {
      setError("Please enter a search term.");
      return;
    }
  
    setLoading(true);
    setError(null);
  
    try {

        const response = await axios.get(`${API_URL}/api/search`, {
        params: { q: query },
      });
  
      console.log("Search API Response:", response.data); 
      setBooks(response.data);
     
    } catch (err) {
      console.error("Error during search:", err.message); 
      setError("Failed to fetch search results. Please try again later.");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    const query = searchParams.get("q");
    if (query) {
      handleSearch(query);
    }
  }, [searchParams]);
  
  const handleBackToAllBooks = () => {
    setBooks(allBooks); 
    setError(null); 
  };

  const handlePastOrders = () => {
    navigate("/past-orders"); 
  };

  if (loading) return <p>Loading books...</p>;
  if (error) return <p style={{ color: "red" }}>{error}</p>;

  return (
    <div className="books-container">
      <div className="header">
        <h2>Books List</h2>
        <button onClick={handlePastOrders} className="past-orders-button">
          Past Orders
        </button>
      </div>
      <SearchBar onSearch={handleSearch} />

      <button
        onClick={handleBackToAllBooks}
        className="back-button"
      >
        Back to All Books
      </button>

      {books.length > 0 ? (
        <div className="books-grid">
          {books.map((book) => (
            <div
              key={book.isbn}
              className="book-item"
            >
              <img
                src={`https://via.placeholder.com/150?text=${book.name}`}
                alt={book.name}
                className="book-image"
              />
              <h3 className="book-title">{book.name}</h3>
              <Link
                to={`/book/${book.isbn}`}
                className="view-details-link"
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