import React, { useState } from "react";
import axios from "axios";
import './Login.css';

const Login = ({ onLogin }) => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);

  const handleLogin = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError("");
  
    if (!email || !password) {
      setError("Both email and password are required.");
      console.log("Email or password missing:", { email, password }); 
      setLoading(false);
      return;
    }
  
    console.log("Attempting login with:", { email, password }); 
  
    try {
      const response = await axios.post("http://localhost:5001/login/", { email, password });
      console.log("Login response data:", response.data); 
      localStorage.setItem("token", response.data.token);
      onLogin(response.data.user.name);
      setLoading(false);
    } catch (err) {
      console.error("Login error:", err.response?.data?.error || err.message); 
      setError(err.response?.data?.error || "An error occurred during login.");
      console.log("Error state after login attempt:", err.response?.data?.error || err.message); 
      setLoading(false);
    }
  };
  

  return (
    <div className="login-container">
      <h2 className="login-title">Login</h2>
      <form className="login-form" onSubmit={handleLogin}>
        <div className="form-group">
          <label>Email:</label>
          <input
            type="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
          />
        </div>
        <div className="form-group">
          <label>Password:</label>
          <input
            type="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
            autoComplete="off"
          />
        </div>
        {error && <p className="error-message">{error}</p>}
        <button
          type="submit"
          disabled={loading}
          className="login-button"
        >
          {loading ? "Logging in..." : "Login"}
        </button>
      </form>
    </div>
  );
};

export default Login;