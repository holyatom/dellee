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
    collection.initParams(ctx)

    @xhrs.list = collection.fetch()

    $.when(@xhrs.list, @fetchExtraData('list')).then =>
      data =
        collection: collection.toJSON()
        controllerRoot: "/admin#{@controllerRoot}"

      _.extend(data, @extraData('list'))
      @renderView(<@ListView data={data} />, done)

    .fail (xhr) =>
      @renderErrorView(xhr, done)

  edit: (ctx, done) ->
    model = new @Model(_id: ctx.params.id)

    @xhrs.model = model.fetch()

    $.when(@fetchExtraData('edit'), @xhrs.model).then =>
      data =
        model: model.toJSON()
        controllerRoot: "/admin#{@controllerRoot}"

      _.extend(data, @extraData('edit'))
      @renderView(<@FormView onSave={@updateModel} onDelete={@deleteModel} data={data} />, done)

    .fail (xhr) =>
      @renderErrorView(xhr, done)

  create: (ctx, done) ->
    @fetchExtraData('create').then =>
      data =
        model: {}
        controllerRoot: "/admin#{@controllerRoot}"

      _.extend(data, @extraData('create'))
      @renderView(<@FormView onSave={@saveModel} data={data} />, done)

    .fail (xhr) =>
      @renderErrorView(xhr, done)

  deleteModel: (data) =>
    model = new @Model(data)
    @xhrs.destroy = model.destroy()
    @xhrs.destroy.then =>
      vent.trigger('navigate', "/admin#{@controllerRoot}")

  updateModel: (data) =>
    model = new @Model(data)
    @xhrs.save = model.save()
    @xhrs.save.then (updatedModel) =>
      @view.setState(model: updatedModel)

  saveModel: (data) =>
    model = new @Model(data)
    @xhrs.save = model.save()
    @xhrs.save.then (newModel) =>
      vent.trigger('navigate', "/admin#{@controllerRoot}/#{newModel._id}", force: true)

  # Override in child
  extraData: (method) -> {}

  fetchExtraData: (method) ->
    dfd = $.Deferred()
    dfd.resolve()
    dfd
