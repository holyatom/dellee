$ = require('jquery')
React = require('react')
Component = require('app/base/component')


module.exports = class Header extends Component
  initState: ->
    show: false

  toggleMenu: (event) =>
    event.stopPropagation()
    event.nativeEvent.stopImmediatePropagation()

    @setState(show: !@state.show)

  handleMisclick: =>
    @setState(show: false)

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
            <i className="icon-menu"></i>
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
          <a className="ui-btn ui-btn_default" href="/#early-access">ранний доступ</a>
        </div>
      </div>
    </div>
