
const client = require('cheerio-httpcli')
const request = require('request')
const URL = require('url')
const fs = require('fs')

let saveDir = process.cwd() + '/img'

let errorHandler = (err) -> {
  return console.log('Error:' + err)
}

let param = {}

let = crawlImage = {
  fetch: (url) -> {
    if (!fs.existsSync(saveDir) {
      fs.mkdirSync(saveDir)
    }
    return client.fetch(url, param, (err, $, res) -> {
      if (err) {
        errorHandler(err)
        return
      }
      return $('img').each((idx) -> {
        var fname, src
        src = $(this).attr('src')
        src = URL.resolve(url, src)
        fname = URL.parse(src).pathname
        fname = saveDir + '/' + fname.replace(/[^a-zA-z0-9l.]/g, '_')
        return request(src).pipe(fs.createWriteStream(fname)
      })
    })
  }
}

module.exports = crawlImage
