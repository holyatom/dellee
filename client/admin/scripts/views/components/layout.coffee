React = require('react')
Component = require('../../base/component')
Footer = require('./footer')
Header = require('./header')


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
