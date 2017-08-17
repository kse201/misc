var express = require('express')
var router = express.Router()
var mongoose = require('mongoose')
mongoose.connect('mongodb://localhost/app')
var User = require('../models/user')

router.route('/')
  .get(function (req, res, next) {
    User.find(function (err, users) {
      if (err) {
        res.send(err)
      }
      res.render('user', {users: users})
    })
  })

  .post(function (req, res, next) {
    var user = new User()
    user.name = req.body.name
    user.age = req.body.age
    console.log(req.body)

    user.save(function (err) {
      if (err) {
        res.send(err)
      }
      res.render('user', {user: user})
    })
  })

router.route('/:id')
  .get(function (req, res, next) {
    User.findById(req.params.id, function (err, user) {
      if (err) {
        res.send(err)
      }
      res.render('user', {user: user})
    })
  })

  .put(function (req, res, next) {
    res.send('Not Implemented: update user')
  })

  .delete(function (req, res, next) {
    res.send('Not Implemented: delete user')
  })

module.exports = router
