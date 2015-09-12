#  ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗
#  ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝
#  ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗
#  ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║
#  ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝
#   ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝
#
# Configure services on the server-side.
#
# This is file #2 created at 1:10AM, the first day of MHacks.
# -> We have eaten the pizza, it was pretty good.

# Called after two accounts are melded
meldDBCallback = (src_uid, dest_uid)->
  Requests.update {uid: src_uid}, {$set: {uid: dest_uid}}, {multi: true}

# Configure to meld accounts with same emails
AccountsMeld.configure
  askBeforeMeld: false
  meldDBCallback: meldDBCallback
