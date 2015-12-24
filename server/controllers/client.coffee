_ = require('lodash')
Controller = require('../base/controller')
AppRouter = require('app/router')
AdminRouter = require('admin/router')
router = require('express').Router()


AppRouter::run = AdminRouter::run = (app) ->
  @middleware?()
  @router?()

AppRouter::route = AdminRouter::route = (url) ->
  return if url.indexOf('*') >= 0

  if _.startsWith(url, '/admin')
    router.get url, (req, res, next) ->
      res.render('layout_admin', layout: false)
  else
    router.get url, (req, res, next) ->
      res.render('layout_app', layout: false)

module.exports =
  use: (app) ->
    new AppRouter().run()
    new AdminRouter().run()
    app.use(router)
