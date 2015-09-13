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

RequestSchema = new SimpleSchema
  # 0: Waiting for mentor
  # 1: Waiting for resolution
  # 2: Finished successfully
  # 3: Canceled
  state:
    label: "State of the request."
    type: Number
    min: 0
    max: 3
  finished:
    label: "Date request was finished/canceled."
    optional: true
    type: Date
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
    minCount: 1
    maxCount: 5
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
  description:
    label: "Short description of the problem."
    type: String
    min: 10
    max: 140
  phone:
    label: "Phone number for text message updates."
    type: String
    optional: true

@Requests = new Mongo.Collection "requests"
Requests.attachSchema RequestSchema
