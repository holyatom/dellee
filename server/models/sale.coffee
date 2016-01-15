mongoose = require('mongoose')
v = require('lib/validators')
Schema = require('../base/schema')
setters = require('lib/setters')


schema = Schema(
  title:
    type: String
    required: v.required()
    validate: [v.minLength(2)]

  message:
    type: String
    required: v.required()
    validate: [v.minLength(10)]

  shop:
    type: mongoose.Schema.Types.ObjectId
    ref: 'Shop'
    set: setters.objectId

  start_date:
    type: Date
    required: v.required()
    set: setters.date

  end_date:
    type: Date
    required: v.required()
    set: setters.date

  status:
    type: String
    required: v.required()
    enum: v.enum(['new', 'pending', 'rejected', 'processed'])

  status_message:
    type: String
    text: true
)

module.exports = mongoose.model('Sale', schema)
