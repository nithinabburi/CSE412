import React, { useState } from "react";
import axios from "axios";

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
      console.log("Email or password missing:", { email, password }); // Debug log
      setLoading(false);
      return;
    }
  
    console.log("Attempting login with:", { email, password }); // Debug log
  
    try {
      const response = await axios.post("http://localhost:5001/login/", { email, password });
      console.log("Login response data:", response.data); // Debug log
      localStorage.setItem("token", response.data.token);
      onLogin(response.data.user.name);
      setLoading(false);
    } catch (err) {
      console.error("Login error:", err.response?.data?.error || err.message); // Debug log
      setError(err.response?.data?.error || "An error occurred during login.");
      console.log("Error state after login attempt:", err.response?.data?.error || err.message); // Debug log
      setLoading(false);
    }
  };
  

  return (
    <div style={{ padding: "20px", fontFamily: "Arial, sans-serif" }}>
      <h2>Login</h2>
      <form onSubmit={handleLogin}>
        <div style={{ marginBottom: "10px" }}>
          <label style={{ display: "block", marginBottom: "5px" }}>Email:</label>
          <input
            type="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
            style={{
              width: "100%",
              padding: "8px",
              border: "1px solid #ccc",
              borderRadius: "4px",
            }}
          />
        </div>
        <div style={{ marginBottom: "10px" }}>
          <label style={{ display: "block", marginBottom: "5px" }}>Password:</label>
          <input
            type="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
            autoComplete="off"
            style={{
              width: "100%",
              padding: "8px",
              border: "1px solid #ccc",
              borderRadius: "4px",
            }}
          />
        </div>
        {error && <p style={{ color: "red", marginBottom: "10px" }}>{error}</p>}
        <button
          type="submit"
          disabled={loading}
          style={{
            padding: "10px 20px",
            backgroundColor: loading ? "#ccc" : "#4CAF50",
            color: "#fff",
            border: "none",
            borderRadius: "4px",
            cursor: loading ? "not-allowed" : "pointer",
          }}
        >
          {loading ? "Logging in..." : "Login"}
        </button>
      </form>
    </div>
  );
};

export default Login;
