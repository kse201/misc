var gulp = require('gulp')
var nightwatch = require('nightwatch')
var eslint = require('gulp-eslint')

gulp.task('server:test', function (callback) {
  require('./bin/www')
  callback()
})

gulp.task('e2e', ['server:test'], function () {
  nightwatch.runner({
    config: './test/e2e/globals.json',
    env: 'default'
  }, function (passed) {
    if (passed) {
      process.exit()
    } else {
      process.exit(1)
    }
  })
})

gulp.task('unit', function () {

})

gulp.task('lint', function () {
  return gulp.src(['**/*.js', '!node_modules/**'])
    .pipe(eslint())
    .pipe(eslint.format())
    .pipe(eslint.failAfterError())
})

gulp.task('test', ['lint', 'unit', 'e2e'])
