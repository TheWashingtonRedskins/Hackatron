# ██████╗  ██████╗ ██╗   ██╗████████╗███████╗███████╗
# ██╔══██╗██╔═══██╗██║   ██║╚══██╔══╝██╔════╝██╔════╝
# ██████╔╝██║   ██║██║   ██║   ██║   █████╗  ███████╗
# ██╔══██╗██║   ██║██║   ██║   ██║   ██╔══╝  ╚════██║ # ██║  ██║╚██████╔╝╚██████╔╝   ██║   ███████╗███████║
#
# Configure routes in iron-router.
#
# This is file #3 created at 1:24AM, the first day of MHacks.
#  -> Some kids are playing mario-kart, and are very loud. At 1:30Am.

# Global configuration.
Router.configure
  layoutTemplate: 'ApplicationLayout'
  waitOn: ->
    return [] unless Meteor.isClient
    Meteor.subscribe "events"

Router.onBeforeAction ->
  unless currentEventValid()
    return @render "events"

  # TODO: check if URL actually needs auth
  unless Meteor.userId()?
    @render 'Login'
  else
    @next()
  return

# Check if the event still exists and if not redirect
# usage: return if eventRedirect @
currentEventValid = ->
  selEvent = Session.get "selectedEvent"
  if selEvent?
    now = new Date().getTime()
    eve = Events.findOne {_id: selEvent}
    if eve? and eve.start.getTime() < now and eve.end.getTime() > now
      return true
  events = Events.find().fetch()
  if events.length is 1
    Session.set "selectedEvent", events[0]._id
    return true
  Session.set "selectedEvent", null
  false

Router.route '/',
  action: ->
    @redirect "/requests"

Router.route "/requests",
  action: ->
    @render "requests"
