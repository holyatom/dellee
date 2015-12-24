React = require('react')
Component = require('../base/component')
SubscribeForm = require('./components/subscribe_form')
Footer = require('./components/footer')


module.exports = class HomeView extends Component
  title: -> 'Dellee'

  render: ->
    <div className="p-home layout">
      <div className="l-wrapper">
        <div className="container">
          <h1>Dellee</h1>
          <h2>Подписка</h2>
          <SubscribeForm />
        </div>
      </div>
      <Footer />
    </div>
