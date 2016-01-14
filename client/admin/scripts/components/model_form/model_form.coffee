Form = require('admin/base/form')


module.exports = class ModelForm extends Form
  initState: (props) ->
    model: props.data.model

  handleSubmit: (event) =>
    event.preventDefault()
    return if @state.isLocked
    @saveModel()

  handleDelete: =>
    return if @state.isLocked

    if confirm('Вы уверены что хотите удалить запись?')
      @trigger('delete', @state.model)

  saveModel: =>
    @trigger('save', @state.model)
