Collection = require('admin/base/collection')


module.exports = class ShopsCollection extends Collection
  urlPath: '/shops'

  fields: ['name', 'slug']
  fieldNames:
    name: 'Название'
