React = require('react')
Component = require('../../base/component')


module.exports = class Footer extends Component
  render: ->
    <div>
      <div className="container">
        <footer className="c-footer">
          © 2015 Delle • Админ панель.
        </footer>
      </div>
    </div>
