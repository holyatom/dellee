React = require('react')
Component = require('app/base/component')


module.exports = class ErrorView extends Component
  title: -> 'Error'

  render: ->
    <div className="layout">
      <div className="l-top"></div>
      <div>
        <div className="container">
          <h1>Error</h1>
        </div>
      </div>
      <div className="l-bottom"></div>
      <Footer />
    </div>
