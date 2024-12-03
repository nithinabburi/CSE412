import React, { useState } from "react";
import axios from "axios";
import './Signup.css';

const Signup = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [name, setName] = useState("");
  const [message, setMessage] = useState("");
  const [error, setError] = useState("");

  const handleSignup = async (e) => {
    e.preventDefault();

    
    if (!email || !password || !name) {
      setError("All fields are required.");
      return;
    }

    try {
      const response = await axios.post("http://localhost:5001/users/register", {
        email,
        password,
        name,
      });

      setMessage(response.data.message); 
      setError(""); 
      setEmail(""); 
      setPassword("");
      setName("");
    } catch (err) {
      console.error("Signup error:", err.response?.data?.error);
      setError(err.response?.data?.error || "An error occurred during signup.");
      setMessage(""); 
    }
  };

  return (
    <div className="signup-container">
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
        {error && <p className="error-message">{error}</p>}
        {message && <p className="success-message">{message}</p>}
        <button type="submit">Signup</button>
      </form>
    </div>
  );
};

export default Signup;