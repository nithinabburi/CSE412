import React, { useState } from "react";
import axios from "axios";
import Books from "./components/books"; 
import BookDetails from "./components/BookDetails"; 
import Checkout from "./components/Checkout";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import './App.css';

const App = () => {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [name, setName] = useState("");
  const [isSignup, setIsSignup] = useState(false);
  const [authError, setAuthError] = useState(null);

  const API_URL = process.env.REACT_APP_API_URL || "http://localhost:5001";

  
  const handleLogin = async (e) => {
    e.preventDefault();
    setAuthError(null);
    setLoading(true);
    try {
      const response = await axios.post(`${API_URL}/users/login`, {
        email,
        password,
      });
      console.log("Login response:", response.data);
      localStorage.setItem("userEmail", response.data.user.email);
      localStorage.setItem("token", response.data.token);
      setUser(response.data.user.name);
      setLoading(false);
    } catch (err) {
      console.error("Login error:", err.response?.data?.error || err.message);
      setAuthError("Invalid email or password. Please try again.");
      setLoading(false);
    }
  };

  
  const handleSignup = async (e) => {
    e.preventDefault();
    setAuthError(null);
    setLoading(true);
    try {
      await axios.post(`${API_URL}/users/register`, {
        email,
        password,
        name,
      });
      alert("Signup successful! Please log in.");
      setIsSignup(false);
      setLoading(false);
    } catch (err) {
      console.error("Signup error:", err.response?.data?.error || err.message);
      setAuthError("Signup failed. Please try again.");
      setLoading(false);
    }
  };

  
  const handleLogout = () => {
    if (window.confirm("Are you sure you want to log out?")) {
      setUser(null);
      localStorage.removeItem("token");
    }
  };

  return (
    <Router>
      <div style={{ padding: "20px", fontFamily: "Arial, sans-serif" }}>
        {!user ? (
          <div>
            {isSignup ? (
              <div>
                <div
  style={{
    display: "flex",
    justifyContent: "center",
    alignItems: "center",
    height: "100vh",
    backgroundColor: "#f8f9fa",
  }}
>
  <div
    style={{
      width: "400px",
      textAlign: "center",
      padding: "20px",
      backgroundColor: "#fff",
      border: "1px solid #ddd",
      borderRadius: "8px",
      boxShadow: "0 4px 6px rgba(0, 0, 0, 0.1)",
    }}
  >
    <h2>Signup</h2>
    <form onSubmit={handleSignup}>
      <div style={{ marginBottom: "10px" }}>
        <label style={{ display: "block", textAlign: "left" }}>Name:</label>
        <input
          type="text"
          value={name}
          onChange={(e) => setName(e.target.value)}
          required
          style={{
            width: "100%",
            padding: "8px",
            fontSize: "14px",
            border: "1px solid #ccc",
            borderRadius: "4px",
          }}
        />
      </div>
      <div style={{ marginBottom: "10px" }}>
        <label style={{ display: "block", textAlign: "left" }}>Email:</label>
        <input
          type="email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          required
          style={{
            width: "100%",
            padding: "8px",
            fontSize: "14px",
            border: "1px solid #ccc",
            borderRadius: "4px",
          }}
        />
      </div>
      <div style={{ marginBottom: "10px" }}>
        <label style={{ display: "block", textAlign: "left" }}>Password:</label>
        <input
          type="password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          required
          style={{
            width: "100%",
            padding: "8px",
            fontSize: "14px",
            border: "1px solid #ccc",
            borderRadius: "4px",
          }}
        />
      </div>
      {authError && <p style={{ color: "red" }}>{authError}</p>}
      <div style={{ textAlign: "center", marginTop: "20px" }}>
        <button
          type="submit"
          disabled={loading}
          style={{
            padding: "10px 20px",
            fontSize: "16px",
            backgroundColor: "#007bff",
            color: "#fff",
            border: "none",
            borderRadius: "4px",
            cursor: "pointer",
          }}
        >
          {loading ? "Processing..." : "Signup"}
        </button>
      </div>
    </form>
    <p style={{ marginTop: "10px" }}>
      Already have an account?{" "}
      <button
        onClick={() => setIsSignup(false)}
        style={{
          background: "none",
          border: "none",
          color: "#007bff",
          cursor: "pointer",
          textDecoration: "underline",
        }}
      >
        Login
      </button>
    </p>
  </div>
</div>
</div>
            ) : (
              <div style={{ display: "flex", justifyContent: "center", alignItems: "center", height: "100vh", backgroundColor: "#f8f9fa" }}>
              <div style={{ width: "400px",textAlign: "center", padding: "20px", backgroundColor: "#fff", border: "1px solid #ddd", borderRadius: "8px", boxShadow: "0 4px 6px rgba(0, 0, 0, 0.1)" }}>
                <h2>Login</h2>
                <form onSubmit={handleLogin}>
                  <div style={{ marginBottom: "10px" }}>
                    <label style={{ display: "block" }}>Email:</label>
                    <input
                      type="email"
                      value={email}
                      onChange={(e) => setEmail(e.target.value)}
                      required
                      style={{ width: "100%", padding: "8px", fontSize: "14px", border: "1px solid #ccc", borderRadius: "4px" }}
                    />
                  </div>
                  <div style={{ marginBottom: "10px" }}>
                    <label style={{ display: "block" }}>Password:</label>
                    <input
                      type="password"
                      value={password}
                      onChange={(e) => setPassword(e.target.value)}
                      required
                      style={{ width: "100%", padding: "8px", fontSize: "14px", border: "1px solid #ccc", borderRadius: "4px" }}
                    />
                  </div>
                  {authError && <p style={{ color: "red" }}>{authError}</p>}
                  <button
                    type="submit"
                    disabled={loading}
                    style={{
                      padding: "10px 20px",
                      fontSize: "14px",
                      backgroundColor: "#007bff",
                      color: "#fff",
                      border: "none",
                      borderRadius: "4px",
                      cursor: "pointer",
                    }}
                  >
                    {loading ? "Processing..." : "Login"}
                  </button>
                </form>
                <p>
                  Don't have an account?{" "}
                  <button
                    onClick={() => setIsSignup(true)}
                    style={{
                      background: "none",
                      border: "none",
                      color: "#007bff",
                      cursor: "pointer",
                      textDecoration: "underline",
                      marginTop: "10px",
                    }}
                  >
                    Signup
                  </button>
                </p>
              </div>
            </div>
            
            )}
          </div>
        ) : (
          <div>
            <h1>Welcome, {user}!</h1>
            <Routes>
              <Route path="/" element={<Books />} /> {/* Books list */}
              <Route path="/book/:isbn" element={<BookDetails />} /> {/* Book details */}
              <Route path="/checkout" element={<Checkout />} /> {/* Checkout */}
            </Routes>
            <button
              onClick={handleLogout}
              style={{
                padding: "10px 20px",
                fontSize: "16px",
                backgroundColor: "#dc3545",
                color: "#fff",
                border: "none",
                borderRadius: "4px",
                cursor: "pointer",
                marginTop: "20px",
              }}
            >
              Logout
            </button>
          </div>
        )}
      </div>
    </Router>
  );
};


export default App;
