React = require('react')
Form = require('app/base/form')
{ Footer } = require('app/components')


module.exports = class HomeView extends Form
  title: -> 'Dellee • Первый мессенджер акций'

  render: ->
    <div className="layout p-home">
      <div className="l-wrapper">
        <div className="container">
          <i className="icon-check_form"></i>
        </div>
      </div>
    </div>
