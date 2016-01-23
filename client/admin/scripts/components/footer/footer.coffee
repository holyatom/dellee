config = require('config')
React = require('react')
Component = require('admin/base/component')


module.exports = class Footer extends Component
  render: ->
    <div>
      <div className="container">
        <footer className="c-footer">
          <ul className="c-f-links">
            <li><a target="_self" href="/">Dellee</a></li>
            <li><a target="_self" href="/about">О проекте</a></li>
            <li><a target="_self" href="/contacts">Контакты</a></li>
            <li><a target="_self" href="/terms">Правила</a></li>
          </ul>
          <div className="c-f-copyright">
            © {new Date().getFullYear()} Dellee beta.
          </div>
          <div className="c-f-info">
            <div>Админ панель</div>
            <div>Свяжитесь с нами по почте <a href={"mailto:#{config.contacts.email}"}>{config.contacts.email}</a></div>
          </div>
        </footer>
      </div>
    </div>
