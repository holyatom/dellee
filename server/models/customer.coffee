mongoose = require('mongoose')
v = require('lib/validators')


schema = new mongoose.Schema(
  email:
    type: String
    unique: true
    required: v.required()
    validate: [v.email()]
)

module.exports = mongoose.model('Customer', schema)
