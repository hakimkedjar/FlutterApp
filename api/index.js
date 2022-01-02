const express = require("express")
const app = express()
const mongoose = require("mongoose")
const dotenv = require('dotenv').config()
const PORT = '8080' // Should be define by Docker // default ports on servers are 80
const cors = require('cors') // Configurer

app.use(cors()) // Cors Authorization
app.use(express.json()) // Allow JSON parsing
app.use(express.urlencoded({extended: true})) // Allow body parsing

mongoose.connect(process.env.URL_DATABASE, { useNewUrlParser: true, useUnifiedTopology: true },
    (error) => {
      if (error)
        console.log("MongoDB connection error: " + error)
      else
        console.log("MongoDB connection successful")
    })

app.use('/article', require('./routes/route.article'))
app.use('/account', require('./routes/route.account'))
app.use('/terminal', require('./routes/route.terminal'))

app.listen(PORT, '0.0.0.0', () => {console.log('Listening on port: ' + PORT)})

// TO DO
// Implémenter la route "pay"
// Setup Docker
// Implémenter tests unitaires (Axios pour faire des requêtes)
// Remplir la DB d'articles
