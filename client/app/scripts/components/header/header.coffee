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

  componentDidMount: ->
    @$doc = $(document)
    @$doc.on('click', @handleMisclick)

  componentWillUnmount: ->
    @$doc.off('click', @handleMisclick)

  render: ->
    <div className="c-header">
      <div className="container">
        <div className="c-h-main">
          <span className="c-h-menu_icon" onClick={@toggleMenu}>
            <Hamburger active={@state.show} />
          </span>
          <a className="c-h-brand" href="/">
            <h1 className="ui-logo"><span className="ui-l-beta_label"></span>Dellee</h1>
          </a>
        </div>
        <div className={@cx('c-h-navigation', show: @state.show)}>
          <nav>
            <a href="/">Главная</a>
            <a href="/about">О проекте</a>
            <a href="/contacts">Контакты</a>
          </nav>
        </div>
        <div className="c-h-actions">
          <span className="ui-btn ui-btn_primary" onClick={@navifateToEarlyAccess}>ранний доступ</span>
        </div>
      </div>
    </div>
