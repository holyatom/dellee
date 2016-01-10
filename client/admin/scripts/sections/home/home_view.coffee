React = require('react')
Form = require('admin/base/form')
profile = require('admin/modules/profile')
{ Footer, FormStatus } = require('admin/components')


module.exports = class HomeView extends Form
  title: -> 'Dellee • Вход в Админ панель'

  initState: ->
    model: {}

  handleSubmit: (event) =>
    event.preventDefault()

    @lockForm()

    dfd = profile.login(@state.model)
    dfd.fail (xhr) =>
      @showErrorMessage(xhr)
      @unlockForm()

  render: ->
    <div className="p-home layout">
      <div className="l-top"></div>
      <div>
        <div className="container">
          <h1>Dellee <small>beta</small></h1>
          <h4 className="text-muted">Админ панель</h4>
          <form onSubmit={@handleSubmit}>
            <div className="form-group">
              <input valueLink={@stateLink('model.username')} type="text" className="form-control" placeholder="логин" />
            </div>
            <div className="form-group">
              <input valueLink={@stateLink('model.password')} type="password" className="form-control" placeholder="пароль" />
            </div>
            <FormStatus {...@state} />
            <button className="btn btn-primary btn-block" disabled={@state.isLocked}>Вход</button>
          </form>
        </div>
      </div>
      <div className="l-bottom"></div>
      <Footer />
    </div>
