mongoose = require('mongoose')
v = require('lib/validators')
Schema = require('../base/schema')


schema = Schema(
  name:
    type: String
    required: v.required()
    validate: [v.minLength(2)]

  person:
    name:
      type: String
      required: v.required()
      validate: [v.minLength(2)]

    surname:
      type: String

  contacts:
    email:
      type: String
      required: v.required()
      validate: [v.email()]

    phonenumber:
      type: String

  additional:
    type: String
    text: true

  created:
    type: Date

  updated:
    type: Date
)

module.exports = mongoose.model('ShopRegister', schema)
