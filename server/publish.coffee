# ██████╗ ██╗   ██╗██████╗ ██╗     ██╗███████╗██╗  ██╗
# ██╔══██╗██║   ██║██╔══██╗██║     ██║██╔════╝██║  ██║
# ██████╔╝██║   ██║██████╔╝██║     ██║███████╗███████║
# ██╔═══╝ ██║   ██║██╔══██╗██║     ██║╚════██║██╔══██║
# ██║     ╚██████╔╝██████╔╝███████╗██║███████║██║  ██║
# ╚═╝      ╚═════╝ ╚═════╝ ╚══════╝╚═╝╚══════╝╚═╝  ╚═╝
#
# Publish data to the clients.
#
# This is file #? created at 3:36AM, the first day of Mhacks.
#  -> People who use git can be as stupid as a git.
#  -> People who can't use git (the shell in particular) are idiots.

Meteor.publish "events", -> Events.find()
Meteor.publishComposite "requests", (eveid)->
  find: ->
    uid = @userId
    if eveid?
      Requests.find({event: eveid, $or: [{state: 0}, {uid: uid}, {responders: uid}]})
    else
      Requests.find({$or: [{state: 0}, {uid: uid}, {responders: uid}]})
  children: [
    {
      find: (request)->
        ids = _.clone(request.responders) || []
        ids.push request.uid
        Meteor.users.find {_id: {$in: ids}}, {fields: {profile: 1}}
    }
  ]
