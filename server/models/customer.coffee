mongoose = require('mongoose')
v = require('lib/validators')
Schema = require('../base/schema')


schema = Schema(
  email:
    type: String
    unique: true
    required: v.required()
    validate: [v.email()]
)

module.exports = mongoose.model('Customer', schema)
