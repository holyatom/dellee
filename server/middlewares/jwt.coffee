config = require('config')
jwt = require('jsonwebtoken')
error = require('./error')
Customer = require('../models/customer')


module.exports = (req, res, next) ->
  token = req.headers['x-access-token']
  return next() unless token

  jwt.verify token, config.public.jwt.secret, (err, decoded) ->
    return error(res, 'bad_token', 401) if err or not decoded

    Customer.findOne _id: decoded.sub, (err, doc) =>
      return next() if err or not doc

      req.decodedJwt = decoded
      req.authorized = true
      req.user = doc.toJSON()
      next()
