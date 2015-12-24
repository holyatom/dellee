error = require('./error')

module.exports = (res) ->
  error(res, 'not_found', 404)
