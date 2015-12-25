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

    @xhrs.list = collection.fetch().then =>
      data =
        collection: collection.toJSON()
        controllerRoot: "/admin#{@controllerRoot}"

      @renderView(<@ListView data={data} />, done)

    .fail (xhr) =>
      @renderErrorView(xhr, done)

  edit: (ctx, done) ->
    model = new @Model(_id: ctx.params.id)

    @xhrs.model = model.fetch().then =>
      data =
        model: model.toJSON()
        controllerRoot: "/admin#{@controllerRoot}"

      @renderView(<@FormView onSave={@updateModel} data={data} />, done)

    .fail (xhr) =>
      @renderErrorView(xhr, done)

  create: (ctx, done) ->
    data =
      model: {}
      controllerRoot: "/admin#{@controllerRoot}"

    @renderView(<@FormView onSave={@saveModel} data={data} />, done)

  updateModel: (data) =>
    model = new @Model(data)
    @xhrs.save = model.save()

  saveModel: (data) =>
    model = new @Model(data)
    @xhrs.save = model.save().then (newModel) =>
      vent.trigger('navigate', "/admin#{@controllerRoot}/#{newModel._id}", force: true)
