Collection = require('admin/base/collection')


module.exports = class SalesCollection extends Collection
  urlPath: '/sales'

  fields: ['title', 'start_date', 'end_date', 'status']
  fieldNames:
    title: 'Заголовок'
    start_date: 'Запуск'
    end_date: 'Окончание'
    status: 'Статус'
