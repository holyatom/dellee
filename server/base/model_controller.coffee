_ = require('lodash')
Q = require('q')
Controller = require('./controller')
File = require('server/models/file')


module.exports = class ModelController extends Controller
  logPrefix: '[model controller]'

  apiPrefix: '/api'
  urlPrefix: null

  Model: null

  keyField: '_id'

  DEFAULT_PAGE: 1
  DEFAULT_PERPAGE: 20
  MAX_PERPAGE: 100

  DEFAULT_ORDER: '_id'

  # Overide in child
  joins: null
  listJoins: null

  filterableFields: null
  sortableFields: null

  listFields: null
  updateFields: null

  router: ->
    throw new Error('Actions are not specified') unless @actions
    throw new Error('List fields are not specified') if not @listFields and 'list' in @actions
    throw new Error('Update fields are not specified') if not @updateFields and 'update' in @actions

    baseUrl = "#{@apiPrefix}#{@urlPrefix}"

    for action in @actions
      handlers = []
      handler = @[action]

      method = handler.type or 'get'
      handlerUrl = handler.url or ''
      url = "#{baseUrl}#{handlerUrl}"

      @addHandlers?(handler, handlers)
      handlers.push(@getModelDoc) if handlerUrl.indexOf('/:id') >= 0
      handlers.push(handler)

      @_handler(method, url, handlers...)


  # Get model
  get: (req, res, next) ->
    if @joins
      opts = (path: name, select: fields.join(' ') for name, fields of @joins)

      @Model.populate req.modelDoc, opts, (err, doc) =>
        return next(err) if err
        @mapDoc(req, res, next)
    else
      @mapDoc(req, res, next)

  ModelController::get.url = '/:id'


  # Create model
  create: (req, res, next) ->
    model = new @Model(req.body)

    model.validate (err) =>
      return @error(res, err.errors) if err

      model.save (err, doc) =>
        return next(err) if err
        req.modelDoc = doc

        @get(req, res, next)

  ModelController::create.type = 'post'


  # Update model
  update: (req, res, next) ->
    req.oldDoc = new @Model(req.modelDoc.toObject())

    fields = @getUpdateFields(req)
    req.modelDoc.set(fields)

    req.modelDoc.validate (err) =>
      return @error(res, err.errors) if err

      req.modelDoc.save (err) =>
        return next(err) if err
        @get(req, res, next)

  ModelController::update.type = 'put'
  ModelController::update.url = '/:id'

  # Delete model
  delete: (req, res, next) ->
    @Model.remove _id: req.modelDoc._id, (err) =>
      return next(err) if err
      res.json(success: true)

  ModelController::delete.type = 'delete'
  ModelController::delete.url = '/:id'


  # Collection list
  list: (req, res, next) ->
    opts = @getListOptions(req)

    countQuery = @Model.count(opts.filters)

    collectionQuery = @Model
      .find(opts.filters)
      .select(opts.select)
      .sort(opts.order)
      .skip((opts.page - 1) * opts.perPage)
      .limit(opts.perPage)
      .lean()

    @populateQuery(collectionQuery, @listJoins) if @listJoins

    Q.all([
      collectionQuery.exec()
      countQuery.exec()
    ])
    .then ([collection, count]) =>
      data =
        collection: collection
        total: count
        page: opts.page
        per_page: opts.perPage

      @mapList?(req, res, next, data) or res.json(data)

    .fail (err) =>
      next(err)


  # Middlewares
  getModelDoc: (req, res, next) ->
    filter = {}
    filter[@keyField] = req.params.id

    @Model.findOne(filter).exec (err, doc) =>
      return next(err) if err
      return @notFound(res) unless doc

      req.modelDoc = doc
      next()

  mapDoc: (req, res, next) ->
    res.json(req.modelDoc.toJSON())


  # Helpers
  populateQuery: (query, joins) ->
    for name, fields of joins
      query.populate(name, fields.join(' '))

  getUpdateFields: (req) ->
    fields = _.pick(req.body, @updateFields)

    for key, field of fields
      if key.indexOf('url') >= 0
        File.deleteByUrl(req.modelDoc[key]) if req.modelDoc[key] and req.modelDoc[key] isnt field

    fields

  getListOptions: (req) ->
    opts =
      page: parseInt(req.query.page, 10) or @DEFAULT_PAGE
      perPage: parseInt(req.query.per_page, 10) or @DEFAULT_PERPAGE

      order: @DEFAULT_ORDER
      filters: {}
      select: @listFields.join(' ')

    opts.select += ' -_id' unless '_id' in @listFields

    opts.perPage = Math.min(opts.perPage, @MAX_PERPAGE)

    if req.query.order and @sortableFields
      opts.order = @getListOrder(req) or opts.order

    if @filterableFields
      opts.filters = @getListFilters(req)

    opts

  getListOrder: (req) ->
    { order } = req.query
    field = if _.startsWith(order, '-') then order.substr(1) else order

    return order if field in @sortableFields

  getListFilters: (req) ->
    filters = {}

    for key, value of query when _.startsWith(key, '_')
      field = key.substr(1)
      [field, operation] = field.split('__') if field.indexOf('__')

      continue unless field in @filterableFields

      if operation is 'contains'
        value = $regex: value, $options: 'i'

      filters[field] = value
