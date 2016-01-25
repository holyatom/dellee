React = require('react')
{ ModelForm, Layout, FormStatus } = require('admin/components')


module.exports = class UserView extends ModelForm
  title: -> if @state.model._id then 'Редактирование пользователя' else 'Создание пользователя'

  render: ->
    { companies } = @props.data

    <Layout>
      <ul className="breadcrumb">
        <li><a href="/admin">Главная</a></li>
        <li><a href={@props.data.controllerRoot}>Пользователи</a></li>
        <li className="active">{if @state.model._id then _.trunc(@state.model._id, 10) else 'Создание'}</li>
      </ul>
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
      <form ref="form" className="c-model_form form-horizontal" onSubmit={@handleSubmit}>
        <div className="form-group">
          <label htmlFor="inputUsername" className="col-md-3 control-label">Логин</label>
          <div className="col-md-9">
            <input name="username" valueLink={@stateLink('model.username')} type="text" className="form-control" id="inputUsername" placeholder="логин" />
            <div className="help-block with-errors"></div>
          </div>
        </div>

        {
          unless @state.model._id
            <div className="form-group">
              <label htmlFor="inputPassword" className="col-md-3 control-label">Пароль</label>
              <div className="col-md-9">
                <input name="password" valueLink={@stateLink('model.password')} type="password" className="form-control" id="inputPassword" placeholder="пароль" />
                <div className="help-block with-errors"></div>
              </div>
            </div>
        }

        <div className="form-group">
          <label htmlFor="inputRole" className="col-md-3 control-label">Роль</label>
          <div className="col-md-9">
            <select name="role" valueLink={@stateLink('model.role')} className="form-control" id="inputRole">
              <option value="">Выберите роль</option>
              <option value="admin">Админ</option>
              <option value="moderator">Модератор</option>
              <option value="company_user">Пользователь компании</option>
            </select>
            <div className="help-block with-errors"></div>
          </div>
        </div>

        {
          if @state.model.role is 'company_user'
            <div className="form-group">
              <label htmlFor="inputCompany" className="col-md-3 control-label">Компания</label>
              <div className="col-md-9">
                <select name="company" valueLink={@stateLink('model.company._id')} className="form-control" id="inputCompany">
                  <option value="">Выберите компанию</option>
                  {companies.collection.map((company, index) ->
                    <option key={index} value={company._id}>{company.name}</option>
                  )}
                </select>
                <div className="help-block with-errors"></div>
              </div>
            </div>
        }

        <FormStatus {...@state} />

        <div className="text-right">
          <button className="btn btn-success" type="submit" disabled={@state.isLocked}>Сохранить</button>
        </div>
      </form>
    </Layout>
