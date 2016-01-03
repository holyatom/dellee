React = require('react')
ReactDOMServer = require('react-dom/server')
_ = require('lodash')
Controller = require('../base/controller')
AppRouter = require('app/router')
AdminRouter = require('admin/router')
router = require('express').Router()


SERVER_RENDER =
  '/': require('app/sections/home/home_view')

AppRouter::run = AdminRouter::run = (app) ->
  @router?()

AppRouter::route = AdminRouter::route = (url) ->
  return if url.indexOf('*') >= 0

  html = ''
  layoutTemplate = if _.startsWith(url, '/admin') then 'layout_admin' else 'layout_app'

  if ViewClass = SERVER_RENDER[url]
    View = React.createFactory(ViewClass)
    html = ReactDOMServer.renderToString(View())
    title = ViewClass::title()

  router.get url, (req, res, next) ->
    res.render(layoutTemplate, layout: false, body: html)

module.exports =
  use: (app) ->
    new AppRouter().run()
    new AdminRouter().run()
    app.use(router)
