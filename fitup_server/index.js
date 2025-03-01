///////////////////////////////////////////////////////////////////////////////
// index.js (Node.js + Express server)
///////////////////////////////////////////////////////////////////////////////
const express = require("express");
const cors = require("cors");
const { Pool } = require("pg");

const app = express();
app.use(cors());
app.use(express.json());

// Adjust these credentials for your PostgreSQL instance:
const pool = new Pool({
  user: "postgres",
  host: "localhost",
  database: "fitup",
  password: "tedimafija",
  port: 5432,
});

// 1) /api/login
app.post("/api/login", async (req, res) => {
  const { email, password } = req.body;
  try {
    const userRes = await pool.query("SELECT * FROM users WHERE email = $1", [
      email,
    ]);
    if (userRes.rows.length === 0) {
      return res.status(401).json({ error: "Invalid email" });
    }
    const user = userRes.rows[0];
    if (user.hashed_password !== password) {
      return res.status(401).json({ error: "Invalid password" });
    }
    // success
    res.json({
      success: true,
      userId: user.id,
      fullName: user.full_name,
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error" });
  }
});

// 2) /api/register
app.post("/api/register", async (req, res) => {
  const { fullName, email, password } = req.body;
  try {
    const insertQuery = `
      INSERT INTO users (full_name, email, hashed_password)
      VALUES ($1, $2, $3)
      RETURNING id
    `;
    const result = await pool.query(insertQuery, [fullName, email, password]);
    res.json({ success: true, userId: result.rows[0].id });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error" });
  }
});

// 3) /api/gyms (Example for fetching gyms from DB)
app.get("/api/gyms", async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM gyms");
    res.json(result.rows); // returns an array of gyms
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error" });
  }
});

// Start server
const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
