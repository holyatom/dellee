error = require('./error')

module.exports = (res) ->
  error(res, 'unexpected_error', 500)
