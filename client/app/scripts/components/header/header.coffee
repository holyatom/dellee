$ = require('jquery')
React = require('react')
Component = require('app/base/component')
Hamburger = require('../hamburger/hamburger')
vent = require('app/modules/vent')


module.exports = class Header extends Component
  initState: ->
    show: false

  toggleMenu: (event) =>
    event?.stopPropagation()
    event?.nativeEvent.stopImmediatePropagation()

    show = !@state.show
    if show then vent.trigger('scroll:lock') else vent.trigger('scroll:unlock')
    @setState({ show })

  navifateToEarlyAccess: =>
    if location.pathname is '/'
      vent.trigger('scroll', target: '#early-access')
    else
      vent.trigger('navigate', '/#early-access')

  handleMisclick: =>
    @toggleMenu() if @state.show

  render: ->
    <div className="c-header">
      <div className="container">
        <div className="c-h-main">
          <span className="c-h-menu_icon" onClick={@toggleMenu}>
            <i className="icon-menu" />
          </span>
          <a className="c-h-brand" href="/">
            <h1 className="ui-logo"><span className="ui-l-beta_label"></span>Dellee</h1>
          </a>
        </div>
        <div className={@cx('c-h-navigation', show: @state.show)} onClick={@handleMisclick}>
          <div className="c-h-n-wrapper">
            <nav>
              <a href="/">главная</a>
              <a href="/about">о проекте</a>
              <a href="/contacts">контакты</a>
              <span className="c-h-n-close">закрыть</span>
              <span className="c-h-n-close_icon icon-cross"></span>
            </nav>
          </div>
        </div>
        <div className="c-h-actions">
          <span className="ui-btn ui-btn_primary" onClick={@navifateToEarlyAccess}>ранний доступ</span>
        </div>
      </div>
    </div>
