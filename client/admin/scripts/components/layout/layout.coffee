React = require('react')
Component = require('admin/base/component')
Footer = require('../footer/footer')
Header = require('../header/header')


module.exports = class Layout extends Component
  render: ->
    <div className="c-layout layout">
      <Header />
      <div className="l-wrapper">
        <div className="container">
          <div className={@props.className}>{@props.children}</div>
        </div>
      </div>
      <Footer />
    </div>
