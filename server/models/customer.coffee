mongoose = require('mongoose')
v = require('lib/validators')


schema = new mongoose.Schema(
  email:
    type: String
    unique: true
    required: v.required()
    validate: [v.email()]
)

schema.methods.toJSON = ->
  json = @toObject()
  delete json.__v

  json

module.exports = mongoose.model('Customer', schema)
