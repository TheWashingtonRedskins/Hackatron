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
Meteor.publishComposite "requests",
  find: ->
    Requests.find()
  children: [
    {
      find: (request)->
        ids = _.clone request.responders
        ids.push request.uid
        Meteor.users.find {_id: {$in: ids}}, {fields: {profile: 1}}
    }
  ]
