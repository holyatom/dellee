React = require('react')
Component = require('admin/base/component')
{ Layout } = require('admin/components')


module.exports = class DashboardView extends Component
  title: -> 'Dellee • Админ панель'

  render: ->
    <Layout>
      <ul className="breadcrumb">
        <li className="active">Главная</li>
      </ul>
      <div className="page-header">
        <h3>Добро пожаловать</h3>
      </div>
    </Layout>
