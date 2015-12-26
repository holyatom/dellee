Collection = require('admin/base/collection')


module.exports = class CustomersCollection extends Collection
  urlPath: '/customers'

  fields: ['email']
