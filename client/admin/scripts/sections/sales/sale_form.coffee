React = require('react')
Form = require('admin/base/form')
Layout = require('admin/components/layout')


module.exports = class SaleView extends Form
  title: -> 'Обработка акции'

  initState: (props) ->
    model: props.data.model

  handleReject: (event) =>
    event.preventDefault()
    @state.model.status = 'rejected'
    @trigger('save', @state.model)

  handleProcess: (event) =>
    event.preventDefault()
    @state.model.status = 'processed'
    @trigger('save', @state.model)

  render: ->
    <Layout>
      <header className="page-header">
        <div className="row">
          <h3 className="col-xs-6 col-md-8">{@title()}</h3>
        </div>
      </header>
      <section className="c-model_form form-horizontal">
        <div className="form-group">
          <label className="col-sm-3 control-label">Статус</label>
          <div className="col-sm-9">
            <p className="form-control-static">{ @state.model.status }</p>
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
            <p className="form-control-static">{ @state.model.start_date }</p>
          </div>
        </div>

        <div className="form-group">
          <label className="col-sm-3 control-label">Дата окончания</label>
          <div className="col-sm-9">
            <p className="form-control-static">{ @state.model.end_date }</p>
          </div>
        </div>

        <div className="form-group">
          <label className="col-sm-3 control-label">Сообщение для отправки</label>
          <div className="col-sm-9">
            <p className="form-control-static">{ @state.model.message }</p>
          </div>
        </div>

        {
          if @state.model.status is 'pending'
            <div className="panel panel-success">
              <div className="panel-heading">
                <h3 className="panel-title">Подвердить</h3>
              </div>
              <div className="panel-body">
                <form className="form-horizontal" onSubmit={@handleProcess}>
                  <div className="text-right">
                    <button className="btn btn-success" type="submit">Отправить</button>
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
                    <button className="btn btn-danger" type="submit">Отправить</button>
                  </div>
                </form>
              </div>
            </div>
        }
      </section>
    </Layout>
