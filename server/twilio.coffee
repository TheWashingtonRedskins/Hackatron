from = process.env.TWILIO_FROM
sid = process.env.TWILIO_SID
token = process.env.TWILIO_TOKEN

unless from? and sid? and token?
  console.log "Specify TWILIO_FROM, TWILIO_TOKEN, and TWILIO_SID for twilio support."
  return

@twilio = new Twilio
  from: from
  sid: sid
  token: token
