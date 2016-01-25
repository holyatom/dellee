React = require('react')
{ Layout, ModelForm, FormStatus, Datepicker } = require('admin/components')
formatters = require('lib/formatters')


module.exports = class SaleView extends ModelForm
  title: -> if @state.model._id then 'Редактирование акции' else 'Создание акции'

  initState: (props) ->
    model = props.data.model
    model.date_range = [model.start_date, model.end_date]

    model: props.data.model

  handleSend: (event) =>
    @state.model.status = 'pending'
    @handleSubmit(event)

  saveModel: =>
    if @state.model.status is 'rejected'
      @state.model.status = 'pending'
      @state.model.status_message = ''

    @state.model.start_date = @state.model.date_range[0]
    @state.model.end_date = @state.model.date_range[1]

    @state.model.status = 'new' unless @state.model.status

    super

  render: ->
    disableForm = @state.model.status in ['processed', 'pending']

    <Layout>
      <ul className="breadcrumb">
        <li><a href="/admin">Главная</a></li>
        <li><a href={@props.data.controllerRoot}>Акции</a></li>
        <li className="active">{if @state.model._id then _.trunc(@state.model._id, 10) else 'Создание'}</li>
      </ul>
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
                <p className="form-control-static" dangerouslySetInnerHTML={{ __html: formatters.saleStatus(@state.model.status) }}></p>
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
          <label className="col-md-3 control-label">Период акции</label>
          <div className="col-md-9">
            <Datepicker valueLink={@stateLink('model.date_range')} disabled={disableForm} range />
          </div>
        </div>

        <div className="form-group">
          <label htmlFor="inputMessage" className="col-md-3 control-label">Сообщение для отправки</label>
          <div className="col-md-9">
            <textarea valueLink={@stateLink('model.message')} type="text" className="form-control" id="inputMessage" placeholder="сообщение" disabled={disableForm} />
          </div>
        </div>

        <FormStatus {...@state} />

        {
          if not @state.model._id or @state.model.status is 'new'
            <div className="form-buttons">
              <button className="btn btn-success" type="submit" disabled={@state.isLocked}>Сохранить</button>
              <button className="btn btn-warning" type="button" onClick={@handleSend} disabled={@state.isLocked}>Сохранить и отправить</button>
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
                  <button className="btn btn-danger" type="submit" disabled={@state.isLocked}>Отправить заново</button>
                </div>
              </form>
            </div>
          </div>
        }
    </Layout>
