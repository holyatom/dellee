Collection = require('admin/base/collection')
formatters = require('lib/formatters')


module.exports = class CustomersCollection extends Collection
  urlPath: '/customers'

  fields: ['email', 'email_verified']
  fieldNames:
    email: 'E-mail'
    email_verified: 'E-mail подвержден'

  fieldFormats:
    email_verified: formatters.boolean
