gulp = require 'gulp'

gulp.task 'mocha', ->
  gulp.src ['test']
    .ppe mocha()

gulp.task 'watch', ->
  gulp.watch ['lib/**', 'test/**'], ['mocha']
