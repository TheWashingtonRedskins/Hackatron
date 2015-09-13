String::toProperCase = ->
  @replace /\w\S*/g, (txt) ->
    txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()

@getActiveRequest = (uid)->
  return if Meteor.isServer and !uid?
  if !uid?
    user = Meteor.user()
    return if !user?
    uid = user._id
  Requests.findOne({state: {$lt: 2}, $or: [{uid: uid}, {responders: uid}]})
