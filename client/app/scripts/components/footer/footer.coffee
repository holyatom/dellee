React = require('react')
Component = require('app/base/component')


module.exports = class Footer extends Component
  render: ->
    <div>
      <div className="container">
        <footer className="c-footer">
          © {(new Date()).getFullYear()} Delle.
        </footer>
      </div>
    </div>
