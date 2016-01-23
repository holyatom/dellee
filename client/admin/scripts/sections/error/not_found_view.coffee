React = require('react')
Component = require('admin/base/component')
{ Footer } = require('admin/components')


module.exports = class NotFoundView extends Component
  title: -> 'Not Found'

  render: ->
    <div className="p-error layout">
      <div className="l-top"></div>
      <div>
        <div className="container text-center">
          <h1>404</h1>
          <h2>Страница не найдена</h2>
          <p>
            <a href="/admin">На главную</a>
          </p>
        </div>
      </div>
      <div className="l-bottom"></div>
      <Footer />
    </div>
