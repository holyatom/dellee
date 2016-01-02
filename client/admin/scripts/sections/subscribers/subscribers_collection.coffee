Collection = require('admin/base/collection')


module.exports = class SubscribersCollection extends Collection
  urlPath: '/subscribers'

  fields: ['email']
