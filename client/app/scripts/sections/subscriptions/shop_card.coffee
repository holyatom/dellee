React = require('react')
Form = require('app/base/form')
SubscriptionModel = require('./subscription_model')


module.exports = class ShopCard extends Form
  initState: (props) ->
    is_followed: props.shop.is_followed

  subscribe: =>
    return if @state.isLocked

    model = new SubscriptionModel()
    model.shopId = @props.shop._id

    @lockForm()
    model.save().then =>
      @setState(is_followed: true)
    .always =>
      @unlockForm()

  unsubscribe: =>
    return if @state.isLocked

    model = new SubscriptionModel()
    model.shopId = @props.shop._id

    @lockForm()
    model.destroy().then =>
      @setState(is_followed: false)
    .always =>
      @unlockForm()

  render: ->
    <div>
      <h4>{ @props.shop.name }</h4>
      {
        unless @state.is_followed
          <button onClick={@subscribe} disabled={@state.isLocked}>Подписаться</button>
        else
          <button onClick={@unsubscribe} disabled={@state.isLocked}>Отписаться</button>
      }
    </div>
