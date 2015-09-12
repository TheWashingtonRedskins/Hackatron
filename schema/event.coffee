# ███████╗██╗   ██╗███████╗███╗   ██╗████████╗
# ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝
# █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║
# ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║
# ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║
# ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝
#
# Schema for a single event (hackathon) in the system.
#
# This is file #5 created at 1:50AM, the first day of Mhacks.
#  -> Check out Free for Fee. It makes no sense at all.

# Manually make the _id for this one.
# _id = mhacks for example. this is so URLs look nice
EventSchema = new SimpleSchema
  name:
    label: "Title of the event."
    type: String
  start:
    label: "Start date."
    type: Date
  end:
    label: "End date."
    type: Date
  website:
    label: "URL to the website."
    type: String
  icon:
    label: "Icon URL."
    type: String
    # Shouldn't be but ok
    optional: true

@Events = new Mongo.Collection "events"
Events.attachSchema EventSchema
