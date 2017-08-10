gulp = require 'gulp'
mocha = require 'gulp-mocha'

gulp.task 'mocha', ->
  gulp.src ['test']
      .pipe mocha()

gulp.task 'watch', ->
  gulp.watch(['lib/**', 'test/**'], ['mocha'])
