React = require('react')
ModelForm = require('admin/base/model_form')
Layout = require('admin/components/layout')


module.exports = class CustomerForm extends ModelForm
  title: -> if @state.model._id then 'Редактирование клиента' else 'Создание клиента'

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
      <section className="c-model_form form-horizontal">
        <div className="form-group">
          <label htmlFor="inputUsername" className="col-md-3 control-label">Email</label>
          <div className="col-md-9">
            <p className="form-control-static">{ @state.model.email }</p>
          </div>
        </div>
      </section>
    </Layout>
