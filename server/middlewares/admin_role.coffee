error = require('./error')


module.exports = (roles) ->
  (req, res, next) ->
    return error(res, 'auth_required', 401) unless req.adminAuthorized

    if req.adminUser.role in roles or req.adminUser.role is 'admin'
      return next()

    error(res, 'role_required', 401)
