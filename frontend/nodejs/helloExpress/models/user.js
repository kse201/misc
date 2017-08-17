var mongoose = require('mongoose')
var Schema = mongoose.Schema
var ObjectId = Schema.ObjectId

var UserSchema = new Schema({
  id: ObjectId,
  name: String,
  age: {
    type: Number,
    default: 0
  }
})

module.exports = mongoose.model('User', UserSchema)
