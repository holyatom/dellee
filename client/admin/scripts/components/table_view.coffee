React = require('react')
Component = require('../base/component')


module.exports = class TableView extends Component
  render: ->
    { fields, fieldNames, collection, idAttribute } = @props.data.collection
    { controllerRoot } = @props.data

    <table className="table table-hover">
      <thead>
        <tr>
          {fields.map((field, index) ->
            <th key={index}>{fieldNames[field] or field}</th>
          )}
          <th></th>
        </tr>
      </thead>
      <tbody>
        {collection.map((item, index) ->
          <tr key={index}>
            {fields.map((field, index) ->
              <td key={index}>{item[field]}</td>
            )}
            <td className="text-right">
              <a href={"#{controllerRoot}/#{item[idAttribute]}"}>Изменить</a>
            </td>
          </tr>
        )}
      </tbody>
    </table>