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

        <div className="form-group">
          <label htmlForm="inputNotes" className="col-md-3 control-label">Заметки</label>
          <div className="col-md-9">
            <textarea name="notes" rows="5" valueLink={@stateLink('model.notes')} type="text" className="form-control" id="inputNotes" />
            <span className="help-block with-errors"></span>
          </div>
        </div>

        <FormStatus {...@state} />
        <div className="form-buttons">
          <button type="submit" className="btn btn-primary" disabled={@state.isLocked}>Сохранить</button>
        </div>
      </form>
    </Layout>
