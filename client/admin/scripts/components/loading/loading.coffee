React = require('react')
Component = require('admin/base/component')


module.exports = class Loading extends Component
  render: ->
    <div className="c-loading">
      <h3>Loading...</h3>
      <div className="c-l-spinner">
        <div className="ui-spinner">
          <div className="ui-s-rect1"></div>
          <div className="ui-s-rect2"></div>
          <div className="ui-s-rect3"></div>
          <div className="ui-s-rect4"></div>
          <div className="ui-s-rect5"></div>
        </div>
      </div>
    </div>
