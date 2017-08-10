gulp = require 'gulp'
connect = require 'gulp-connect'

gulp.task('connect', ()->
  connect.server({
    root: './',
    livereload: true
  })
)
gulp.task('html', ->
  gulp.src('src', '**/*.html').pipe(connect.reload())
)
