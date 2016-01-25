moment = require('moment')


module.exports =
  date: (val) ->
    moment(val).format('DD MMM YYYY')

  timeAgo: (val) ->
    moment(val).fromNow()

  saleStatus: (val) ->
    if val is 'pending'
      "<span class=\"label label-warning\">В очереди</span>"
    else if val is 'rejected'
      "<span class=\"label label-danger\">Отклонена</span>"
    else if val is 'new'
      "<span class=\"label label-default\">Новая</span>"
    else
      "<span class=\"label label-success\">Обработана</span>"

  applicationStatus: (val) ->
    if val is 'new'
      "<span class=\"label label-default\">Новая</span>"
    else
      "<span class=\"label label-success\">Обработана</span>"

  boolean: (val) ->
    if val
      "<span class=\"text-success\">Да</span>"
    else
      "<span class=\"text-danger\">Нет</span>"
