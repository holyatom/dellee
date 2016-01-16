React = require('react')
Component = require('admin/base/component')
Footer = require('../footer/footer')
Header = require('../header/header')


module.exports = class Layout extends Component
  render: ->
    <div className="c-layout layout">
      <Header />
      { if @props.centered then <div className="l-top" /> else false }
      <div className="l-wrapper">
        <div className="container">
          <div className={@props.className}>{@props.children}</div>
        </div>
      </div>
      { if @props.centered then <div className="l-bottom" /> else false }
      <Footer />
    </div>
