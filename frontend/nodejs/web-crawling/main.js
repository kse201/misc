var client = require('cheerio-httpcli')
var request = require('request')
var URL = require('url')
var fs = require('fs')

var saveDir = __dirname + '/img'
if (!fs.existsSync(saveDir)){
  fs.mkdirSync(saveDir)
}

var url = 'https://ja.wikipedia.org/wiki/%E3%82%A4%E3%83%8C'
var param = {}

function errorHandler(err){
  console.log('Error:' + err)
}

client.fetch(url, param, function(err, $ ,res) {
  if (err) {
    errorHandler(err)
    return
  }

  $('img').each(function(idx) {
    var src =$(this).attr('src')
    src = URL.resolve(url, src)
    var fname = URL.parse(src).pathname
    fname = saveDir + '/' + fname.replace(/[^a-zA-z0-9l.]/g, '_')

    request(src).pipe(fs.createWriteStream(fname))
  })
})
