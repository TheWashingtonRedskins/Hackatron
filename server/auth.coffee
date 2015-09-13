Accounts.onCreateUser (options, user)->
  console.log options
  console.log user
  user.profile = options.profile
  services = user.services
  if services.google?
    user.profile.avatar = services.google.picture
  if services.facebook?
    user.profile.avatar = "http://graph.facebook.com/"+user.services.facebook.id+"/picture/?type=large"
  if services.github?
    res = HTTP.get "https://api.github.com/users/#{services.github.username}", {headers: {"User-Agent": "paralin"}}
    user.profile.avatar = res.data.avatar_url
    user.services.github = _.extend user.services.github, res.data
    if user.services.github.name? and user.services.github.name.length > 4
      user.profile.name = services.github.name
    else
      user.profile.name = services.github.username
  user
