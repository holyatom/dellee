Collection = require('admin/base/collection')
formatters = require('lib/formatters')


module.exports = class CompanyApplicationsCollection extends Collection
  urlPath: '/company-applications'

  fields: ['company_name', 'is_replied', 'created', 'status']

  fieldNames:
    company_name: 'Название'
    is_replied: 'Ответили'
    status: 'Статус'
    created: 'Создано'

  fieldFormats:
    created: formatters.timeAgo
    status: formatters.applicationStatus
    is_replied: formatters.boolean
