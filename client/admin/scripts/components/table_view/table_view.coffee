_ = require('lodash')
React = require('react')
Component = require('admin/base/component')


module.exports = class TableView extends Component
  render: ->
    { fields, fieldNames, collection, pagination, idAttribute, canPaginate, fieldFormats } = @props.data.collection
    { controllerRoot } = @props.data

    unless pagination.page is pagination.totalPage
      nextLink = <li className="next"><a href={"#{controllerRoot}?page=#{pagination.page + 1 }"}>Следущая</a></li>
    else
      nextLink = <li className="next disabled"><span>Следущая</span></li>

    unless pagination.page is 1
      prevLink = <li className="previous"><a href={"#{controllerRoot}?page=#{pagination.page - 1}"}>Предыдущая</a></li>
    else
      prevLink = <li className="previous disabled"><span>Предыдущая</span></li>

    if collection.length
      <div>
        <p className="text-muted">Всего записей: {pagination.total}</p>
        <div className="table-responsive">
          <table className="table table-hover">
            <thead>
              <tr>
                {fields.map((field, index) ->
                  <th key={index}>{_.capitalize(fieldNames?[field] or field)}</th>
                )}
                { unless @props.readonly then <th></th> }
              </tr>
            </thead>
            <tbody>
              {collection.map((item, index) =>
                <tr key={index}>
                  {fields.map((field, index) ->
                    <td key={index} dangerouslySetInnerHTML={{ __html: fieldFormats?[field]?(item[field]) or item[field] }}></td>
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
        </div>
        {
          if canPaginate
            <ul className="pager">
              {prevLink}
              {nextLink}
            </ul>
        }
      </div>
    else
      <h4>Нет записей</h4>
