Collection = require('admin/base/collection')
formatters = require('lib/formatters')


module.exports = class SalesCollection extends Collection
  urlPath: '/sales'

  fields: ['title', 'start_date', 'end_date', 'status']

  fieldNames:
    title: 'Заголовок'
    start_date: 'Запуск'
    end_date: 'Окончание'
    status: 'Статус'

  fieldFormats:
    start_date: formatters.date
    end_date: formatters.date
    status: formatters.saleStatus
