mongoose = require('mongoose')
v = require('lib/validators')
Schema = require('../base/schema')


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
    set: (val) -> if val._id? then val._id else val

  start_date:
    type: Date
    required: v.required()
    set: (val) -> new Date(val)

  end_date:
    type: Date
    required: v.required()
    set: (val) -> new Date(val)
)

module.exports = mongoose.model('Sale', schema)
