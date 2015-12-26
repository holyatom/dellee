React = require('react')
ReactDOM = require('react-dom')
ErrorView = require('../sections/error/error_view')

appNode = document.getElementById('app-node')
titleNode =  document.getElementsByTagName('title')[0]


module.exports = class Controller
  constructor: ->
    @xhrs = {}

  destroy: (opts = {}) ->
    for key, xhr of @xhrs
      xhr.abort?() if xhr.status isnt 4

    if opts.force
      ReactDOM.unmountComponentAtNode(appNode)

  renderView: (View, callback) ->
    @view = ReactDOM.render(View, appNode, callback)
    titleNode.innerText = @view.title()

  renderErrorView: (xhr, callback) ->
    return if xhr.readyState is 0
    @view = @renderView(<ErrorView />, callback)
