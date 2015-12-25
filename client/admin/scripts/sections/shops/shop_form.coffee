React = require('react')
ModelForm = require('admin/base/model_form')
Layout = require('admin/components/layout')


module.exports = class ShopView extends ModelForm
  title: -> if @state.model._id then 'Редактирование магазина' else 'Создание магазина'

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
          <label htmlFor="inputName" className="col-md-2 control-label">Название</label>
          <div className="col-md-10">
            <input valueLink={@stateLink('model.name')} type="text" className="form-control" id="inputName" placeholder="название" />
          </div>
        </div>

        <div className="text-right">
          <button className="btn btn-success" type="submit">Сохранить</button>
        </div>
      </form>
    </Layout>
