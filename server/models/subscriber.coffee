mongoose = require('mongoose')
v = require('lib/validators')
Schema = require('../base/schema')


schema = Schema(
  email:
    type: String
    required: v.required()
    unique: true
    validate: [v.email()]
    trim: true

  created:
    type: Date
)

module.exports = mongoose.model('Subscriber', schema)
