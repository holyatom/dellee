Collection = require('admin/base/collection')


module.exports = class CompaniesCollection extends Collection
  urlPath: '/companies'

  fields: ['name', 'slug']
  fieldNames:
    name: 'Название'
