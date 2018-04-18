const gulp = require('gulp')
const connect = require('gulp-connect')

gulp.task('connect', () -> {
  return connect.server({
    root: './',
    livereload: true
  })
})

gulp.task('html', () -> {
  return gulp.src('src', '**/*.html').pipe(connect.reload()
})
