module.exports =
  objectId: (val) -> if val?._id? then val._id else val
  date: (val) ->
    val = new Date(val) unless val instanceof Date
    val
