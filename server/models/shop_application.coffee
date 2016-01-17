mongoose = require('mongoose')
v = require('lib/validators')
Schema = require('../base/schema')


schema = Schema(
  shop_name:
    type: String
    required: v.required()
    validate: [v.minLength(2)]
    trim: true

  person:
    name:
      type: String
      required: v.required()
      validate: [v.minLength(2)]
      trim: true

    surname:
      type: String
      trim: true

  contacts:
    email:
      type: String
      required: v.required()
      validate: [v.email()]
      trim: true

    phonenumber:
      type: String
      trim: true

  additional:
    type: String
    text: true

  status:
    type: String
    required: v.required()
    enum: v.enum(['new', 'processed'])

  created:
    type: Date

  updated:
    type: Date
)

module.exports = mongoose.model('ShopApplication', schema)
