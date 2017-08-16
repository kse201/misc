var gulp = require('gulp')
var nightwatch = require('nightwatch')

gulp.task('server:test', function(callback){
  require('./bin/www')
  callback()
})


gulp.task('e2e', ['server:test'], function(){
  nightwatch.runner({
    config: './test/e2e/globals.json',
    env: 'default'
  }, function(passed) {
    if (passed){
      process.exit()
    } else {
      process.exit(1)
    }
  })
})
