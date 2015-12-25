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
            <span className="sr-only">Toggle navigation</span>
            <span className="icon-bar"></span>
            <span className="icon-bar"></span>
            <span className="icon-bar"></span>
          </button>
          <a className="navbar-brand" href="/admin/dashboard">Dellee</a>
        </div>

        <div className="collapse navbar-collapse" id="navigation">
          {
            if profile.is('admin')
              <ul className="nav navbar-nav">
                <li className="dropdown">
                  <a href="javascript:void(0);" className="dropdown-toggle" data-toggle="dropdown">Управление <span className="caret"></span></a>
                  <ul className="dropdown-menu">
                    <li><a href="/admin/users">Пользователи</a></li>
                    <li><a href="/admin/shops">Магазины</a></li>
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
