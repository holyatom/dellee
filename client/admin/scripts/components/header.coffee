React = require('react')
Component = require('../base/component')
profile = require('../modules/profile')


module.exports = class Header extends Component
  logout: ->
    profile.logout()

  render: ->
    <nav className="c-header navbar navbar-default navbar-fixed-top">
      <div className="container-fluid">

        <div className="navbar-header">
          <button type="button" className="navbar-toggle collapsed" data-toggle="collapse" data-target="#navigation">
            <span className="sr-only"></span>
            <span className="icon-bar"></span>
            <span className="icon-bar"></span>
            <span className="icon-bar"></span>
          </button>
          <a className="navbar-brand" href="/admin/dashboard">
            Dellee <small className="text-muted">beta</small>
          </a>
        </div>

        <div className="collapse navbar-collapse" id="navigation">
          {
            if profile.is('shopadmin', strict: true)
              <ul className="nav navbar-nav">
                <li className="dropdown">
                  <a href="javascript:void(0);" className="dropdown-toggle" data-toggle="dropdown">Магазин ({ profile.get('shop').name }) <span className="caret"></span></a>
                  <ul className="dropdown-menu">
                    <li><a href="/admin/shop-sales">Акции</a></li>
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
                    <li><a href="/admin/shops">Магазины</a></li>
                    <li><a href="/admin/customers">Клиенты</a></li>
                  </ul>
                </li>
              </ul>
          }

          <ul className="nav navbar-nav navbar-right">
            <li className="dropdown">
              <a href="javascript:void(0);" className="dropdown-toggle" data-toggle="dropdown">{profile.get('username')} <span className="caret"></span></a>
              <ul className="dropdown-menu">
                <li><a href="javascript:void(0);" onClick={@logout}>Выйти</a></li>
              </ul>
            </li>
          </ul>
        </div>
      </div>
    </nav>
