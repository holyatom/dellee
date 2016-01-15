mongoose = require('mongoose')
bcrypt = require('bcryptjs')
v = require('lib/validators')
Schema = require('../base/schema')


schema = Schema(
  email:
    type: String
    unique: true
    required: v.required()
    validate: [v.email()]

  password:
    type: String
    required: v.required()
    validate: [v.minLength(6)]

  email_verified:
    type: Boolean
    default: false

  created:
    type: Date

  updated:
    type: Date
)

schema.pre 'save', (next) ->
  if @isModified('password') or @isNew
    @password = bcrypt.hashSync(@password, bcrypt.genSaltSync(10))

  next()

schema.methods.comparePassword = (password) ->
  bcrypt.compareSync(password, @password)

schema.methods.toJSON = ->
    json = @toObject()
    delete json.__v
    delete json.password

    json

module.exports = mongoose.model('Customer', schema)
