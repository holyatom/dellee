_ = require('underscore')


module.exports = (url, params) ->
    query = ''

    for key, value of params when key isnt 'filter'
      query += "&#{key}=#{value}"

    for fieldKey, fieldValue of params.filter
      if _.isObject(fieldValue) and not _.isArray(fieldValue)
        query += "&_#{fieldKey}=#{fieldValue.value}" if fieldValue.value?
        for filterType, filterValue of fieldValue when filterType isnt 'value'
          query += "&_#{fieldKey}__#{filterType}=#{filterValue}"
      else
        query += "&_#{fieldKey}=#{fieldValue}"

    return url unless query

    url += if '?' in url then '&' else '?'
    url + query.substr(1)
