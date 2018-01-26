'use strict'

const express = require('express')
const PORT = process.env.PORT || 3000

const app = express()

app.post('/webhook', (req, res) => {
  console.log(req.body)
})

app.listen(PORT)
console.log(`Server running at ${PORT}`)
