moment = require('moment')


module.exports =
  date: (val) ->
    moment(val).format('DD MMM YYYY')

  saleStatus: (val) ->
    if val is 'pending'
      "<span class=\"label label-warning\">В очереди</span>"
    else if val is 'rejected'
      "<span class=\"label label-danger\">Отклонен</span>"
    else
      "<span class=\"label label-success\">Обработан</span>"

  boolean: (val) ->
    if val
      "<span class=\"text-success\">Да</span>"
    else
      "<span class=\"text-danger\">Нет</span>"
