_ = require('lodash')
React = require('react')
classnames = require('classnames')


module.exports = class Component extends React.Component
  constructor: (props) ->
    super()
    @state = @initState(props)

  componentDidMount: -> # noop

  refreshState: =>
    @setState(@initState())

  initState: -> {}

  trigger: (eventName, args...) ->
    eventName = "on#{_.capitalize(eventName)}"
    @props[eventName]?(args...)

  cx: classnames

