Form = require('./form')


module.exports = class ModelForm extends Form
  initState: (props) ->
    model: props.data.model

  handleSubmit: (event) =>
    event.preventDefault()
    @trigger('save', @state.model)
