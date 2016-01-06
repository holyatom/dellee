vent = require('app/modules/vent')
React = require('react')
Form = require('app/base/form')
{ Footer } = require('app/components')


module.exports = class HomeView extends Form
  title: -> 'Dellee • Первый мессенджер акций'

  initState: ->
    model: {}
    success: false
    error: false

  share: (type) ->
    vent.trigger("share:#{type}")

  handleSubmit: (event) =>
    return if @state.isLocked

    event.preventDefault()
    @trigger('save', @state.model)

  render: ->
    <div className="layout p-home">
      <div className="l-wrapper">
        <div className="container">
          <section className="p-h-top">
            <h1 className="ui-logo">Dellee<span className="ui-l-beta_label"></span></h1>
            <h2>Первый Мессенджер Акций</h2>
            <h3>узнавай первым о скидках и акциях в любимых магазинах</h3>
            <div className="p-h-t-divider"></div>
            <a href="/" className="ui-btn ui-btn_default">о проекте</a>
          </section>
          <section className="p-h-benefits">
            <h2>Наши преимущества</h2>
            <ul className="p-h-benefits_list">
              <li>
                <figure><i className="icon-check_form"></i></figure>
                <h3>Подписывайся одним кликом</h3>
                <p>
                  It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.
                </p>
              </li>
              <li>
                <figure><i className="icon-lock"></i></figure>
                <h3>Конфиденциальность</h3>
                <p>
                  It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.
                </p>
              </li>
              <li>
                <figure><i className="icon-mail_phone"></i></figure>
                <h3>Уведомления</h3>
                <p>
                  It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.
                </p>
              </li>
              <li>
                <figure><i className="icon-data_storage"></i></figure>
                <h3>Единая база</h3>
                <p>
                  It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.
                </p>
              </li>
            </ul>
          </section>
          <section className="p-h-signup">
            <h2>Ранний доступ</h2>
            <div className="ui-alert ui-alert_info">
              <span className="ui-a-icon">
                <i className="icon-info"></i>
              </span>
              Приложение находится на стадии разработки, но вы можете оставить нам свой e-mail адрес и мы уведомим вас о запуске
            </div>
            <form className={@cx('p-h-s-form', success: @state.success)} onSubmit={@handleSubmit}>
              <div className="ui-panel">
                <div className="ui-p-body">
                  <h3>Заполните форму</h3>
                  <div className="ui-form_group">
                    <input valueLink={@stateLink('model.email')} type="text" className="ui-form_control" placeholder="email" />
                  </div>

                  {
                    if @state.error
                      <div className="ui-help_block ui-help_block_error">{ @state.error }</div>
                  }

                  <div className="ui-form_buttons">
                    <button type="submit" className="ui-btn ui-btn_block ui-btn_primary" disabled={@state.isLocked}>Подписаться</button>
                  </div>
                </div>

                <div className="p-h-success_signup">
                  <div className="p-h-ss-body">
                    <span className="ui-iconbox-success">
                      <i className="icon-check"></i>
                    </span>
                    <p>
                      Вы успешно подписаны на запуск!
                    </p>
                  </div>
                </div>
              </div>
            </form>
            <div className="p-h-share">
              Расскажи о <strong>Dellee</strong> своим друзьям
              <span className="p-h-s-links">
                <span className="ui-iconbox-circle ui-iconbox-circle_vk" onClick={@share.bind(@, 'vk')}><i className="icon-vk"></i></span>
                <span className="ui-iconbox-circle ui-iconbox-circle_twitter" onClick={@share.bind(@, 'twitter')}><i className="icon-twitter"></i></span>
              </span>
            </div>
          </section>
        </div>
      </div>
      <Footer />
    </div>
