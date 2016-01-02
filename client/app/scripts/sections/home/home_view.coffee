React = require('react')
Form = require('app/base/form')
{ Footer } = require('app/components')


module.exports = class HomeView extends Form
  title: -> 'Dellee • Первый мессенджер акций'

  initState: ->
    model: {}
    success: false

  handleSubmit: (event) =>
    event.preventDefault()
    console.warn('SAVE', @state.model)
    @setState(success: true)

  render: ->
    <div className="layout p-home">
      <div className="l-wrapper">
        <div className="container">
          <section className="p-h-top">
            <h1 className="ui-logo">Dellee<span className="ui-l-beta_label"></span></h1>
            <h2>Первый Мессенджер Акций</h2>
            <h3>узнавай первым о скидках и акциях в любимых магазинах</h3>
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
          <section className={@cx('p-h-signup', success: @state.success)}>
            <h2>Ранний доступ</h2>
            <form onSubmit={@handleSubmit}>
              <div className="ui-alert ui-alert_info">
                <span className="ui-a-icon">
                  <i className="icon-info"></i>
                </span>
                Приложение находится на стадии разработки, но вы можете оставить нам свой e-mail адрес и мы уведомим вас о запуске
              </div>
              <div className="ui-panel">
                <div className="ui-p-body">
                  <h3>Заполните форму</h3>
                  <div className="ui-form_group">
                    <input valueLink={@stateLink('model.email')} type="text" className="ui-form_control" placeholder="email" />
                  </div>
                  <div className="ui-form_buttons">
                    <button type="submit" className="ui-btn ui-btn_block ui-btn_primary">Подписаться</button>
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
          </section>
        </div>
      </div>
      <Footer />
    </div>
