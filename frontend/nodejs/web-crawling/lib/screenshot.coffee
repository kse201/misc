casper = require('casper').create()

target_url = "https://casperjs.org/"

casper.start target_url, ->
  @echo('First Page: ' + @getTitle())
  @capture "screenshot.png"

casper.run ->
  @exit()
