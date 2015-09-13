# ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗
# ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝
# █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗
# ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║
# ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║
# ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝
#
# Render the page to select the event.
#
# This is file #? created at 3:44AM, the first day of Mhacks.
#  -> Linus Torvalds is really smart. SHA1 hash!

# oh god
# Template.events.events

Template.events.helpers
  "events": ->
    # TODO: filter for date
    Events.find()

Template.eventButton.events
  "click .cta_button": ->
    Session.set("selectedEvent", @_id)
    Meteor.call "setCurrentEvent", @_id, =>
      console.log "changed event to #{@_id}"
    Router.go "/"
