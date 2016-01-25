React = require('react')
Component = require('admin/base/component')
{ Footer } = require('admin/components')


module.exports = class ErrorView extends Component
  title: -> 'Error'

  render: ->
    <div className="p-error layout">
      <div className="l-top"></div>
      <div>
        <div className="container text-center">
          <h1>500</h1>
          <h2>Ошибка сервера</h2>
          <p>
            <a href="/admin">На главную</a>
          </p>
        </div>
      </div>
      <div className="l-bottom"></div>
      <Footer />
    </div>
