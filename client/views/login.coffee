# ██╗      ██████╗  ██████╗ ██╗███╗   ██╗
# ██║     ██╔═══██╗██╔════╝ ██║████╗  ██║
# ██║     ██║   ██║██║  ███╗██║██╔██╗ ██║
# ██║     ██║   ██║██║   ██║██║██║╚██╗██║
# ███████╗╚██████╔╝╚██████╔╝██║██║ ╚████║
# ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝╚═╝  ╚═══╝
#
# Code to render the login page.
#
# This is file #? created at 4:02AM, the first day of MHacks.
#  -> Gabe Newell is heavy breathing cuz he's nervous duh

Template.login.helpers
  "services": ->
    [
      {
        icon: "facebook"
        login: (cb)->
          Meteor.loginWithFacebook({}, cb)
      }
      {
        icon: "github"
        login: (cb)->
          Meteor.loginWithGithub({
            requestPermissions: ["user", "public_repo"]
          }, cb)
      }
      {
        service: "Google"
        icon: "google"
        login: (cb)->
          Meteor.loginWithGoogle({}, cb)
      }
    ]

Template.loginServiceButton.events
  "click .cta_button": ->
    @login (err)->
      return unless err?
      sweetAlert
        title: "Login Failure"
        text: err.message
        type: "error"
