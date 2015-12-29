config = require('config')
jwt = require('jsonwebtoken')
error = require('./error')
User = require('../models/user')


module.exports = (req, res, next) ->
  token = req.headers['x-access-admin-token']
  return next() unless token

  jwt.verify token, config.admin.jwt.secret, (err, decoded) ->
    return error(res, 'bad_token', 401) if err or not decoded

    User.findOne _id: decoded.sub, (err, doc) =>
      return next() if err or not doc

      req.decodedAdminJwt = decoded
      req.adminAuthorized = true
      req.adminUser = doc
      next()
