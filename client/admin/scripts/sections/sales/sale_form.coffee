_ = require('lodash')
React = require('react')
Form = require('admin/base/form')
{ Layout, FormStatus } = require('admin/components')
formatters = require('lib/formatters')


module.exports = class SaleView extends Form
  title: -> 'Обработка акции'

  initState: (props) ->
    model: props.data.model

  handleReject: (event) =>
    event.preventDefault()
    return if @state.isLocked

    @state.model.status = 'rejected'
    @trigger('save', @state.model)

  handleProcess: (event) =>
    event.preventDefault()
    return if @state.isLocked

    @state.model.status = 'processed'
    @trigger('save', @state.model)

  render: ->
    <Layout>
      <ul className="breadcrumb">
        <li><a href="/admin">Главная</a></li>
        <li><a href={@props.data.controllerRoot}>Акции</a></li>
        <li className="active">{if @state.model._id then _.trunc(@state.model._id, 10) else 'Создание'}</li>
      </ul>
      <header className="page-header">
        <div className="row">
          <h3 className="col-xs-6 col-md-8">{@title()}</h3>
        </div>
      </header>
      <section className="c-model_form form-horizontal">
        <div className="form-group">
          <label className="col-sm-3 control-label">Статус</label>
          <div className="col-sm-9">
            <p className="form-control-static" dangerouslySetInnerHTML={{ __html: formatters.saleStatus(@state.model.status) }}></p>
          </div>
        </div>

        <div className="form-group">
          <label className="col-sm-3 control-label">Магазин</label>
          <div className="col-sm-9">
            <p className="form-control-static">{ @state.model.company?.name }</p>
          </div>
        </div>

        <div className="form-group">
          <label className="col-sm-3 control-label">Заголовок</label>
          <div className="col-sm-9">
            <p className="form-control-static">{ @state.model.title }</p>
          </div>
        </div>

        <div className="form-group">
          <label className="col-sm-3 control-label">Дата запуска</label>
          <div className="col-sm-9">
            <p className="form-control-static">{ formatters.date(@state.model.start_date) }</p>
          </div>
        </div>

        <div className="form-group">
          <label className="col-sm-3 control-label">Дата окончания</label>
          <div className="col-sm-9">
            <p className="form-control-static">{ formatters.date(@state.model.end_date) }</p>
          </div>
        </div>

        <div className="form-group">
          <label className="col-sm-3 control-label">Сообщение для отправки</label>
          <div className="col-sm-9">
            <p className="form-control-static">{ @state.model.message }</p>
          </div>
        </div>

        <FormStatus {...@state} />

        {
          if @state.model.status is 'pending'
            <div className="panel panel-success">
              <div className="panel-heading">
                <h3 className="panel-title">Подвердить</h3>
              </div>
              <div className="panel-body">
                <form className="form-horizontal" onSubmit={@handleProcess}>
                  <div className="text-right">
                    <button className="btn btn-success" type="submit" disabled={@state.isLocked}>Отправить</button>
                  </div>
                </form>
              </div>
            </div>
        }
        {
          if @state.model.status is 'pending'
            <div className="panel panel-danger">
              <div className="panel-heading">
                <h3 className="panel-title">Отказать</h3>
              </div>
              <div className="panel-body">
                <form className="form-horizontal" onSubmit={@handleReject}>
                  <div className="form-group">
                    <label htmlFor="inputRejectMessage" className="col-md-3 control-label">Причина отказа</label>
                    <div className="col-md-9">
                      <textarea valueLink={@stateLink('model.status_message')} type="text" className="form-control" id="inputRejectMessage" placeholder="отказ" />
                    </div>
                  </div>
                  <div className="text-right">
                    <button className="btn btn-danger" type="submit" disabled={@state.isLocked}>Отправить</button>
                  </div>
                </form>
              </div>
            </div>
        }
      </section>
    </Layout>
