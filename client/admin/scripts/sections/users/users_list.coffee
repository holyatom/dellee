React = require('react')
Component = require('admin/base/component')
{ TableView, Layout } = require('admin/components')


module.exports = class UsersListView extends Component
  title: -> 'Список пользователей'

  render: ->
    { data } = @props

    <Layout>
      <ul className="breadcrumb">
        <li><a href="/admin">Главная</a></li>
        <li className="active">Пользователи</li>
      </ul>
      <header className="page-header">
        <div className="row">
          <h3 className="col-xs-6 col-md-8">Пользователи</h3>
          <div className="col-xs-6 col-md-4 text-right">
            <a href={"#{data.controllerRoot}/create"} className="btn btn-success">Добавить</a>
          </div>
        </div>
      </header>
      <TableView data={@props.data} />
    </Layout>
