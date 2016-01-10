React = require('react')
{ ModelForm, Layout, FormStatus } = require('admin/components')


module.exports = class UserView extends ModelForm
  title: -> if @state.model._id then 'Редактирование пользователя' else 'Создание пользователя'

  render: ->
    { shops } = @props.data

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
        <div className="form-group">
          <label htmlFor="inputUsername" className="col-md-3 control-label">Логин</label>
          <div className="col-md-9">
            <input valueLink={@stateLink('model.username')} type="text" className="form-control" id="inputUsername" placeholder="логин" />
          </div>
        </div>

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
          <label htmlFor="inputRole" className="col-md-3 control-label">Роль</label>
          <div className="col-md-9">
            <select valueLink={@stateLink('model.role')} className="form-control" id="inputRole">
              <option value="">Выберите роль</option>
              <option value="admin">Админ</option>
              <option value="moderator">Модератор</option>
              <option value="shopadmin">Администратор магазина</option>
            </select>
          </div>
        </div>

        {
          if @state.model.role is 'shopadmin'
            <div className="form-group">
              <label htmlFor="inputShop" className="col-md-3 control-label">Магазин</label>
              <div className="col-md-9">
                <select valueLink={@stateLink('model.shop._id')} className="form-control" id="inputShop">
                  <option value="">Выберите магазин</option>
                  {shops.collection.map((shop, index) ->
                    <option key={index} value={shop._id}>{shop.name}</option>
                  )}
                </select>
              </div>
            </div>
        }

        <FormStatus {...@state} />

        <div className="text-right">
          <button className="btn btn-success" type="submit" disabled={@state.isLocked}>Сохранить</button>
        </div>
      </form>
    </Layout>
