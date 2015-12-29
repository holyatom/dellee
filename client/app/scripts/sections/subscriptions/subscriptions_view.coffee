React = require('react')
Component = require('app/base/component')
Footer = require('app/components/footer')
profile = require('app/modules/profile')
ShopCard = require('./shop_card')


module.exports = class SubscriptionsView extends Component
  title: -> 'Dellee • Подписки'

  render: ->
    <div className="layout">
      <div className="l-wrapper">
        <div className="container">
          <h1>Dellee <button onClick={-> profile.logout()}>Выход</button></h1>
          <h2>Подписки</h2>
          <ul>
            {@props.data.shops.collection.map((shop, index) =>
              <li key={index}>
                <ShopCard shop={shop} />
              </li>
            )}
          </ul>
        </div>
      </div>
      <Footer />
    </div>
