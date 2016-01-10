React = require('react')
Component = require('admin/base/component')


module.exports = class Footer extends Component
  render: ->
    <div>
      <div className="container">
        <footer className="c-footer">
          © {new Date().getFullYear()} Delle beta • Админ панель.
        </footer>
      </div>
    </div>
