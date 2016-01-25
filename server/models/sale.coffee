mongoose = require('mongoose')
v = require('lib/validators')
Schema = require('../base/schema')
setters = require('lib/setters')


schema = Schema(
  title:
    type: String
    required: v.required()
    validate: [v.minLength(2)]
    trim: true

  message:
    type: String
    required: v.required()
    validate: [v.minLength(10)]
    text: true

  company:
    type: mongoose.Schema.Types.ObjectId
    ref: 'Company'
    required: v.required()
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

  created:
    type: Date

  updated:
    type: Date
)

module.exports = mongoose.model('Sale', schema)
