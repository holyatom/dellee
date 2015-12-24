React = require('react')
Component = require('../base/component')
Footer = require('./components/footer')
profile = require('../modules/profile')


module.exports = class DashboardView extends Component
  title: -> 'Dellee • Админ панель'

  logout: ->
    profile.logout()

  render: ->
    <div className="p-dashboard layout">
      <div className="l-wrapper">
        <div className="container">
          <h1>Админ панель</h1>
          <button className="btn btn-danger" onClick={@logout}>выход</button>
        </div>
      </div>
      <Footer />
    </div>
