React = require('react')
Component = require('app/base/component')
{ Footer } = require('app/components')


module.exports = class NotFoundView extends Component
  title: -> 'Not Found'

  render: ->
    <div className="layout">
      <div className="l-top"></div>
      <div>
        <div className="container">
          <h1>Not Found</h1>
        </div>
      </div>
      <div className="l-bottom"></div>
      <Footer />
    </div>
