import TwilioB from 'twilio';

from = process.env.TWILIO_FROM;
sid = process.env.TWILIO_SID;
token = process.env.TWILIO_TOKEN;

if (!from || !sid || !token || process.env.TWILIO_DISABLE) {
  console.log("Specify TWILIO_FROM, TWILIO_TOKEN, and TWILIO_SID, and NOT TWILIO_DISABLE for twilio support.");
  return;
}

Twilio = TwilioB(sid, token);

this.twilio = Twilio;
this.twilio_from = from;
