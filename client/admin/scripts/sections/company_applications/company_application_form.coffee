_ = require('lodash')
React = require('react')
Form = require('admin/base/form')
{ Layout, FormStatus, ModelForm } = require('admin/components')
formatters = require('lib/formatters')


module.exports = class CompanyApplicationView extends ModelForm
  title: -> 'Заявка компании'

  handleIsRepliedChange: (event) =>
    @state.model.is_replied = !@state.model.is_replied
    @saveModel()

  render: ->
    <Layout>
      <ul className="breadcrumb">
        <li><a href="/admin">Главная</a></li>
        <li><a href={@props.data.controllerRoot}>Заявки компаний</a></li>
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
            <p className="form-control-static" dangerouslySetInnerHTML={{ __html: formatters.applicationStatus(@state.model.status) }}></p>
          </div>
        </div>

        <div className="form-group">
          <label className="col-sm-3 control-label">Название</label>
          <div className="col-sm-9">
            <p className="form-control-static">{ @state.model.company_name }</p>
          </div>
        </div>

        <div className="form-group">
          <label className="col-sm-3 control-label">Контактное лицо</label>
          <div className="col-sm-9">
            <p className="form-control-static">{ @state.model.person.name } { @state.model.person.surname }</p>
          </div>
        </div>

        <div className="form-group">
          <label className="col-sm-3 control-label">E-mail</label>
          <div className="col-sm-9">
            <p className="form-control-static">{ @state.model.contacts.email }</p>
          </div>
        </div>

        <div className="form-group">
          <label className="col-sm-3 control-label">Телефонный номер</label>
          <div className="col-sm-9">
            <p className="form-control-static">{ if phonenumber = @state.model.contacts.phonenumber then phonenumber else <span className="text-muted">Не указан</span> }</p>
          </div>
        </div>

        <div className="form-group">
          <label className="col-sm-3 control-label">Дополнительно</label>
          <div className="col-sm-9">
            <p className="form-control-static">{ if additional = @state.model.additional then additional else <span className="text-muted">Не указано</span> }</p>
          </div>
        </div>

        <div className="form-group">
          <label className="col-md-3 control-label">Операции</label>
          <div className="col-md-9">
            <div className="checkbox">
              <label>
                <input name="is_replied" onChange={@handleIsRepliedChange} checked={@state.model.is_replied} type="checkbox" /> Компании ответили
              </label>
            </div>
          </div>
        </div>
      </section>
    </Layout>
