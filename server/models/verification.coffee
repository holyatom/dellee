mongoose = require('mongoose')
v = require('lib/validators')
Schema = require('../base/schema')


schema = Schema(
  customer:
    type: mongoose.Schema.Types.ObjectId
    ref: 'Customer'
    unique: true
    required: v.required()

  type:
    type: String
    required: v.required()
    enum: v.enum(['email'])

  created:
    type: Date
    required: v.required()
)

module.exports = mongoose.model('Verification', schema)
