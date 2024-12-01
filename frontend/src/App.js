import React, { useEffect, useState, useCallback } from "react";
import axios from "axios";
import Books from "./components/books"; // Adjusted path to import Books component
import BookDetails from "./components/BookDetails"; // Import BookDetails component
import { BrowserRouter as Router, Routes, Route } from "react-router-dom"; // Import React Router

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
    try {
      const response = await axios.post(`${API_URL}/users/login`, {
        email,
        password,
      });
      console.log("Login response:", response.data);
      localStorage.setItem("token", response.data.token);
      setUser(response.data.user.name);
    } catch (err) {
      console.error("Login error:", err.response?.data?.error || err.message);
      setAuthError("Invalid email or password. Please try again.");
    }
  };

  const handleSignup = async (e) => {
    e.preventDefault();
    setAuthError(null);
    try {
      await axios.post(`${API_URL}/users/register`, {
        email,
        password,
        name,
      });
      alert("Signup successful! Please log in.");
      setIsSignup(false);
    } catch (err) {
      console.error("Signup error:", err.message);
      setAuthError("Signup failed. Please try again.");
    }
  };

  return (
    <Router>
      <div style={{ padding: "20px", fontFamily: "Arial, sans-serif" }}>
        {!user ? (
          <div>
            {isSignup ? (
              <div>
                <h2>Signup</h2>
                <form onSubmit={handleSignup}>
                  <div>
                    <label>Name:</label>
                    <input
                      type="text"
                      value={name}
                      onChange={(e) => setName(e.target.value)}
                      required
                    />
                  </div>
                  <div>
                    <label>Email:</label>
                    <input
                      type="email"
                      value={email}
                      onChange={(e) => setEmail(e.target.value)}
                      required
                    />
                  </div>
                  <div>
                    <label>Password:</label>
                    <input
                      type="password"
                      value={password}
                      onChange={(e) => setPassword(e.target.value)}
                      required
                    />
                  </div>
                  {authError && <p style={{ color: "red" }}>{authError}</p>}
                  <button type="submit" disabled={loading}>
                    {loading ? "Processing..." : "Signup"}
                  </button>
                </form>
                <p>
                  Already have an account?{" "}
                  <button onClick={() => setIsSignup(false)}>Login</button>
                </p>
              </div>
            ) : (
              <div>
                <h2>Login</h2>
                <form onSubmit={handleLogin}>
                  <div>
                    <label>Email:</label>
                    <input
                      type="email"
                      value={email}
                      onChange={(e) => setEmail(e.target.value)}
                      required
                    />
                  </div>
                  <div>
                    <label>Password:</label>
                    <input
                      type="password"
                      value={password}
                      onChange={(e) => setPassword(e.target.value)}
                      required
                    />
                  </div>
                  {authError && <p style={{ color: "red" }}>{authError}</p>}
                  <button type="submit" disabled={loading}>
                    {loading ? "Processing..." : "Login"}
                  </button>
                </form>
                <p>
                  Don't have an account?{" "}
                  <button onClick={() => setIsSignup(true)}>Signup</button>
                </p>
              </div>
            )}
          </div>
        ) : (
          <div>
            <h1>Welcome, {user}!</h1>
            <Routes>
              <Route path="/" element={<Books />} /> {/* Books list */}
              <Route path="/book/:isbn" element={<BookDetails />} /> {/* Book details */}
            </Routes>
            <button
              onClick={() => {
                if (window.confirm("Are you sure you want to log out?")) {
                  setUser(null);
                  localStorage.removeItem("token");
                }
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
