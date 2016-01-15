mongoose = require('mongoose')
v = require('lib/validators')
Schema = require('../base/schema')


schema = Schema(
  name:
    type: String
    required: v.required()
    validate: [v.minLength(2)]

  slug:
    type: String
    unique: true

  logo_url:
    type: String

  created:
    type: Date

  updated:
    type: Date
)

module.exports = mongoose.model('Shop', schema)
