///////////////////////////////////////////////////////////////////////////////
// index.js (Node.js + Express server)
///////////////////////////////////////////////////////////////////////////////
const express = require("express");
const cors = require("cors");
const { Pool } = require("pg");

const app = express();
app.use(cors());
app.use(express.json());

// Adjust for your own local PG info:
const pool = new Pool({
  user: "postgres",
  host: "localhost",
  database: "fitup",
  password: "tedimafija",
  port: 5432,
});

// 1) /api/register
app.post("/api/register", async (req, res) => {
  const { fullName, email, password, gender, dob, height_cm, weight_kg } =
    req.body;

  // Insert new user
  try {
    const insertQuery = `
      INSERT INTO users
        (full_name, email, hashed_password, gender, dob, height_cm, weight_kg)
      VALUES
        ($1, $2, $3, $4, $5, $6, $7)
      RETURNING id, full_name
    `;
    const result = await pool.query(insertQuery, [
      fullName,
      email,
      password,
      gender,
      dob, // 'YYYY-MM-DD' string or date
      height_cm, // int
      weight_kg, // int
    ]);
    const newId = result.rows[0].id;
    const newName = result.rows[0].full_name;
    // Return success + user info to log in automatically
    res.json({
      success: true,
      userId: newId,
      fullName: newName,
      gender,
      dob,
      height_cm,
      weight_kg,
    });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: "Server error" });
  }
});

// 2) /api/login
app.post("/api/login", async (req, res) => {
  const { email, password } = req.body;
  try {
    const userRes = await pool.query("SELECT * FROM users WHERE email=$1", [
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
      gender: user.gender,
      dob: user.dob,
      height_cm: user.height_cm || 0,
      weight_kg: user.weight_kg || 0,
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error" });
  }
});

// 3) GET /api/userdetails/:userId
app.get("/api/userdetails/:userId", async (req, res) => {
  const { userId } = req.params;
  try {
    const q = await pool.query("SELECT * FROM users WHERE id=$1", [userId]);
    if (q.rows.length === 0) {
      return res.json({ error: "User not found" });
    }
    const u = q.rows[0];
    return res.json({
      fullName: u.full_name,
      email: u.email,
      gender: u.gender || "Unknown",
      dob: u.dob,
      height_cm: u.height_cm || 0,
      weight_kg: u.weight_kg || 0,
    });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: "Server error" });
  }
});

// 4) POST /api/favorites/add
app.post("/api/favorites/add", async (req, res) => {
  const { userId, favoriteType, favoriteId } = req.body;
  if (!userId) return res.status(400).json({ error: "No userId" });
  if (!favoriteType) return res.status(400).json({ error: "No favoriteType" });
  if (!favoriteId) return res.status(400).json({ error: "No favoriteId" });

  try {
    await pool.query(
      `INSERT INTO user_favorites (user_id, favorite_type, favorite_id)
       VALUES ($1,$2,$3)
       ON CONFLICT DO NOTHING
      `,
      [userId, favoriteType, favoriteId]
    );
    return res.json({ success: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error" });
  }
});

// 5) GET /api/favorites/:userId
app.get("/api/favorites/:userId", async (req, res) => {
  const { userId } = req.params;
  try {
    // Gather all the user's favorites
    const favs = await pool.query(
      `SELECT favorite_type, favorite_id
       FROM user_favorites
       WHERE user_id=$1
      `,
      [userId]
    );
    // We'll create arrays for each type
    const workouts = [];
    const gyms = [];
    const trainers = [];
    for (let row of favs.rows) {
      if (row.favorite_type === "workout") {
        workouts.push(row.favorite_id);
      } else if (row.favorite_type === "gym") {
        gyms.push(row.favorite_id);
      } else if (row.favorite_type === "trainer") {
        trainers.push(row.favorite_id);
      }
    }
    // You might do a join or fetch full data if you want
    return res.json({ success: true, workouts, gyms, trainers });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error" });
  }
});

// 6) GET /api/gyms
app.get("/api/gyms", async (req, res) => {
  try {
    const gRes = await pool.query("SELECT * FROM gyms");
    return res.json({ success: true, gyms: gRes.rows });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error" });
  }
});

// Example trainers if you want:
app.get("/api/trainers", async (req, res) => {
  try {
    const tRes = await pool.query("SELECT * FROM trainers");
    return res.json({ success: true, trainers: tRes.rows });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error" });
  }
});

const PORT = 3000;
app.listen(PORT, () => {
  console.log("Server up on http://localhost:" + PORT);
});
