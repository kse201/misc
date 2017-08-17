var express = require('express')
var router = express.Router()

router.get('/', function (req, res, next) {
  res.render('user', { message: 'Not Implemented: user list' })
})

router.get('/:id', function (req, res, next) {
  res.send('Not Implemented: user')
})

router.post('/', function (req, res, next) {
  res.send('Not Implemented: create user')
})

router.put('/:id', function (req, res, next) {
  res.send('Not Implemented: update user')
})

router.delete('/:id', function (req, res, next) {
  res.send('Not Implemented: delete user')
})

module.exports = router
