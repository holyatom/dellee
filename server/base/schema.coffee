mongoose = require('mongoose')
uniqueValidator = require('mongoose-unique-validator')



module.exports = (fields) ->
  schema = new mongoose.Schema(fields)

  schema.methods.toJSON = ->
    json = @toObject()
    delete json.__v

    json

  hasCreatedField = !!schema.path('created')
  hasUpdatedField = !!schema.path('updated')

  schema.pre 'save', (next) ->
    @created = new Date() if hasCreatedField and @isNew
    @updated = new Date() if hasUpdatedField

    next()

  if hasUpdatedField
    schema.pre 'findOneAndUpdate', (next) ->
      if @op is 'findOneAndUpdate'
        @_update ?= {}
        @_update.updated = new Date()

      next()

    schema.pre 'update', (next) ->
      if @op is 'update'
        @_update ?= {}
        @_update.updated = new Date()

      next()

  schema.plugin(uniqueValidator, message: 'unique')

  schema


