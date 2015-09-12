# ██████╗ ███████╗ ██████╗ ██╗   ██╗███████╗███████╗████████╗
# ██╔══██╗██╔════╝██╔═══██╗██║   ██║██╔════╝██╔════╝╚══██╔══╝
# ██████╔╝█████╗  ██║   ██║██║   ██║█████╗  ███████╗   ██║
# ██╔══██╗██╔══╝  ██║▄▄ ██║██║   ██║██╔══╝  ╚════██║   ██║
# ██║  ██║███████╗╚██████╔╝╚██████╔╝███████╗███████║   ██║
# ╚═╝  ╚═╝╚══════╝ ╚══▀▀═╝  ╚═════╝ ╚══════╝╚══════╝   ╚═╝
#
# The schema for a single instance of a request for help in the system.
#
# This is file #1 created at 11:27AM, the first day (night, really) of MHacks.
# -> We are currently waiting for pizza.

Requests = new SimpleSchema
  created:
    label: "Date request was created."
    type: Date
    autoValue: ->
      if @isInsert
        return new Date
      else if @isUpsert
        return { $setOnInsert: new Date }
      else
        @unset()
      return
  location:
    label: "Text description of location."
    max: 30
    min: 2
    type: String
  event:
    label: "Event ID of which hackathon the request is at."
    type: String
  bounty:
    label: "Rating bounty to be handed out upon successful help."
    type: Number
    min: 0
    max: 10
  tags:
    label: "List of tags (technologies) the user is asking about."
    type: [String]
    min: 1
    max: 5
  uid:
    label: "The user who created the request."
    type: String
  responders:
    label: "User IDs of people who will respond to the request."
    type: [String]
    autoValue: ->
      if @isInsert
        return []
      else if @isUpsert
        return { $setOnInsert: [] }
      else
        @unset()
      return
  # Difficulty, see ERequestDifficulty
  difficulty:
    label: "User rated difficulty of the question."
    type: Number
    min: 0
    max: 3