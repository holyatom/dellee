Collection = require('admin/base/collection')
formatters = require('lib/formatters')


module.exports = class ShopRegistersCollection extends Collection
  urlPath: '/shop-registers'

  fields: ['name', 'created']

  fieldNames:
    name: 'Название'
    created: 'Создано'

  fieldFormats:
    created: formatters.date
