React = require('react')
Form = require('../../base/form')
Customer = require('../../models/customer')


module.exports = class SubscribeForm extends Form
  initState: ->
    model: {}

  handleSubmit: (event) =>
    event.preventDefault()
    return if @state.isLocked

    customer = new Customer(email: @state.model.contact)
    dfd = customer.save()

    @lockForm()

    dfd.then =>
      alert('success')
    .always =>
      @unlockForm()

  render: ->
    <form onSubmit={@handleSubmit}>
      <input type="text" name="contact" placeholder="email | # номер телефона" valueLink={@stateLink('model.contact')}></input>
      <button type="submit" disabled={@state.isLocked}>Подписаться</button>
    </form>
