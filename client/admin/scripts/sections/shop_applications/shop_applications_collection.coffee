Collection = require('admin/base/collection')
formatters = require('lib/formatters')


module.exports = class ShopApplicationsCollection extends Collection
  urlPath: '/shop-applications'

  fields: ['shop_name', 'created', 'status']

  fieldNames:
    shop_name: 'Название'
    status: 'Статус'
    created: 'Создано'

  fieldFormats:
    created: formatters.date
    status: formatters.applicationStatus
