React = require('react')
vent = require('./vent')
{ Modal, Loading } = require('admin/components')


DELAY = 100
tid = null

vent.on 'route:before', ->
  tid = setTimeout(->
    tid = null
    Modal.show(<Loading />)
  , DELAY)

vent.on 'route:after', ->
  clearTimeout(tid) if tid
  Modal.close()
