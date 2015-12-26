React = require('react')
ModelForm = require('admin/base/model_form')
Layout = require('admin/components/layout')


module.exports = class SaleView extends ModelForm
  title: -> if @state.model._id then 'Редактирование акции' else 'Создание акции'

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
          <label htmlFor="inputTitle" className="col-md-2 control-label">Заголовок</label>
          <div className="col-md-10">
            <input valueLink={@stateLink('model.title')} type="text" className="form-control" id="inputTitle" placeholder="заголовок" />
          </div>
        </div>

        <div className="form-group">
          <label htmlFor="inputStartDate" className="col-md-2 control-label">Дата запуска</label>
          <div className="col-md-10">
            <input valueLink={@stateLink('model.start_date')} type="text" className="form-control" id="inputStartDate" placeholder="mm.dd.yyyy" />
          </div>
        </div>

        <div className="form-group">
          <label htmlFor="inputEndDate" className="col-md-2 control-label">Дата окончания</label>
          <div className="col-md-10">
            <input valueLink={@stateLink('model.end_date')} type="text" className="form-control" id="inputEndDate" placeholder="mm.dd.yyyy" />
          </div>
        </div>

        <div className="form-group">
          <label htmlFor="inputDescription" className="col-md-2 control-label">Описание</label>
          <div className="col-md-10">
            <textarea valueLink={@stateLink('model.description')} type="text" className="form-control" id="inputDescription" placeholder="описание" />
          </div>
        </div>

        <div className="text-right">
          <button className="btn btn-success" type="submit">Сохранить</button>
        </div>
      </form>
    </Layout>
