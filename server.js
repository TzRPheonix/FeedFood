import express from "express"
import { connectToMongo, db } from "./data.js"

const app = express()

app.use(express.json())

app.get("/api", async (req, res) => {
  try {
    const database = db
    // Get the collection
    const result = await database.collection('collecTest').find({}).toArray();
    
    // Return the documents as a JSON response
    res.json(result);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: error.message });
  }
})

connectToMongo(()=>{
    app.listen(3307, () => console.log("Server Started"));
})
