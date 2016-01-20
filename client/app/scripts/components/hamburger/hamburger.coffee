React = require('react')
Component = require('app/base/component')


module.exports = class Hamburger extends Component
  render: ->
    <span className={@cx('c-hamburger', active: @props.active)}>
      <span className="c-h-line top"></span>
      <span className="c-h-line middle"></span>
      <span className="c-h-line bottom"></span>
    </span>
