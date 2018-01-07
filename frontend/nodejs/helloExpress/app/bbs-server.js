const NeDB = require('nedb')
const path = require('path')
const db = new NeDB({
  filename: path.join(__dirname, 'bbs.db'),
  autoload: true
})

const express = require('express')
const app = express()
const PORT = process.env.PORT || 3000

app.listen(PORT, () => {
  console.log('起動しました', `http://localhost:${PORT}`)
})

app.use('/public', express.static('./public'))
