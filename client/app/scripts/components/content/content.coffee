React = require('react')
Component = require('app/base/component')
Footer = require('../footer/footer')


module.exports = class Content extends Component
  render: ->
    <div className="layout c-content">
      <div className="l-wrapper">
        <div className="c-c-top">
          <div className="container">
            <header className="c-c-header">
              <div className="c-c-h-brand">
                <a href="/"><h1 className="ui-logo">Dellee<span className="ui-l-beta_label"></span></h1></a>
              </div>
              <nav className="c-c-h-nav-right">
                <a className="ui-btn" href="/#early-access">Ранний доступ</a>
              </nav>
              <nav className="c-c-h-nav">
                <a href="/">Главная</a>
                <a href="/about">О проекте</a>
                <a href="/contacts">Контакты</a>
                <a href="/terms">Правила</a>
              </nav>
            </header>
          </div>
        </div>
        <div className={"c-c-body #{@props.className}"}>{@props.children}</div>
      </div>
      <Footer />
    </div>
