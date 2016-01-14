React = require('react')
Component = require('app/base/component')
Footer = require('../footer/footer')
Header = require('../header/header')


module.exports = class Content extends Component
  render: ->
    <div className="layout c-content">
      <Header />
      <div className="l-wrapper c-c-body">
        <div className={@props.className}>{@props.children}</div>
      </div>
      <Footer />
    </div>
