React = require('react')
Component = require('app/base/component')
{ Footer } = require('app/components')
profile = require('app/modules/profile')
CompanyCard = require('./company_card')


module.exports = class SubscriptionsView extends Component
  title: -> 'Dellee • Подписки'

  render: ->
    <div className="layout">
      <div className="l-wrapper">
        <div className="container">
          <h1>Dellee <button onClick={-> profile.logout()}>Выход</button></h1>
          <h2>Подписки</h2>
          <ul>
            {@props.data.companies.collection.map((company, index) =>
              <li key={index}>
                <CompanyCard company={company} />
              </li>
            )}
          </ul>
        </div>
      </div>
      <Footer />
    </div>
