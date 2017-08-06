client = require 'cheerio-httpcli'
request = require 'request'
URL = require 'url'
fs = require 'fs'
saveDir = __dirname + '/img'

errorHandler = (err) ->
  console.log 'Error:' + err

fs.mkdirSync saveDir if !fs.existsSync(saveDir)

url = 'https://ja.wikipedia.org/wiki/%E3%82%A4%E3%83%8C'
param = {}

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
