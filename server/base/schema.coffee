mongoose = require('mongoose')
uniqueValidator = require('mongoose-unique-validator')


module.exports = (fields) ->
  schema = new mongoose.Schema(fields)

  schema.methods.toJSON = ->
    json = @toObject()
    delete json.__v

    json

  schema.plugin(uniqueValidator, message: 'unique')

  schema


