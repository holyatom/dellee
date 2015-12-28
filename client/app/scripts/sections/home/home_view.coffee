React = require('react')
Form = require('app/base/form')
Footer = require('app/components/footer')


module.exports = class HomeView extends Form
  title: -> 'Dellee'

  initState: ->
    model: {}

  handleSubmit: (event) =>
    event.preventDefault()
    @trigger('save', @state.model)

  render: ->
    <div className="layout">
      <div className="l-wrapper">
        <div className="container">
          <h1>Dellee</h1>
          <h2>Регистрация</h2>
          <form onSubmit={@handleSubmit}>
            <p>
              <label>Email</label>
              <input type="text" valueLink={@stateLink('model.email')} />
            </p>
            <p>
              <label>Пароль</label>
              <input type="password" valueLink={@stateLink('model.password')} />
            </p>
            <button type="submit">Отправить</button>
          </form>
        </div>
      </div>
      <Footer />
    </div>
