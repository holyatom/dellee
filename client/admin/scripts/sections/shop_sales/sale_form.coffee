React = require('react')
ModelForm = require('admin/base/model_form')
Layout = require('admin/components/layout')


module.exports = class SaleView extends ModelForm
  title: -> if @state.model._id then 'Редактирование акции' else 'Создание акции'

  handleSubmit: ->
    if @state.model.status is 'rejected'
      @state.model.status = 'pending'
      @state.model.status_message = ''

    super

  render: ->
    disableForm = @state.model.status is 'processed'

    <Layout>
      <header className="page-header">
        <div className="row">
          <h3 className="col-xs-6 col-md-8">{@title()}</h3>
          {
            if @state.model._id and not disableForm
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
              <label className="col-sm-3 control-label">Статус</label>
              <div className="col-sm-9">
                <p className="form-control-static">{ @state.model.status }</p>
              </div>
            </div>
        }

        <div className="form-group">
          <label htmlFor="inputTitle" className="col-md-3 control-label">Заголовок</label>
          <div className="col-md-9">
            <input valueLink={@stateLink('model.title')} type="text" className="form-control" id="inputTitle" placeholder="заголовок" disabled={disableForm} />
          </div>
        </div>

        <div className="form-group">
          <label htmlFor="inputStartDate" className="col-md-3 control-label">Дата запуска</label>
          <div className="col-md-9">
            <input valueLink={@stateLink('model.start_date')} type="text" className="form-control" id="inputStartDate" placeholder="mm.dd.yyyy" disabled={disableForm} />
          </div>
        </div>

        <div className="form-group">
          <label htmlFor="inputEndDate" className="col-md-3 control-label">Дата окончания</label>
          <div className="col-md-9">
            <input valueLink={@stateLink('model.end_date')} type="text" className="form-control" id="inputEndDate" placeholder="mm.dd.yyyy" disabled={disableForm} />
          </div>
        </div>

        <div className="form-group">
          <label htmlFor="inputMessage" className="col-md-3 control-label">Сообщение для отправки</label>
          <div className="col-md-9">
            <textarea valueLink={@stateLink('model.message')} type="text" className="form-control" id="inputMessage" placeholder="сообщение" disabled={disableForm} />
          </div>
        </div>

        {
          if @state.model.status is 'pending' or not @state.model._id
            <div className="text-right">
              <button className="btn btn-success" type="submit">Сохранить</button>
            </div>
        }

      </form>

      {
        if @state.model.status is 'rejected'
          <div className="panel panel-danger">
            <div className="panel-heading">
              <h3 className="panel-title">Отказано</h3>
            </div>
            <div className="panel-body">
              <form className="form-horizontal" onSubmit={@handleSubmit}>
                <div className="form-group">
                  <label className="col-sm-3 control-label">Причина отказа</label>
                  <div className="col-sm-9">
                    <p className="form-control-static">{ @state.model.status_message }</p>
                  </div>
                </div>
                <div className="text-right">
                  <button className="btn btn-danger" type="submit">Отправить заново</button>
                </div>
              </form>
            </div>
          </div>
        }
    </Layout>
