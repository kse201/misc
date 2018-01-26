var casper = require('casper').create()

casper.start()

var width = 1400
var height = 800

casper.viewport(width, height)
userAgents = [
  'Mozilla/5.0 (Windows NT 6.1: WOW64)',
  'AppleWebKit/537.36 (KHTML, like Gecko)',
  'Chrome/37.0.2062.120',
  'Safari/537.36'
].join(' ')
casper.userAgent('Uesr-Agent: ' + userAgents)

var text = encodeURIComponent('ネコ')
var search_url = 'http://www.flickr.com/search/?text='
casper.open(search_url + text)

casper.then(function(){
 this.capture('flickr-cat.png', {
   top:0, left: 0, width: width, height: height
 })
})

casper.run()
