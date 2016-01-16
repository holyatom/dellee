React = require('react')
{ Layout, FormStatus, ModelForm } = require('admin/components')


module.exports = class HomeView extends ModelForm
  title: -> 'Dellee • Вход в Админ панель'

  render: ->
    <Layout centered className="p-home">
      <div className="text-center">
        <h1 className="ui-logo">Dellee<span className="ui-l-beta_label"></span></h1>
        <h4>Вход в панель управления</h4>
      </div>
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
    </Layout>
