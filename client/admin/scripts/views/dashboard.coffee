React = require('react')
Component = require('../base/component')
Layout = require('./components/layout')


module.exports = class DashboardView extends Component
  title: -> 'Dellee • Админ панель'

  render: ->
    <Layout>
      <div className="page-header">
        <h3>Добро пожаловать</h3>
      </div>
    </Layout>
