require('bootstrap-datepicker')
require('bootstrap-datepicker/js/locales/bootstrap-datepicker.ru')
$ = require('jquery')
React = require('react')
Component = require('admin/base/component')


module.exports = class Datepicker extends Component
  stripTime: (date, end = false) ->
    hh = if end then 23 else 0
    mm = if end then 59 else 0

    new Date(date.getFullYear(), date.getMonth(), date.getDate(), hh, mm)

  getDate: (date) ->
    return null unless date
    date = new Date(date) unless date instanceof Date
    date

  handleChange: (event) =>
    if @props.range
      value = [@stripTime(@picker.pickers[0].dates[0]), @stripTime(@picker.pickers[1].dates[0], true)]
    else
      value = @stripTime(event.date)

    @props.valueLink.requestChange(value)

  options: ->
    language: 'ru'
    orientation: 'bottom auto'
    clearBtn: true
    toggleActive: true
    format: 'dd MM yyyy'

  componentDidMount: ->
    super
    @$input = $(@refs.input)
    @$input.datepicker(@options())
    @picker = @$input.data('datepicker')

    if @props.range
      @$input.find('input[name="start"]').datepicker('setDate', @getDate(start)) if start = @props.valueLink.value?[0]
      @$input.find('input[name="end"]').datepicker('setDate', @getDate(end)) if end = @props.valueLink.value?[1]
    else
      @$input.datepicker('setDate', @getDate(value)) if value = @props.valueLink.value

    @$input.datepicker().on('change', @handleChange)

  render: ->
    if @props.range
      <div className="input-group input-daterange" ref="input">
          <input type="text" placeholder="Дата начала" className="form-control" name="start" required={@props.required} disabled={@props.disabled} />
          <span className="input-group-addon">до</span>
          <input type="text" placeholder="Дата конца" className="form-control" name="end" required={@props.required} disabled={@props.disabled} />
      </div>
    else
      <div className="input-group date" ref="input">
        <input name="date" type="text" className="form-control" placeholder="Дата" required={@props.required} disabled={@props.disabled} />
        <span className="input-group-addon"><i className="fa fa-calendar-o"></i></span>
      </div>
