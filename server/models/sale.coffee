mongoose = require('mongoose')
v = require('lib/validators')
Schema = require('../base/schema')
setters = require('lib/setters')


schema = Schema(
  title:
    type: String
    required: v.required()
    validate: [v.minLength(2)]

  description:
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
)

module.exports = mongoose.model('Sale', schema)
