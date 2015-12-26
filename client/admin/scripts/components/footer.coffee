React = require('react')
Component = require('../base/component')


module.exports = class Footer extends Component
  render: ->
    <div>
      <div className="container">
        <footer className="c-footer">
          © {new Date().getFullYear()} Delle <small className="text-muted">beta</small> • Админ панель.
        </footer>
      </div>
    </div>
