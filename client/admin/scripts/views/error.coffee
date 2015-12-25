React = require('react')
Component = require('../base/component')
Footer = require('./components/footer')


module.exports = class ErrorView extends Component
  title: -> 'Error'

  render: ->
    <div className="p-error layout">
      <div className="l-top"></div>
      <div>
        <div className="container text-center">
          <h1>Error</h1>
        </div>
      </div>
      <div className="l-bottom"></div>
      <Footer />
    </div>
