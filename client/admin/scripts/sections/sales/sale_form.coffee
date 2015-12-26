React = require('react')
Form = require('admin/base/form')
Layout = require('admin/components/layout')


module.exports = class SaleView extends Form
  title: -> 'Обработка акции'

  initState: ->
    reject: {}

  render: ->
    <Layout>
      <header className="page-header">
        <div className="row">
          <h3 className="col-xs-6 col-md-8">{@title()}</h3>
        </div>
      </header>
      <section className="c-model_form form-horizontal">
        <div className="form-group">
          <label className="col-sm-2 control-label">Заголовок</label>
          <div className="col-sm-10">
            <p className="form-control-static">{ @props.data.model.title }</p>
          </div>
        </div>

        <div className="form-group">
          <label className="col-sm-2 control-label">Дата запуска</label>
          <div className="col-sm-10">
            <p className="form-control-static">{ @props.data.model.start_date }</p>
          </div>
        </div>

        <div className="form-group">
          <label className="col-sm-2 control-label">Дата окончания</label>
          <div className="col-sm-10">
            <p className="form-control-static">{ @props.data.model.end_date }</p>
          </div>
        </div>

        <div className="form-group">
          <label className="col-sm-2 control-label">Описание</label>
          <div className="col-sm-10">
            <p className="form-control-static">{ @props.data.model.description }</p>
          </div>
        </div>

        <div className="panel panel-success">
          <div className="panel-heading">
            <h3 className="panel-title">Подвердить</h3>
          </div>
          <div className="panel-body">
            <form className="form-horizontal">
              <div className="text-right">
                <button className="btn btn-success" type="submit">Отправить</button>
              </div>
            </form>
          </div>
        </div>

        <div className="panel panel-danger">
          <div className="panel-heading">
            <h3 className="panel-title">Отказать</h3>
          </div>
          <div className="panel-body">
            <form className="form-horizontal">
              <div className="form-group">
                <label htmlFor="inputRejectMessage" className="col-sm-2 control-label">Причина отказа</label>
                <div className="col-sm-10">
                  <textarea valueLink={@stateLink('reject.message')} type="text" className="form-control" id="inputRejectMessage" placeholder="отказ" />
                </div>
              </div>
              <div className="text-right">
                <button className="btn btn-danger" type="submit">Отправить</button>
              </div>
            </form>
          </div>
        </div>
      </section>
    </Layout>
