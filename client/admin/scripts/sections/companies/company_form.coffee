React = require('react')
{ ModelForm, Layout, FormStatus, FileUploader } = require('admin/components')
profile = require('admin/modules/profile')
utils = require('lib/utils')


module.exports = class CompanyView extends ModelForm
  title: -> if @state.model._id then 'Редактирование компании' else 'Создание компании'

  componentDidMount: ->
    super
    @refs.uploader.setFiles([@state.model.logo]) if @state.model.logo

  componentWillUpdate: ->
    @state.model.slug = utils.slugify(@state.model.name)

  handleImageChange: =>
    @saveModel() if @state.model._id

  render: ->
    <Layout>
      <ul className="breadcrumb">
        <li><a href="/admin">Главная</a></li>
        {
          if profile.is('admin')
            [
              <li key={1}><a href={@props.data.controllerRoot}>Компании</a></li>
              <li key={2} className="active">{if @state.model._id then _.trunc(@state.model._id, 10) else 'Создание'}</li>
            ]
          else
            <li className="active">{@title()}</li>
        }
      </ul>
      <header className="page-header">
        <div className="row">
          <h3 className="col-xs-6 col-md-8">{@title()}</h3>
          {
            if @state.model._id and profile.is('admin')
              <div className="col-xs-6 col-md-4 text-right">
                <button onClick={@handleDelete} className="btn btn-danger">Удалить</button>
              </div>
          }
        </div>
      </header>
      <form className="c-model_form form-horizontal" onSubmit={@handleSubmit}>
        <div className="form-group">
          <label className="col-sm-3 control-label">Slug</label>
          <div className="col-sm-9">
            <p className="form-control-static">{@state.model.slug}</p>
          </div>
        </div>

        <div className="form-group">
          <label htmlFor="inputName" className="col-md-3 control-label">Название</label>
          <div className="col-md-9">
            <input valueLink={@stateLink('model.name')} type="text" className="form-control" id="inputName" placeholder="название" />
          </div>
        </div>

        <div className="form-group">
          <label className="col-md-3 control-label">Лого</label>
          <div className="col-md-9">
            <FileUploader ref="uploader" onChange={@handleImageChange} accept="image/*" valueLink={@stateLink('model.logo_url')} section="images/companies" />
          </div>
        </div>

        <FormStatus {...@state} />

        <div className="text-right">
          <button className="btn btn-success" type="submit" disabled={@state.isLocked}>Сохранить</button>
        </div>
      </form>
    </Layout>
