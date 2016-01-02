React = require('react')
Component = require('app/base/component')


module.exports = class Footer extends Component
  render: ->
    <div>
      <div className="container">
        <footer className="c-footer">
          <nav className="c-f-links">
            <a href="">контакты</a>
            <a href="">о проекте</a>
            <a href="">правила</a>
          </nav>
          <div className="c-f-copyright">© {(new Date()).getFullYear()} Delle.</div>
        </footer>
      </div>
    </div>
