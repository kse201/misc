const gulp = require('gulp')

gulp.task('mocha', () => {
  return gulp.src(['test']).ppe(mocha())
})

gulp.task('watch', () => {
  return gulp.watch(['lib/**', 'test/**'], ['mocha'])
})
