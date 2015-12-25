_ = require('lodash')
Q = require('q')
Controller = require('./controller')


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
  filterableFields: null
  sortableFields: null
  listFields: null
  listJoins: null

  router: ->
    throw new Error('Actions are not specified') unless @actions
    throw new Error('List fields are not specified') if not @listFields and 'list' in @actions

    baseUrl = "#{@apiPrefix}#{@urlPrefix}"

    @_router.use(baseUrl, @middlewares.adminAuth) if @adminAuth
    @_router.use(baseUrl, @middlewares.adminRole(@adminRoles)) if @adminRoles

    for action in @actions
      handlers = []
      handler = @[action]

      method = handler.type or 'get'
      handlerUrl = handler.url or ''
      url = "#{baseUrl}#{handlerUrl}"

      handlers.push(@middlewares.adminAuth) if handler.adminAuth
      handlers.push(@middlewares.adminRole(handler.adminRoles)) if handler.adminRoles
      handlers.push(@getModelItem) if handlerUrl.indexOf('/:id') >= 0
      handlers.push(handler)

      @_handler(method, url, handlers...)


  # Get model
  get: (req, res, next) ->
    if @joins
      opts = (path: name, select: fields.join(' ') for name, fields of @joins)

      @Model.populate req.modelItem, opts, (err, doc) =>
        return next(err) if err
        @mapDoc?(req, res, next, doc) or res.json(doc.toJSON())
    else
      @mapDoc?(req, res, next, req.modelItem) or res.json(req.modelItem.toJSON())

  ModelController::get.url = '/:id'


  # Create model
  create: (req, res, next) ->
    model = new @Model(req.body)

    model.validate (err) =>
      return @error(res, err.errors) if err

      model.save (err, doc) =>
        return next(err) if err
        req.modelItem = doc
        @get(req, res, next)

  ModelController::create.type = 'post'


  # Delete model
  delete: (req, res, next) ->
    @Model.remove req.modelItem, (err) =>
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

      @mapList?(req, res, data) or res.json(data)

    .fail (err) =>
      next(err)


  # Middlewares
  getModelItem: (req, res, next) ->
    filter = {}
    filter[@keyField] = req.params.id

    @Model.findOne(filter).exec (err, doc) =>
      return next(err) if err
      return @notFound(res) unless doc

      req.modelItem = doc
      next()


  # Helpers
  populateQuery: (query, joins) ->
    for name, fields of joins
      query.populate(name, fields.join(' '))

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
