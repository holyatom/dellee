error = require('./error')


module.exports = (req, res, next) ->
  return error(res, 'auth_required', 401) unless req.authorized
  next()
