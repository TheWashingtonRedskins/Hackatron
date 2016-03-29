Meteor.methods
  "completeRequest": ->
    uid = @userId
    if !uid?
      throw new Meteor.Error "not-logged-in", "You are not signed in."
    req = getActiveRequest(uid)
    if !req?
      throw new Meteor.Error "cant-cancel", "Can't find that request."
    unless uid in req.responders
      throw new Meteor.Error "cant-cancel", "You are not a mentor."
    Requests.update {_id: req._id}, {$set: {state: 2}}, {validate: false}
    if req.phone and req.phone.length > 2 and twilio?
      console.log "Sending completed SMS to #{req.phone}"
      twilio.sendMessage
        to: req.phone
        from: twilio_from
        body: "Your mentor has marked your request as complete. Have a great hackathon!"
      , (err, respData) ->
        if err?
          console.log err
  "cancelRequest": ->
    uid = @userId
    if !uid?
      throw new Meteor.Error "not-logged-in", "You are not signed in."
    req = getActiveRequest(uid)
    if !req?
      throw new Meteor.Error "cant-find", "Cannot find a active request."
    if req.state isnt 0
      throw new Meteor.Error "cant-cancel", "You cannot cancel once someone is coming to help."
    Requests.update {_id: req._id}, {$set: {state: 3}}, {validate: false}
    if req.phone and req.phone.length > 2 and twilio?
      console.log "Sending canceled SMS to #{req.phone}"
      twilio.sendMessage
        to: req.phone
        from: twilio_from
        body: "You've canceled your request. Have a great hackathon!"
      , (err, respData) ->
        if err?
          console.log err
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
    console.log "#{user.profile.name} accepted request #{req._id}"
    Requests.update {_id: rid}, {$set: {state: 1}, $push: {responders: uid}}
    if req.phone and req.phone.length > 2 and twilio?
      console.log "Sending accepted SMS to #{req.phone}"
      twilio.sendMessage
        to: req.phone
        from: twilio_from
        body: "#{user.profile.name} is on the way to answer your question!"
      , (err, respData) ->
        if err?
          console.log err
