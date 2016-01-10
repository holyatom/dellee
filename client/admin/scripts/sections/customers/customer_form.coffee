React = require('react')
{ ModelForm, Layout, FormStatus } = require('admin/components')


module.exports = class CustomerForm extends ModelForm
  title: -> if @state.model._id then 'Редактирование клиента' else 'Создание клиента'

  render: ->
    <Layout>
      <header className="page-header">
        <div className="row">
          <h3 className="col-xs-6 col-md-8">{@title()}</h3>
          {
            if @state.model._id
              <div className="col-xs-6 col-md-4 text-right">
                <button onClick={@handleDelete} className="btn btn-danger">Удалить</button>
              </div>
          }
        </div>
      </header>
      <form className="c-model_form form-horizontal" onSubmit={@handleSubmit}>
        {
          if @state.model._id
            <div className="form-group">
              <label className="col-md-3 control-label">Email</label>
              <div className="col-md-9">
                <p className="form-control-static">{ @state.model.email }</p>
              </div>
            </div>
          else
            <div className="form-group">
              <label htmlFor="inputeEmail" className="col-md-3 control-label">Email</label>
              <div className="col-md-9">
                <input valueLink={@stateLink('model.email')} type="text" className="form-control" id="inputeEmail" placeholder="e-mail" />
              </div>
            </div>
        }
        {
          unless @state.model._id
            <div className="form-group">
              <label htmlFor="inputPassword" className="col-md-3 control-label">Пароль</label>
              <div className="col-md-9">
                <input valueLink={@stateLink('model.password')} type="password" className="form-control" id="inputPassword" placeholder="пароль" />
              </div>
            </div>
        }
        <div className="form-group">
          <label className="col-md-3 control-label">Настройки</label>
          <div className="col-md-9">
            <div className="checkbox">
              <label>
                <input checkedLink={@stateLink('model.email_verified')} type="checkbox" /> E-mail подвержден
              </label>
            </div>
          </div>
        </div>

        <FormStatus {...@state} />

        <div className="text-right">
          <button className="btn btn-success" type="submit" disabled={@state.isLocked}>Сохранить</button>
        </div>
      </form>
    </Layout>
