import React, { useEffect, useState } from "react";
import axios from "axios";
import "./pastOrders.css";

const PastOrders = () => {
  const [orders, setOrders] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const API_URL = process.env.REACT_APP_API_URL || "http://localhost:5001";

  useEffect(() => {
    const fetchOrders = async () => {
      const userEmail = localStorage.getItem("userEmail"); 

      if (!userEmail) {
        setError("User email not found. Please log in.");
        setLoading(false);
        return;
      }

      setLoading(true);
      try {
        const response = await axios.get(`${API_URL}/api/orders/${userEmail}`);
        setOrders(response.data);
        setError(null);
      } catch (err) {
        console.error("Error fetching past orders:", err.message);
        setError("Failed to fetch past orders. Please try again later.");
      } finally {
        setLoading(false);
      }
    };

    fetchOrders();
  }, [API_URL]);

  if (loading) return <p>Loading past orders...</p>;
  if (error) return <p style={{ color: "red" }}>{error}</p>;

  return (
    <div className="past-orders-container">
      <h2>Past Orders</h2>
      {orders.length > 0 ? (
        <ul className="orders-list">
          {orders.map((order) => (
            <li key={order.id}>
              <p><strong>Book:</strong> {order.book_name}</p>
              <p><strong>Date:</strong> {new Date(order.purchase_date).toLocaleDateString()}</p>
            </li>
          ))}
        </ul>
      ) : (
        <p>No past orders found.</p>
      )}
    </div>
  );
};

export default PastOrders;
