$ = require('jquery')
vent = require('admin/modules/vent')
React = require('react')
Component = require('admin/base/component')
profile = require('admin/modules/profile')


module.exports = class Header extends Component
  beforeRoute: =>
    @$nav.removeClass('in')

  afterRoute: (ctx) =>
    @$nav.find('li.active').removeClass('active')
    $li = @$nav.find("a[href=\"#{ctx.pathname}\"]").parent()
    $li.addClass('active') if $li.is('li')

  logout: ->
    profile.logout()

  componentDidMount: ->
    super
    @$nav = $(@refs.navigation)
    vent.on('route:before', @beforeRoute)
    vent.on('route:after', @afterRoute)

  componentWillUnmount: ->
    vent.off('route:before', @beforeRoute)
    vent.off('route:after', @afterRoute)

  render: ->
    homeUrl = if profile.authorized() then '/admin/dashboard' else '/admin'

    <nav className="c-header navbar navbar-default navbar-fixed-top">
      <div className="container-fluid">

        <div className="navbar-header">
          <button type="button" className="navbar-toggle collapsed" data-toggle="collapse" data-target="#navigation">
            <span className="sr-only"></span>
            <span className="icon-bar"></span>
            <span className="icon-bar"></span>
            <span className="icon-bar"></span>
          </button>
          <a className="navbar-brand" href={homeUrl}>
            <h1 className="ui-logo">Dellee<span className="ui-l-beta_label"></span></h1>
          </a>
        </div>

        <div ref="navigation" className="collapse navbar-collapse" id="navigation">
          {
            unless profile.authorized()
              <ul className="nav navbar-nav">
                <li>
                  <a href="/admin">Вход</a>
                </li>
                <li>
                  <a href="/admin/register-company">Регистрация компании</a>
                </li>
              </ul>
          }

          {
            if profile.is('company_user', strict: true)
              <ul className="nav navbar-nav">
                <li className="dropdown">
                  <a href="javascript:void(0);" className="dropdown-toggle" data-toggle="dropdown">{ profile.get('company').name } <span className="caret"></span></a>
                  <ul className="dropdown-menu">
                    <li><a href="/admin/company-sales">Акции</a></li>
                    <li><a href="/admin/companies/#{profile.get('company')._id}">Редактирование</a></li>
                  </ul>
                </li>
              </ul>
          }

          {
            if profile.is('moderator')
              <ul className="nav navbar-nav">
                <li className="dropdown">
                  <a href="javascript:void(0);" className="dropdown-toggle" data-toggle="dropdown">Модерация <span className="caret"></span></a>
                  <ul className="dropdown-menu">
                    <li><a href="/admin/sales">Акции</a></li>
                    <li><a href="/admin/company-applications">Заявки компаний</a></li>
                  </ul>
                </li>
              </ul>
          }

          {
            if profile.is('admin')
              <ul className="nav navbar-nav">
                <li className="dropdown">
                  <a href="javascript:void(0);" className="dropdown-toggle" data-toggle="dropdown">Управление <span className="caret"></span></a>
                  <ul className="dropdown-menu">
                    <li><a href="/admin/users">Пользователи</a></li>
                    <li><a href="/admin/companies">Компании</a></li>
                    <li><a href="/admin/customers">Клиенты</a></li>
                    <li><a href="/admin/subscribers">Подписчики</a></li>
                  </ul>
                </li>
              </ul>
          }

          {
            if profile.authorized()
              <ul className="nav navbar-nav navbar-right">
                <li className="dropdown">
                  <a href="javascript:void(0);" className="dropdown-toggle" data-toggle="dropdown">{profile.get('username')} <span className="caret"></span></a>
                  <ul className="dropdown-menu">
                    <li><a href="javascript:void(0);" onClick={@logout}>Выйти</a></li>
                  </ul>
                </li>
              </ul>
          }
        </div>
      </div>
    </nav>
