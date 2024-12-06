PostgreSQL with ReactJS Project

A full-stack web application using PostgreSQL for the database, ReactJS for the frontend, and Node.js with Express for the backend.

Project Structure

Frontend: Built with ReactJS to provide a dynamic user interface.
Backend: Built with Node.js and Express, interacting with a PostgreSQL database.
Database: PostgreSQL serves as the primary database for storing and managing data.
Prerequisites

Ensure the following are installed on your system:

Node.js (Includes npm)
PostgreSQL (Database server)
(Optional) pgAdmin (GUI tool for PostgreSQL)

Backend Setup
Navigate to the backend directory:
cd backend
Install backend dependencies:
npm install express pg dotenv cors body-parser
node server.js

For Now I have my details put in the .env file, you run the backend without restoring the database for testing purposes.

Create a .env file for environment variables:
DB_HOST=localhost
DB_PORT=5432
DB_USER=<your_database_username>
DB_PASSWORD=<your_database_password>
DB_NAME=<your_database_name>


Frontend Setup
Navigate to the frontend directory:
cd ../frontend
Install frontend dependencies:
npm install react react-dom react-scripts axios react-router-dom
Start the React development server:
npm start


How to Run the Project

Start the PostgreSQL database.
Run the backend server:
cd backend
node server.js

Run the frontend:
cd frontend
npm start
Access the app in your browser at http://localhost:3000.
