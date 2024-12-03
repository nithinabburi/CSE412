import React, { useState } from "react";
import { useLocation } from "react-router-dom";
import axios from "axios";
import './Checkout.css';

const Checkout = ({ bookl }) => {
    const location = useLocation();
    const { book } = location.state || {}; 
  
    const [shippingAddress, setShippingAddress] = useState("");
    const [billingAddress, setBillingAddress] = useState("");
    const [sameAsShipping, setSameAsShipping] = useState(false);
    const [creditCardNumber, setCreditCardNumber] = useState("");
    const [expirationDate, setExpirationDate] = useState("");
    const [cvv, setCvv] = useState("");
    const [error, setError] = useState(null);
    const userEmail = localStorage.getItem("userEmail"); 
    const token = localStorage.getItem("token"); 
  

    const API_URL = process.env.REACT_APP_API_URL || "http://localhost:5001";

    const handleCheckboxChange = () => {
        if (sameAsShipping) {
            setBillingAddress("");
        } else {
            setBillingAddress(shippingAddress);
        }
        setSameAsShipping(!sameAsShipping);
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setError(null);

        if (
            !shippingAddress ||
            !billingAddress ||
            !creditCardNumber ||
            !expirationDate ||
            !cvv
        ) {
            setError("Please fill in all required fields.");
            return;
        }

        try {
            console.log("Book purchased:", book.name);
            
            alert("Purchase completed successfully!");

            
            const response = await axios.post(`${API_URL}/api/purchase`, {
                
                email: userEmail,
                book_isbn: book.isbn,
                book_name: book.name,
            });

            console.log("Purchase response:", response.data);
        } catch (err) {
            console.error("Error storing purchase:", err.message);
            alert("Failed to store purchase. Please try again.");
        }
    };

    return (
        <div className="checkout-container">
          <h1 className="checkout-title">Checkout</h1>
          <p className="checkout-book">Book: {book.name}</p>
          <form className="checkout-form" onSubmit={handleSubmit}>
            <div className="form-group">
              <label>Shipping Address:</label>
              <textarea
                value={shippingAddress}
                onChange={(e) => setShippingAddress(e.target.value)}
                required
              />
            </div>
    
            <div className="form-group same-as-shipping">
              <input
                type="checkbox"
                checked={sameAsShipping}
                onChange={handleCheckboxChange}
              />
              <label>Billing Address Same as Shipping Address</label>
            </div>
    
            {!sameAsShipping && (
              <div className="form-group">
                <label>Billing Address:</label>
                <textarea
                  value={billingAddress}
                  onChange={(e) => setBillingAddress(e.target.value)}
                  required
                />
              </div>
            )}
    
            <div className="form-group">
              <label>Credit Card Number:</label>
              <input
                type="text"
                value={creditCardNumber}
                onChange={(e) => setCreditCardNumber(e.target.value)}
                required
                maxLength={16}
                placeholder="1234 5678 9012 3456"
              />
            </div>
    
            <div className="form-row">
              <div className="form-group">
                <label>Expiration Date:</label>
                <input
                  type="text"
                  value={expirationDate}
                  onChange={(e) => setExpirationDate(e.target.value)}
                  required
                  placeholder="MM/YY"
                  maxLength={5}
                />
              </div>
    
              <div className="form-group">
                <label>CVV:</label>
                <input
                  type="text"
                  value={cvv}
                  onChange={(e) => setCvv(e.target.value)}
                  required
                  maxLength={3}
                  placeholder="123"
                />
              </div>
            </div>
    
            {error && <p className="error-message">{error}</p>}
    
            <button type="submit" className="complete-purchase-button">
              Complete Purchase
            </button>
          </form>
        </div>
      );
    };
    
    export default Checkout;