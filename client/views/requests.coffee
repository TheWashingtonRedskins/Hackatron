
# ██████╗ ███████╗ ██████╗ ██╗   ██╗███████╗███████╗████████╗███████╗
# ██╔══██╗██╔════╝██╔═══██╗██║   ██║██╔════╝██╔════╝╚══██╔══╝██╔════╝
# ██████╔╝█████╗  ██║   ██║██║   ██║█████╗  ███████╗   ██║   ███████╗
# ██╔══██╗██╔══╝  ██║▄▄ ██║██║   ██║██╔══╝  ╚════██║   ██║   ╚════██║
# ██║  ██║███████╗╚██████╔╝╚██████╔╝███████╗███████║   ██║   ███████║
# ╚═╝  ╚═╝╚══════╝ ╚══▀▀═╝  ╚═════╝ ╚══════╝╚══════╝   ╚═╝   ╚══════╝
#
# Template helpers for the requests view.
#
# File #? created at 11:40AM on the first day of MHacks.
#  -> Still pretty hungry.

Template.requests.helpers
  "requests": ->
    Requests.find({state: 0})
  "giveHelp": ->
    Session.get "giveHelp"
  "hasRequests": ->
    Requests.find({state: 0}).count() > 0

Template.requests.events
  "click .switch-button .left": ->
    Session.set "giveHelp", false
  "click .switch-button .right": ->
    Session.set "giveHelp", true
  "click .acceptBtn": ->
    Meteor.call "acceptRequest", @_id, (err)->
      if err?
        sweetAlert
          title: "Can't Accept"
          text: err.reason
          type: "error"

Template.submitRequest.helpers
  userId: ->
    Meteor.userId()
  askToken: ->
    user = Meteor.user()
    return if !user?
    user.profile.asktoken
  typeUrl: ->
    user = Meteor.user()
    return null if !user?
    user.profile.typeform
Template.requestCard.helpers
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

Template.requestCard.onRendered ->
  animating = false
  step1 = 500
  step2 = 500
  step3 = 500
  reqStep1 = 600
  reqStep2 = 800
  reqClosingStep1 = 500
  reqClosingStep2 = 500
  $scrollCont = $('body')
  card = $(@find ".cardContainer")
  data = Template.currentData()

  if Meteor.userId() in data.responders
    animating = true
    $card = $(this).parents('.card')
    cardTop = $card.position().top
    scrollTopVal = cardTop - 30
    $card.addClass 'req-active1 map-active'
    setTimeout (->
      $scrollCont.animate { scrollTop: scrollTopVal }, reqStep1
      animating = false
    ), reqStep1

  card.on 'click', '.card:not(.active)', ->
    if animating
      return
    animating = true
    $card = $(this)
    $card.parent(".requestCardContainer").addClass "expandedContainer"
    cardTop = $card.position().top
    scrollTopVal = cardTop - 30
    $card.addClass 'flip-step1 active'
    $scrollCont.animate { scrollTop: scrollTopVal }, step1
    setTimeout (->
      $scrollCont.animate { scrollTop: scrollTopVal }, step2
      $card.addClass 'flip-step2'
      setTimeout (->
        $scrollCont.animate { scrollTop: scrollTopVal }, step3
        $card.addClass 'flip-step3'
        setTimeout (->
          animating = false
          return
        ), step3
        return
      ), step2 * 0.5
      return
    ), step1 * 0.65
    return
  card.on 'click', '.card:not(.req-active1) .card__header__close-btn', ->
    if animating
      return
    animating = true
    $card = $(this).parents('.card')
    $card.parent(".requestCardContainer").removeClass "expandedContainer"
    $card.removeClass 'flip-step3 active'
    setTimeout (->
      $card.removeClass 'flip-step2'
      setTimeout (->
        $card.removeClass 'flip-step1'
        setTimeout (->
          animating = false
          return
        ), step1
        return
      ), step2 * 0.65
      return
    ), step3 / 2
    return
  card.on 'click', '.card:not(.req-active1) .card__request-btn', (e) ->
    return if animating
    animating = true
    $card = $(this).parents('.card')
    cardTop = $card.position().top
    scrollTopVal = cardTop - 30
    $card.addClass 'req-active1 map-active'
    ###
    setTimeout (->
      $card.addClass 'req-active2'
      $scrollCont.animate { scrollTop: scrollTopVal }, reqStep2
      setTimeout (->
        animating = false
        return
      ), reqStep2
      return
    ), reqStep1
    ###
    setTimeout (->
      $scrollCont.animate { scrollTop: scrollTopVal }, reqStep1
      animating = false
    ), reqStep1
    return
  card.on 'click', '.card.req-active1 .card__header__close-btn, .card.req-active1 .card__request-btn', ->
    if animating
      return
    animating = true
    $card = $(this).parents('.card')
    $card.addClass 'req-closing1'
    setTimeout (->
      $card.addClass 'req-closing2'
      setTimeout (->
        $card.addClass 'no-transition hidden-hack'
        $card.css 'top'
        $card.removeClass 'req-closing2 req-closing1 req-active2 req-active1 map-active flip-step3 flip-step2 flip-step1 active'
        $card.css 'top'
        $card.removeClass 'no-transition hidden-hack'
        animating = false
        return
      ), reqClosingStep2
      return
    ), reqClosingStep1
    return
  return
