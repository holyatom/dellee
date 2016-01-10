React = require('react')
{ ModelForm, Layout, FormStatus } = require('admin/components')


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
                <button onClick={@handleDelete} className="btn btn-danger">Удалить</button>
              </div>
          }
        </div>
      </header>
      <form className="c-model_form form-horizontal" onSubmit={@handleSubmit}>
        <div className="form-group">
          <label htmlFor="inputName" className="col-md-3 control-label">Название</label>
          <div className="col-md-9">
            <input valueLink={@stateLink('model.name')} type="text" className="form-control" id="inputName" placeholder="название" />
          </div>
        </div>

        <FormStatus {...@state} />

        <div className="text-right">
          <button className="btn btn-success" type="submit" disabled={@state.isLocked}>Сохранить</button>
        </div>
      </form>
    </Layout>
