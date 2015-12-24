React = require('react')
Form = require('../base/form')
Footer = require('./components/footer')


module.exports = class HomeView extends Form
  title: -> 'Dellee • Admin panel'

  render: ->
    <div className="p-home layout">
      <div className="l-top"></div>
      <div>
        <div className="container">
          <h1>Dellee</h1>
          <h4 className="text-muted">Админ панель</h4>
          <form>
            <div className="form-group">
              <input type="text" className="form-control" placeholder="логин" />
            </div>
            <div className="form-group">
              <input type="password" className="form-control" placeholder="пароль" />
            </div>
            <button className="btn btn-primary btn-block">Вход</button>
          </form>
        </div>
      </div>
      <div className="l-bottom"></div>
      <Footer />
    </div>
