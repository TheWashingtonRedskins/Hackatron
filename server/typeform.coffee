util = LibPhoneNumber.phoneUtil
format = LibPhoneNumber.PhoneNumberFormat
types = LibPhoneNumber.PhoneNumberType
getKey = (obj, val) ->
  for prop of obj
    if obj.hasOwnProperty(prop)
      if obj[prop] == val
        return prop
  return

parsePhone = (opts) ->
  parsedNumber = util.parse(opts.phone, opts.country or 'US')
  type = getKey(types, util.getNumberType(parsedNumber))
  {
    phone: util.format(parsedNumber, format.E164)
    isValid: util.isValidNumber(parsedNumber)
    type: type
  }


tagOptions = [
  "Meteor"
  "HTML"
  "CSS"
  "Javascript"
  "PHP"
  "Ruby"
  "Django"
  "Golang"
  "Python"
  "Mac OS"
  "Windows"
  "Linux"
  "Cloud"
  "Node"
  "Oculus"
]
tagOptionsTF = []
for opt in tagOptions
  tagOptionsTF.push
    label: opt

rurl = process.env.ROOT_URL
unless process.env.TYPEFORM_API?
  console.log "Specify TYPEFORM_API in the environment."
  process.exit 1

@generateTypeform = (uid, name)->
  form =
    title: "Request help"
    design_id: "XVkMvKCgLM"
    webhook_submit_url: rurl+"/api/tfhook"
    tags: [uid]
    fields: [
      {
        type: "statement"
        question: "Welcome, #{name}. Let's get started."
        description: "Mentors and your peers are ready to help."
      }
      {
        type: "long_text"
        question: "What is your question or problem?"
        required: true
        max_characters: 120
        tags: ["question"]
      }
      {
        type: "dropdown"
        question: "Generally, what kind of project are you making?"
        choices: [{label: "Web"}, {label: "iOS"}, {label: "Android"}, {label: "Desktop"}, {label: "Games/VR"}, {label: "Other"}]
        required: true
        tags: ["major_tags"]
      }
      {
        type: "multiple_choice"
        question: "Any specific technologies?"
        allow_multiple_selections: true
        choices: tagOptionsTF
        tags: ["tags"]
      }
      {
        type: "short_text"
        question: "Where are you?"
        required: true
        tags: ["location"]
      }
      {
        type: "short_text"
        question: "Enter your number if you'd like text updates."
        tags: ["number"]
      }
      {
        type: "rating"
        question: "How difficult would you say your problem is?"
        steps: 4
        shape: "lightbulb"
        tags: ["rating"]
      }
    ]

  tkey = process.env.TYPEFORM_API
  res = HTTP.post "https://api.typeform.io/v0.4/forms", {headers: {"X-API-TOKEN": tkey, "Content-Type": "application/json"}, data: form}
  self = _.findWhere res.data._links, {rel: "form_render"}
  return self.href

Router.route '/api/tfhook', ->
  @response.end "Thanks, typeform!"
  req = @request
  body = req.body
  if body.tags? and body.token? and body.uid? and body.uid? and body.answers? and body.tags.length is 1
    # Verify the user ID
    user = Meteor.users.findOne {"profile.typeformid": body.tags[0]}

    if !user?
      console.log "Unable to find typeform ID #{body.tags[0]}, giving up."
      return

    if (getActiveRequest user._id)?
      console.log "#{user.profile.name} already has an active request."
      return

    req =
      state: 0
      tags: []
      event: user.profile.event
      responders: []
      uid: user._id

    for answer in body.answers
      switch answer.tags[0]
        when "major_tags"
          req.tags.unshift answer.value.label
        when "tags"
          req.tags.push answer.value.label
        when "location"
          req.location = answer.value
        when "question"
          req.description = answer.value
        when "rating"
          req.difficulty = answer.value.amount-1
        when "number"
          # Parse the number
          number = answer.value
          continue if number.length is 0
          res = parsePhone
            country: "US"
            phone: number
          if res.isValid
            req.phone = res.phone
          else
            console.log "User specified invalid phone number: "+number

    console.log "Incoming question: #{JSON.stringify req}"
    Requests.insert req, {validate: false}
  else
    console.log "Invalid request: #{JSON.stringify body}"

, where: "server"
