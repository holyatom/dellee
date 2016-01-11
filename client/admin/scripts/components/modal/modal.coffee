React = require('react')
ReactDOM = require('react-dom')
Component = require('admin/base/component')
scroll = require('admin/modules/scroll')

modalNode = document.getElementById('modal-node')


class Modal extends Component
  initState: ->
    View: null
    active: false

  show: (View) ->
    scroll.lock()
    @setState({ View, active: true })

  close: ->
    scroll.unlock()
    @refreshState()

  render: ->
    <div className={@cx('c-modal', active: @state.active )}>
      <div className="c-m-wrapper">
        <div className="c-m-container">
          <div className="c-m-content">{@state.View or false}</div>
        </div>
      </div>
    </div>

module.exports = ReactDOM.render(<Modal />, modalNode)
