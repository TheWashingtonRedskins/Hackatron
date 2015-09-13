Template.activeRequest.onRendered ->
  step1 = 500
  step2 = 500
  step3 = 500
  reqStep1 = 600
  reqStep2 = 800
  reqClosingStep1 = 500
  reqClosingStep2 = 500

  card = $(@find ".cardContainer")
  data = Template.currentData()

  setTimeout =>
    $card = $(@find ".card")
    cardTop = $card.position().top
    $card.addClass 'flip-step1 active'
    setTimeout (->
      $card.addClass 'flip-step2'
      setTimeout (->
        $card.addClass 'flip-step3'
        setTimeout ->
          minus = $(".card__part-4").height()+31
          thing = $card.parent()
          oh = thing.height()
          console.log oh
          thing.css 'height', 'calc(100% - '+minus+'px)'
          h = thing.height()
          thing.css 'height', oh
          thing.animate { height: h }, {duration: 500, easing: "linear"}
          setTimeout ->
            thing.css 'height', 'calc(100% - '+minus+'px)'
          , 550
        , step3 * 1.05
      ), step2 * 0.5
    ), step1 * 0.65
  , 50

Template.activeRequest.helpers
  tagsFormatted: ->
    @tags.join(", ").toProperCase()
  idShort: ->
    @_id.substr(0, 4).toLowerCase()
  timeAgo: (arg)->
    Session.get("1sec")
    moment(@created).fromNow(arg)
  requestor: ->
    Meteor.users.findOne {_id: @uid}
  reqDiff: ->
    ERequestDifficultyN[@difficulty]
  userAvatar: (uid)->
    console.log uid
    u = Meteor.users.findOne({_id: uid[0]})
    return "" unless u?
    return u.profile.avatar
  userName: (uid)->
    u = Meteor.users.findOne({_id: uid[0]})
    return "" unless u?
    return u.profile.name

Template.activeActionButton.helpers
  isMine: ->
    uid = Meteor.userId()
    @uid is uid

Template.activeActionButton.events
  "click .cancelBtn": ->
    Meteor.call "cancelRequest", (err)->
      if err?
        sweetAlert
          title: "Can't Cancel"
          text: err.reason
          type: "error"
