Collection = require('admin/base/collection')
formatters = require('lib/formatters')


module.exports = class CompanyApplicationsCollection extends Collection
  urlPath: '/company-applications'

  fields: ['company_name', 'created', 'status']

  fieldNames:
    company_name: 'Название'
    status: 'Статус'
    created: 'Создано'

  fieldFormats:
    created: formatters.date
    status: formatters.applicationStatus
