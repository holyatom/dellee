mongoose = require('mongoose')
v = require('lib/validators')
bcrypt = require('bcryptjs')
Schema = require('../base/schema')


schema = Schema(
  username:
    type: String
    unique: true
    required: v.required()
    validate: [v.maxLength(20), v.minLength(3), v.badUsername(), v.alphanumeric()]

  password:
    type: String
    required: v.required()
    validate: [v.maxLength(20), v.minLength(6), v.alphanumeric()]

  role:
    type: String
    required: v.required()
    enum: v.enum(['admin', 'moderator', 'shop'])

  created:
    type: Date
    required: v.required()
)

schema.pre 'save', (next) ->
  return next() if not @isModified('password') and not @isNew

  @password = bcrypt.hashSync(@password, bcrypt.genSaltSync(10))
  next()

schema.methods.comparePassword = (password) ->
  bcrypt.compareSync(password, @password)

schema.methods.toJSON = ->
    json = @toObject()
    delete json.__v
    delete json.password

    json

module.exports = mongoose.model('User', schema)
