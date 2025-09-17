const express = require("express")
const cors = require("cors")
const { Pool } = require("pg")

const app = express()
app.use(cors())
app.use(express.json())


const pool = new Pool({
  user: "postgres",
  host: "localhost",
  database: "fitup",
  password: "tedimafija",
  port: 5432,
})

// 1) /api/register
app.post("/api/register", async (req, res) => {
  const { fullName, email, password, gender, dob, height_cm, weight_kg } = req.body

  // Insert new user
  try {
    const insertQuery = `
      INSERT INTO users
        (full_name, email, hashed_password, gender, dob, height_cm, weight_kg)
      VALUES
        ($1, $2, $3, $4, $5, $6, $7)
      RETURNING id, full_name
    `
    const result = await pool.query(insertQuery, [
      fullName,
      email,
      password,
      gender,
      dob, // 'YYYY-MM-DD' string or date
      height_cm, // int
      weight_kg, // int
    ])
    const newId = result.rows[0].id
    const newName = result.rows[0].full_name
    // Return success + user info to log in automatically
    res.json({
      success: true,
      userId: newId,
      fullName: newName,
      gender,
      dob,
      height_cm,
      weight_kg,
    })
  } catch (err) {
    console.error(err)
    return res.status(500).json({ error: "Server error" })
  }
})

// 2) /api/login
app.post("/api/login", async (req, res) => {
  const { email, password } = req.body
  try {
    const userRes = await pool.query("SELECT * FROM users WHERE email=$1", [email])
    if (userRes.rows.length === 0) {
      return res.status(401).json({ error: "Invalid email" })
    }
    const user = userRes.rows[0]
    if (user.hashed_password !== password) {
      return res.status(401).json({ error: "Invalid password" })
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
    })
  } catch (err) {
    console.error(err)
    res.status(500).json({ error: "Server error" })
  }
})

// 3) GET /api/userdetails/:userId
app.get("/api/userdetails/:userId", async (req, res) => {
  const { userId } = req.params
  try {
    const q = await pool.query("SELECT * FROM users WHERE id=$1", [userId])
    if (q.rows.length === 0) {
      return res.json({ error: "User not found" })
    }
    const u = q.rows[0]
    return res.json({
      fullName: u.full_name,
      email: u.email,
      gender: u.gender || "Unknown",
      dob: u.dob,
      height_cm: u.height_cm || 0,
      weight_kg: u.weight_kg || 0,
    })
  } catch (err) {
    console.error(err)
    return res.status(500).json({ error: "Server error" })
  }
})

// 4) POST /api/favorites/toggle - Toggle favorite status
app.post("/api/favorites/toggle", async (req, res) => {
  const { userId, favoriteType, favoriteId } = req.body
  if (!userId) return res.status(400).json({ error: "No userId" })
  if (!favoriteType) return res.status(400).json({ error: "No favoriteType" })
  if (!favoriteId) return res.status(400).json({ error: "No favoriteId" })

  try {
    // Check if favorite already exists
    const existingFav = await pool.query(
      `SELECT * FROM user_favorites 
       WHERE user_id=$1 AND favorite_type=$2 AND favorite_id=$3`,
      [userId, favoriteType, favoriteId],
    )

    if (existingFav.rows.length > 0) {
      // Remove from favorites
      await pool.query(
        `DELETE FROM user_favorites 
         WHERE user_id=$1 AND favorite_type=$2 AND favorite_id=$3`,
        [userId, favoriteType, favoriteId],
      )
      return res.json({ success: true, action: "removed", isFavorite: false })
    } else {
      // Add to favorites
      await pool.query(
        `INSERT INTO user_favorites (user_id, favorite_type, favorite_id)
         VALUES ($1,$2,$3)`,
        [userId, favoriteType, favoriteId],
      )
      return res.json({ success: true, action: "added", isFavorite: true })
    }
  } catch (err) {
    console.error(err)
    res.status(500).json({ error: "Server error" })
  }
})

// 5) GET /api/favorites/check/:userId/:favoriteType/:favoriteId
app.get("/api/favorites/check/:userId/:favoriteType/:favoriteId", async (req, res) => {
  const { userId, favoriteType, favoriteId } = req.params
  try {
    const result = await pool.query(
      `SELECT * FROM user_favorites 
       WHERE user_id=$1 AND favorite_type=$2 AND favorite_id=$3`,
      [userId, favoriteType, favoriteId],
    )
    return res.json({
      success: true,
      isFavorite: result.rows.length > 0,
    })
  } catch (err) {
    console.error(err)
    res.status(500).json({ error: "Server error" })
  }
})

// 6) GET /api/favorites/:userId
app.get("/api/favorites/:userId", async (req, res) => {
  const { userId } = req.params
  try {
    // Gather all the user's favorites with detailed information
    const favs = await pool.query(
      `SELECT uf.favorite_type, uf.favorite_id,
              CASE 
                WHEN uf.favorite_type = 'workout' THEN w.workout_name
                WHEN uf.favorite_type = 'gym' THEN g.gym_name
                WHEN uf.favorite_type = 'trainer' THEN t.trainer_name
              END as name,
              CASE 
                WHEN uf.favorite_type = 'workout' THEN w.difficulty
                WHEN uf.favorite_type = 'gym' THEN g.location
                WHEN uf.favorite_type = 'trainer' THEN CAST(t.rating AS TEXT)
              END as details
       FROM user_favorites uf
       LEFT JOIN workouts w ON uf.favorite_type = 'workout' AND uf.favorite_id = w.id
       LEFT JOIN gyms g ON uf.favorite_type = 'gym' AND uf.favorite_id = g.id
       LEFT JOIN trainers t ON uf.favorite_type = 'trainer' AND uf.favorite_id = t.id
       WHERE uf.user_id=$1
       ORDER BY uf.favorite_type, uf.favorite_id`,
      [userId],
    )

    const workouts = []
    const gyms = []
    const trainers = []

    for (const row of favs.rows) {
      const item = {
        id: row.favorite_id,
        name: row.name,
        details: row.details,
      }

      if (row.favorite_type === "workout") {
        workouts.push(item)
      } else if (row.favorite_type === "gym") {
        gyms.push(item)
      } else if (row.favorite_type === "trainer") {
        trainers.push(item)
      }
    }

    return res.json({ success: true, workouts, gyms, trainers })
  } catch (err) {
    console.error(err)
    res.status(500).json({ error: "Server error" })
  }
})

// 7) GET /api/workout/:workoutName/:difficulty
app.get("/api/workout/:workoutName/:difficulty", async (req, res) => {
  const { workoutName, difficulty } = req.params
  try {
    // Get workout details
    const workoutQuery = await pool.query(
      `SELECT w.*, 
              COUNT(DISTINCT we.exercise_id) as exercise_count,
              COALESCE(SUM(e.default_duration), 0) as total_duration_seconds
       FROM workouts w
       LEFT JOIN workout_exercises we ON w.id = we.workout_id
       LEFT JOIN exercises e ON we.exercise_id = e.id
       WHERE LOWER(w.workout_name) = LOWER($1) AND LOWER(w.difficulty) = LOWER($2)
       GROUP BY w.id
       LIMIT 1`,
      [workoutName, difficulty],
    )

    if (workoutQuery.rows.length === 0) {
      return res.status(404).json({ error: "Workout not found" })
    }

    const workout = workoutQuery.rows[0]

    // Get exercises for this workout
    const exercisesQuery = await pool.query(
      `SELECT e.*, we.set_number, we.order_index
       FROM workout_exercises we
       JOIN exercises e ON we.exercise_id = e.id
       WHERE we.workout_id = $1
       ORDER BY we.set_number, we.order_index`,
      [workout.id],
    )

    // Get equipment for this workout
    const equipmentQuery = await pool.query(
      `SELECT eq.*
       FROM workout_equipment we
       JOIN equipment eq ON we.equipment_id = eq.id
       WHERE we.workout_id = $1`,
      [workout.id],
    )

    // Format duration
    const totalMinutes = Math.ceil(workout.total_duration_seconds / 60)
    const hours = Math.floor(totalMinutes / 60)
    const minutes = totalMinutes % 60
    const durationText = hours > 0 ? `${hours}h ${minutes}min` : `${minutes}min`

    return res.json({
      success: true,
      workout: {
        id: workout.id,
        name: workout.workout_name,
        difficulty: workout.difficulty,
        exerciseCount: workout.exercise_count,
        duration: durationText,
        durationMinutes: totalMinutes,
        caloriesBurn: workout.calories_burn,
        sets: workout.number_of_sets,
        exercises: exercisesQuery.rows,
        equipment: equipmentQuery.rows,
      },
    })
  } catch (err) {
    console.error(err)
    res.status(500).json({ error: "Server error" })
  }
})

// 8) GET /api/upcoming-workouts/:userId
app.get("/api/upcoming-workouts/:userId", async (req, res) => {
  const { userId } = req.params
  try {
    const upcomingQuery = await pool.query(
      `SELECT ws.*, w.workout_name, w.difficulty
       FROM workout_schedules ws
       JOIN workouts w ON ws.workout_id = w.id
       WHERE ws.user_id = $1 
         AND (ws.scheduled_date > CURRENT_DATE 
              OR (ws.scheduled_date = CURRENT_DATE AND ws.start_time > CURRENT_TIME))
         AND ws.completed = false
       ORDER BY ws.scheduled_date, ws.start_time
       LIMIT 10`,
      [userId],
    )

    return res.json({
      success: true,
      workouts: upcomingQuery.rows,
    })
  } catch (err) {
    console.error(err)
    res.status(500).json({ error: "Server error" })
  }
})

// 9) POST /api/schedule-workout
app.post("/api/schedule-workout", async (req, res) => {
  const { userId, workoutName, difficulty, scheduledDate, startTime } = req.body

  if (!userId || !workoutName || !difficulty || !scheduledDate || !startTime) {
    return res.status(400).json({ error: "Missing required fields" })
  }

  try {
    // Find the workout by name and difficulty
    const workoutQuery = await pool.query(
      `SELECT w.*, COALESCE(SUM(e.default_duration), 0) as total_duration_seconds
       FROM workouts w
       LEFT JOIN workout_exercises we ON w.id = we.workout_id
       LEFT JOIN exercises e ON we.exercise_id = e.id
       WHERE LOWER(w.workout_name) = LOWER($1) AND LOWER(w.difficulty) = LOWER($2)
       GROUP BY w.id
       LIMIT 1`,
      [workoutName, difficulty],
    )

    if (workoutQuery.rows.length === 0) {
      return res.status(404).json({ error: "Workout not found" })
    }

    const workout = workoutQuery.rows[0]

    // Calculate end time
    const startDateTime = new Date(`${scheduledDate}T${startTime}`)
    const endDateTime = new Date(startDateTime.getTime() + workout.total_duration_seconds * 1000)
    const endTime = endDateTime.toTimeString().slice(0, 5) // HH:MM format

    // Insert into workout_schedules
    const scheduleQuery = await pool.query(
      `INSERT INTO workout_schedules (user_id, workout_id, scheduled_date, start_time, end_time, completed)
       VALUES ($1, $2, $3, $4, $5, false)
       RETURNING *`,
      [userId, workout.id, scheduledDate, startTime, endTime],
    )

    return res.json({
      success: true,
      schedule: scheduleQuery.rows[0],
    })
  } catch (err) {
    console.error(err)
    res.status(500).json({ error: "Server error" })
  }
})

// 10) GET /api/gyms
app.get("/api/gyms", async (req, res) => {
  try {
    const gRes = await pool.query("SELECT * FROM gyms")
    return res.json({ success: true, gyms: gRes.rows })
  } catch (err) {
    console.error(err)
    res.status(500).json({ error: "Server error" })
  }
})

// 11) GET /api/trainers
app.get("/api/trainers", async (req, res) => {
  try {
    const tRes = await pool.query("SELECT * FROM trainers")
    return res.json({ success: true, trainers: tRes.rows })
  } catch (err) {
    console.error(err)
    res.status(500).json({ error: "Server error" })
  }
})

const PORT = 3000
app.listen(PORT, () => {
  console.log("Server up on http://localhost:" + PORT)
})
