React = require('react')
Component = require('../base/component')


module.exports = class TableView extends Component
  render: ->
    { fields, fieldNames, collection, idAttribute } = @props.data.collection
    { controllerRoot } = @props.data

    if collection.length
      <table className="table table-hover">
        <thead>
          <tr>
            {fields.map((field, index) ->
              <th key={index}>{fieldNames?[field] or field}</th>
            )}
            { unless @props.readonly then <th></th> }
          </tr>
        </thead>
        <tbody>
          {collection.map((item, index) =>
            <tr key={index}>
              {fields.map((field, index) ->
                <td key={index}>{item[field]}</td>
              )}
              {
                unless @props.readonly
                  <td className="text-right">
                    <a href={"#{controllerRoot}/#{item[idAttribute]}"}>Изменить</a>
                  </td>
              }
            </tr>
          )}
        </tbody>
      </table>
    else
      <h4>Записей не найдено</h4>
