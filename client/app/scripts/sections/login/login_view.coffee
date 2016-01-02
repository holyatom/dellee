React = require('react')
Form = require('app/base/form')
{ Footer } = require('app/components')


module.exports = class LoginView extends Form
  title: -> 'Dellee • Вход'

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
          <h2>Вход</h2>
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
