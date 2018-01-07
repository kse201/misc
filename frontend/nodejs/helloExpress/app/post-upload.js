const express = require('express')
const app = express()

const multer = require('multer')
const path = require('path')

const tmpDir = path.join(__dirname, 'tmp')
const pubDir = path.join(__dirname, 'pub')
const uploader = multer({dest: tmpDir})
const fs = require('fs')

app.listen(3000, () => {
  console.log('Start at http://localhost:3000')
})

app.get('/', (req, res) => {
  fs.readFile(path.join(__dirname, './view/post-upload.html'), 'utf-8', (err, data) => {
    if (err) {
      res.send(err)
    }
    res.send(data)
  })
})

app.use('/pub', express.static(pubDir))

app.post('/', uploader.single('aFile'), (req, res) => {
  console.log('ファイルを受け付けました')
  console.log('オリジナルファイル名: ', req.file.originalname)
  console.log('保存したパス: ', req.file.path)

  if (req.file.mimetype !== 'image/png') {
    res.send('PNG画像以外はアップロードしません')
    return
  }

  const fname = req.file.filename + '.png'
  const des = pubDir + '/' + fname
  fs.rename(req.file.path, des)

  res.send('ファイルを受信しました<br />' +
  `<img src="/pub/${fname}" />`)
})
