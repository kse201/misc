client = require 'cheerio-httpcli'
request = require 'request'
URL = require 'url'
fs = require 'fs'
saveDir = process.cwd() + '/img'

errorHandler = (err) ->
  console.log 'Error:' + err


param = {}

crawlImage =
  fetch: (url) ->
    fs.mkdirSync saveDir if !fs.existsSync(saveDir)
    client.fetch url, param, (err, $, res) ->
      if err
        errorHandler err
        return
      $('img').each (idx) ->
        src = $(this).attr('src')
        src = URL.resolve(url, src)
        fname = URL.parse(src).pathname
        fname = saveDir + '/' + fname.replace(/[^a-zA-z0-9l.]/g, '_')
        request(src).pipe fs.createWriteStream(fname)

module.exports = crawlImage
