mongoose = require('mongoose')
v = require('lib/validators')
setters = require('lib/setters')
bcrypt = require('bcryptjs')
Schema = require('../base/schema')


schema = Schema(
  username:
    type: String
    unique: true
    required: v.required()
    validate: [v.maxLength(20), v.minLength(3), v.username(), v.alphanumeric()]
    trim: true

  password:
    type: String
    required: v.required()
    validate: [v.minLength(6)]
    trim: true

  role:
    type: String
    required: v.required()
    enum: v.enum(['admin', 'moderator', 'company_user'])

  company:
    type: mongoose.Schema.Types.ObjectId
    ref: 'Company'
    set: setters.objectId

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

module.exports = mongoose.model('User', schema)
