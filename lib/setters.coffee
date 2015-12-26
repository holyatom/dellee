module.exports =
  objectId: (val) -> if val?._id? then val._id else val
  date: (val) -> new Date(val)
