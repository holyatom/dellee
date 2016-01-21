React = require('react')
Component = require('app/base/component')


module.exports = class Footer extends Component
  render: ->
    <div>
      <div className="container">
        <footer className="c-footer">
          <nav className="c-f-links">
            <a href="/about">о проекте</a>
            <a href="/terms">правила</a>
            <a href="/privacy">конфидециальность</a>
            <a href="/contacts">контакты</a>
          </nav>
          <div className="c-f-copyright">© {(new Date()).getFullYear()} Dellee beta.</div>
        </footer>
      </div>
    </div>
