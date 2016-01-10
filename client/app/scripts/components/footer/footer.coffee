React = require('react')
Component = require('app/base/component')


module.exports = class Footer extends Component
  render: ->
    <div>
      <div className="container">
        <footer className="c-footer">
          <nav className="c-f-links">
            <a href="/contacts">контакты</a>
            <a href="/about">о проекте</a>
            <a href="/terms">правила</a>
          </nav>
          <div className="c-f-copyright">© {(new Date()).getFullYear()} Delle beta.</div>
        </footer>
      </div>
    </div>
