React = require('react')
{ ModelForm, Layout, FormStatus, FileUploader } = require('admin/components')


module.exports = class ShopRegisterView extends ModelForm
  title: -> 'Dellee • Регистрация магазина'

  render: ->
    <Layout className="p-shop_register">
      <header className="page-header">
        <h3>Регистрация магазина</h3>
      </header>
      <div className="well">
        {
          if @state.success
            <div>
              <h4 className="text-success"><i className="fa fa-hand-peace-o"></i> Успех!</h4>
              <p>
                Ваша заявка была успешна сохранена, мы свяжемся с вами в теченнии <strong>5 рабочих дней</strong>.
              </p>
              <p>
                Хотим напомнить что профиль магазина будет создан только после запуска проекта. Мы уведомим вас об этом по e-mail почте.
              </p>
              <p className="text-muted">
                Хорошего вам дня! <i className="fa fa-smile-o"></i>
              </p>
            </div>
          else
            <form className="form-horizontal" onSubmit={@handleSubmit}>
              <fieldset>
                <legend>Заполните форму</legend>
                <div className="form-group">
                  <label htmlFor="inputName" className="col-md-3 control-label">Название магазина</label>
                  <div className="col-md-9">
                    <input valueLink={@stateLink('model.name')} type="text" className="form-control" id="inputName" placeholder="Cool&Fun" />
                  </div>
                </div>
                <div className="form-group">
                  <label htmlFor="inputPerson" className="col-md-3 control-label">Контактное лицо</label>
                  <div className="col-md-9">
                    <div className="form-double">
                      <input valueLink={@stateLink('model.person.name')} type="text" className="form-control" id="inputPerson" placeholder="Имя" />
                      <input valueLink={@stateLink('model.person.surname')} type="text" className="form-control" placeholder="Фамилия" />
                    </div>
                  </div>
                </div>
                <div className="form-group">
                  <label htmlFor="inputEmail" className="col-md-3 control-label">E-mail</label>
                  <div className="col-md-9">
                    <input valueLink={@stateLink('model.contacts.email')} type="text" className="form-control" id="inputEmail" placeholder="shop@mail.com" />
                  </div>
                </div>
                <div className="form-group">
                  <label htmlFor="inputPhonenumber" className="col-md-3 control-label">Телефонный номер</label>
                  <div className="col-md-9">
                    <input valueLink={@stateLink('model.contacts.phonenumber')} type="text" className="form-control" id="inputPhonenumber" placeholder="+77XX XXX XXXX" />
                  </div>
                </div>
                <div className="form-group">
                  <label htmlFor="inputAdditional" className="col-md-3 control-label">Дополнительно</label>
                  <div className="col-md-9">
                    <textarea rows="5" valueLink={@stateLink('model.additional')} type="text" className="form-control" id="inputAdditional" />
                    <span className="help-block">Введите дополнительную информацию, которую мы должны принять во внимание</span>
                  </div>
                </div>
                <FormStatus {...@state} />
                <div className="form-buttons">
                  <button type="submit" className="btn btn-primary" disabled={@state.isLocked}>Отправить заявку</button>
                </div>
              </fieldset>
            </form>
        }
      </div>
    </Layout>
