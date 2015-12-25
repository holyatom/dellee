React = require('react')
ModelForm = require('admin/base/model_form')
Layout = require('admin/components/layout')


module.exports = class UserView extends ModelForm
  title: -> if @state.model._id then 'Редактирование пользователя' else 'Создание пользователя'

  render: ->
    <Layout>
      <header className="page-header">
        <div className="row">
          <h3 className="col-xs-6 col-md-8">{@title()}</h3>
          {
            if @state.model._id
              <div className="col-xs-6 col-md-4 text-right">
                <button className="btn btn-danger">Удалить</button>
              </div>
          }
        </div>
      </header>
      <form className="c-model_form form-horizontal" onSubmit={@handleSubmit}>
        <div className="form-group">
          <label htmlFor="inputUsername" className="col-md-2 control-label">Логин</label>
          <div className="col-md-10">
            <input valueLink={@stateLink('model.username')} type="text" className="form-control" id="inputUsername" placeholder="логин" />
          </div>
        </div>

        {
          unless @state.model._id
            <div className="form-group">
              <label htmlFor="inputPassword" className="col-md-2 control-label">Пароль</label>
              <div className="col-md-10">
                <input valueLink={@stateLink('model.password')} type="password" className="form-control" id="inputPassword" placeholder="пароль" />
              </div>
            </div>
        }

        <div className="form-group">
          <label htmlFor="inputRole" className="col-md-2 control-label">Роль</label>
          <div className="col-md-10">
            <select valueLink={@stateLink('model.role')} className="form-control" id="inputRole" placeholder="роль">
              <option value="">Выберите поле</option>
              <option value="admin">Админ</option>
              <option value="moderator">Модератор</option>
              <option value="shop">Магазин</option>
            </select>
          </div>
        </div>

        <div className="text-right">
          <button className="btn btn-success" type="submit">Сохранить</button>
        </div>
      </form>
    </Layout>
