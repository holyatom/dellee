_ = require('lodash')
React = require('react')
ReactDOMServer = require('react-dom/server')


SERVER_RENDER =
  '/': require('app/sections/home/home_view')
  '/about': require('app/sections/content/about_view')
  '/terms': require('app/sections/content/terms_view')
  '/privacy': require('app/sections/content/privacy_view')
  '/contacts': require('app/sections/content/contacts_view')

module.exports = (req, res) ->
  { url } = req
  html = ''
  template = if _.startsWith(url, '/admin') then 'layout_admin' else 'layout_app'

  if ViewClass = SERVER_RENDER[url]
    View = React.createFactory(ViewClass)
    html = ReactDOMServer.renderToString(View())
    title = ViewClass::title()

  res.render(template, layout: false, body: html, title: title)
