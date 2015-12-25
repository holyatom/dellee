_ = require('lodash')
$ = require('jquery')
React = require('react')
Controller = require('../base/controller')
vent = require('../modules/vent')


module.exports = class CrudController extends Controller
  Model: null
  Collection: null

  FormView: null
  ListView: null

  controllerRoot: null

  index: (ctx, done) ->
    collection = new @Collection()

    @xhrs.list = collection.fetch()
    @xhrs.extraData = @fetchExtraData('list')

    $.when(@xhrs.list, @xhrs.extraData).then =>
      data =
        collection: collection.toJSON()
        controllerRoot: "/admin#{@controllerRoot}"

      _.extend(data, @extraData('list'))
      @renderView(<@ListView data={data} />, done)

    .fail (xhr) =>
      @renderErrorView(xhr, done)

  edit: (ctx, done) ->
    model = new @Model(_id: ctx.params.id)

    @xhrs.extraData = @fetchExtraData('edit')
    @xhrs.model = model.fetch()

    $.when(@xhrs.extraData, @xhrs.model).then =>
      data =
        model: model.toJSON()
        controllerRoot: "/admin#{@controllerRoot}"

      _.extend(data, @extraData('edit'))
      @renderView(<@FormView onSave={@updateModel} data={data} />, done)

    .fail (xhr) =>
      @renderErrorView(xhr, done)

  create: (ctx, done) ->
    @xhrs.extraData = @fetchExtraData('create').then =>
      data =
        model: {}
        controllerRoot: "/admin#{@controllerRoot}"

      _.extend(data, @extraData('create'))
      @renderView(<@FormView onSave={@saveModel} data={data} />, done)

    .fail (xhr) =>
      @renderErrorView(xhr, done)

  updateModel: (data) =>
    model = new @Model(data)
    @xhrs.save = model.save()

  saveModel: (data) =>
    model = new @Model(data)
    @xhrs.save = model.save().then (newModel) =>
      vent.trigger('navigate', "/admin#{@controllerRoot}/#{newModel._id}", force: true)

  # Override in child
  extraData: (method) -> {}

  fetchExtraData: (method) ->
    dfd = $.Deferred()
    dfd.resolve()
    dfd
