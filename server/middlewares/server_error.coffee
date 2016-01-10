_ = require('lodash')
error = require('./error')
clientRender = require('./client_render')


module.exports = (req, res) ->
  unless res
    res = req
    req = undefined

  if not req or _.startsWith(req.url, '/api')
    error(res, 'unexpected_error', 500)
  else
    clientRender(req, res)
