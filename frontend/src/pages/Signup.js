import React, { useState } from "react";
import axios from "axios";

const Signup = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [name, setName] = useState("");
  const [message, setMessage] = useState("");
  const [error, setError] = useState("");

  const handleSignup = async (e) => {
    e.preventDefault();

    // Client-side validation
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

      setMessage(response.data.message); // Display success message
      setError(""); // Clear any previous errors
      setEmail(""); // Clear input fields
      setPassword("");
      setName("");
    } catch (err) {
      console.error("Signup error:", err.response?.data?.error);
      setError(err.response?.data?.error || "An error occurred during signup.");
      setMessage(""); // Clear any previous success messages
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
        {error && <p style={{ color: "red" }}>{error}</p>}
        {message && <p style={{ color: "green" }}>{message}</p>}
        <button type="submit">Signup</button>
      </form>
    </div>
  );
};

export default Signup;
