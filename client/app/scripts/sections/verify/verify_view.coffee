React = require('react')
Component = require('app/base/component')
Footer = require('app/components/footer')


module.exports = class VerifyView extends Component
  title: -> 'Dellee • Верификация'

  render: ->
    <div className="p-verify layout">
      <div className="l-wrapper">
        <div className="container">
          <h1>Dellee</h1>
          <h2>Верификация email адреса</h2>
          {
            if @props.data.success
              <strong>Успех</strong>
            else
              <strong>Ошибка</strong>
          }
        </div>
      </div>
      <Footer />
    </div>
