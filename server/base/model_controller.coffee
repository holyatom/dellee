_ = require('lodash')
Controller = require('./controller')


module.exports = class ModelController extends Controller
  logPrefix: '[model controller]'

  apiPrefix: '/api'
  urlPrefix: null

  Model: null

  keyField: '_id'

  router: ->
    throw new Error('Actions are not specified') unless @actions

    baseUrl = "#{@apiPrefix}#{@urlPrefix}"

    for action in @actions
      handlers = []
      handler = @[action]

      method = handler.type or 'get'
      handlerUrl = handler.url or ''
      url = "#{baseUrl}#{handlerUrl}"

      handlers.push(@getModelItem) if handlerUrl.indexOf('/:id') >= 0
      handlers.push(handler)

      @_handler(method, url, handlers...)


  # Get model
  get: (req, res, next) ->
    @mapDoc?(req, res, next, req.modelItem) or res.json(req.modelItem.toJSON())

  ModelController::get.url = '/:id'


  # Create model
  create: (req, res, next) ->
    model = new @Model(req.body)

    model.validate (err) =>
      return @error(res, err.errors) if err

      model.save (err, doc) =>
        return next(err) if err
        @mapDoc?(req, res, next, doc) or res.json(doc.toJSON())

  ModelController::create.type = 'post'


  # Delete model
  delete: (req, res, next) ->
    @Model.remove req.modelItem, (err) =>
      return next(err) if err
      res.json(success: true)

  ModelController::delete.type = 'delete'
  ModelController::delete.url = '/:id'


  # Middlewares
  getModelItem: (req, res, next) ->
    filter = {}
    filter[@keyField] = req.params.id

    @Model.findOne(filter).exec (err, doc) =>
      return next(err) if err
      return @notFound(res) unless doc

      req.modelItem = doc
      next()
