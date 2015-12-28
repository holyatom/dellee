React = require('react')
Component = require('app/base/component')
Footer = require('app/components/footer')
profile = require('app/modules/profile')


module.exports = class HomeView extends Component
  title: -> 'Dellee • Подписки'

  render: ->
    <div className="layout">
      <div className="l-wrapper">
        <div className="container">
          <h1>Dellee</h1>
          <h2>Подписки</h2>
          <button onClick={-> profile.logout()}>Выход</button>
        </div>
      </div>
      <Footer />
    </div>
