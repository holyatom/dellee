React = require('react')
Component = require('app/base/component')
{ Footer } = require('app/components')


module.exports = class NotFoundView extends Component
  title: -> 'Not Found'

  render: ->
    <div className="layout p-not_found">
      <div className="l-top"></div>
      <div>
        <div className="container">
          <figure className="p-nf-illustration"></figure>
          <div className="p-nf-message">
            Страница не существует в данный отрезок времени. Но ты можешь всегда начать <a href="/">с начала</a>
          </div>
        </div>
      </div>
      <div className="l-bottom"></div>
      <Footer />
    </div>
