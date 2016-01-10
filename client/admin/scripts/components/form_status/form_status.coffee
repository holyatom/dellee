React = require('react')
Component = require('admin/base/component')


module.exports = class FormStatus extends Component
  render: ->
    if @props.success
      <div className="alert alert-success">
        <strong>Успех!</strong> Данные успешно обработаны
      </div>
    else if @props.error
      <div className="alert alert-danger">
        <strong>Ошибка!</strong> {@props.error.message}
      </div>
    else
      false
