const express = require('express')
const path = require('path')
const fs = require('fs')
const app = express()

const bodyPaser = require('body-parser')
app.use(bodyPaser.urlencoded({extended: true}))

app.listen(3000, () => {
  console.log('Start at http://localhost:3000')
})

app.get('/', (req, res) => {
  fs.readFile(path.join(__dirname, './view/post-show.html'), 'utf-8', (err, data) => {
    if (err) {
      res.send(err)
    }
    res.send(data)
  })
})

app.post('/', (req, res) => {
  const s = JSON.stringify(req.body)
  res.send('POSTを受信: ' + s)
})
