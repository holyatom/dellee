mongoose = require('mongoose')
v = require('lib/validators')
Schema = require('../base/schema')
setters = require('lib/setters')


schema = Schema(
  customer:
    type: mongoose.Schema.Types.ObjectId
    ref: 'Customer'
    required: v.required()
    set: setters.objectId

  company:
    type: mongoose.Schema.Types.ObjectId
    ref: 'Company'
    set: setters.objectId
    required: v.required()

  created:
    type: Date
)

module.exports = mongoose.model('Subscription', schema)
