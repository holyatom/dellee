React = require('react')
ReactDOM = require('react-dom')
ErrorView = require('../views/error')

appNode = document.getElementById('app-node')
titleNode =  document.getElementsByTagName('title')[0]


module.exports = class Controller
  constructor: ->
    @xhrs = {}

  destroy: ->
    for key, xhr of @xhrs
      xhr.abort() if xhr.status isnt 4

  renderView: (View, callback) ->
    view = ReactDOM.render(View, appNode, callback)
    titleNode.innerText = view.title()

  renderErrorView: (xhr, callback) ->
    return if xhr.readyState is 0
    @renderView(<ErrorView />, callback)
