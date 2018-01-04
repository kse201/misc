'use strict'

const express = require('express')
const bodyPaser = require('body-parser')
const upload = require('multer')()
const PORT = process.env.PORT || 3000
const slack = require('./lib/slack')

const app = express()
app.use(bodyPaser.json())
app.use(bodyPaser.urlencoded())

app.post('/webhook', upload.array(), (req, res) => {
  console.log(req.body.post)
  slack.post(req.body.post)
  res.send(req.body.post)
})

app.listen(PORT)
console.log(`Server running at ${PORT}`)
