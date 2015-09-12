# ██████╗  ██████╗ ██╗   ██╗████████╗███████╗███████╗
# ██╔══██╗██╔═══██╗██║   ██║╚══██╔══╝██╔════╝██╔════╝
# ██████╔╝██║   ██║██║   ██║   ██║   █████╗  ███████╗
# ██╔══██╗██║   ██║██║   ██║   ██║   ██╔══╝  ╚════██║
# ██║  ██║╚██████╔╝╚██████╔╝   ██║   ███████╗███████║
#
# Configure routes in iron-router.
#
# This is file #3 created at 1:24AM, the first day of MHacks.
#  -> Some kids are playing mario-kart, and are very loud. At 1:30Am.

# Global configuration.
Router.configure
  layoutTemplate: 'ApplicationLayout'
  waitOn: ->
    return [] unless Meteor.client
    Meteor.subscribe "events"

# Check if the event still exists and if not redirect
# usage: return if eventRedirect @
eventRedirect = (ctx)->
  selEvent = Session.get "selectedEvent"
  if selEvent?
    now = new Date().getTime()
    eve = Events.findOne {_id: selEvent}
    if eve? and eve.start.getTime() < now and eve.end.getTime() > now
      return false
  ctx.redirect '/events'
  true

# Pick a logical place to go without any particular goal or context.
redirectLogically = ->
  # This already checks if the event is valid
  return if eventRedirect @
  user = Meteor.user()
  if !user?
    return

Router.route '/',
  action: redirectLogically

Router.route '/events',
  action: ->
    @render "events"
