Meteor.methods
  "cancelRequest": ->
    uid = @userId
    if !uid?
      throw new Meteor.Error "not-logged-in", "You are not signed in."
    req = getActiveRequest(uid)
    if !req?
      throw new Meteor.Error "cant-find", "Cannot find a active request."
    if req.state is 1
      throw new Meteor.Error "cant-cancel", "You cannot cancel once someone is coming to help."
    Requests.update {_id: req._id}, {$set: {state: 3}}, {validate: false}
  "setCurrentEvent": (eid)->
    uid = @userId
    if !uid?
      throw new Meteor.Error "not-logged-in", "You are not signed in."
    user = Meteor.users.findOne {_id: uid}
    if !user?
      throw new Meteor.Error "not-logged-in", "Can't find your user."
    eve = Events.findOne {_id: eid}
    if !eve?
      throw new Meteor.Error "invalid-event", "Unable to find that event."
    Meteor.users.update {_id: uid}, {$set: {"profile.event": eve}}
  "acceptRequest": (rid)->
    uid = @userId
    if !uid?
      throw new Meteor.Error "not-logged-in", "You are not signed in."
    user = Meteor.users.findOne {_id: uid}
    if !user?
      throw new Meteor.Error "not-logged-in", "Can't find your user."
    req = Requests.findOne {_id: rid, state: 0}
    if !req?
      throw new Meteor.Error "not-found", "That request doesn't exist or can't be accepted."
    areq = getActiveRequest(uid)
    if areq?
      throw new Meteor.Error "active", "You already have an active request."
    Requests.update {_id: rid}, {$set: {state: 1}, $push: {responders: uid}}
