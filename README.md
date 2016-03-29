Hackatron: the hackathon companion
==================================
<img src="https://raw.githubusercontent.com/TheWashingtonRedskins/Hackatron/bd01b6a236f2cfbef32f6c39239940b453fd5dd1/public/images/hackatron.png" width="200" alt="Hackatron logo">
<iframe width="420" height="315" src="https://www.youtube.com/embed/ZvAWzwYOl4o" frameborder="0" allowfullscreen></iframe>

Hackatron is a works-everywhere ultra-portable social app for helping
others and getting help at hackathon events.

## Inspiration
["Hackathon Mentorship Can Be Better."](https://medium.com/mhacks-v/hackathon-mentorship-can-be-better-425d9a190ce4) by Anuraag Yachamaneni. We agree, Anuraag.

## What it does
Hackatron is a web app built for helping programmers at hackathons. 
Hackers seeking help can submit a request in the app by filling out a brief form. 
Mentors see a list of all active help requests and can respond to help requests in a couple of clicks.

To verify users and retrieve profile information, Google, GitHub, and Facebook are available as login providers.

## How we built it
Hackatron is built using Meteor, which allows for easy use of plugins for OAuth and templating.

Users seeking help enter their information into the request form, from which the information is stored into a database (powered by MongoDB). 
That information is then displayed as a request in the "Help Out" pane.
Each request can be accepted by a mentor and completed when the asker is satisfied.

The platform is hosted on a dedicated server and deployed with Deis.
 

## What's next for Hackatron
We want to see Hackatron implemented at future hackathons to encourage further collaboration between competing teams and enhance learning.

To entice hackers to help, there will be a points and ranking system. 
Those asking good questions and those helping out will receive points. 
Additionally, those seeking help can place bounties on their requests, transferring points from the requester to the helper. 
Hackathons could further incite collaborative behavior between teams by offering a prize for the team or individual with the most points.

## Objectives / Tasks
Components (priority order):

  - [x] Request help
  - [x] View help requests
  - [x] Respond to help request / request lifecycle
  - [x] Store request history on an account / SSO
  - [ ] Point/reward system
  - [x] Animations / "sexiness factor" pass
  - [ ] Video display via odroid / RPI
  - [ ] Competitive elements (leaderboard, etc)
  - [ ] Integration with devpost / SSO / project "Acknoledgements" list
  - [ ] Testing / unit tests
  - [ ] Admin panel

## UI Design Goals
Clean, minimalistic, easy to use. 
No page reloads. 
Responsive. 
Any size screen.

## Thanks

 - Robot icon used in logo by [Jean-Phillippe Cabaroc](ihttps://thenounproject.com/cabaroc/), FR
 - Card layout inspired by [Nikolay Talanov](http://codepen.io/suez/)'s Delivery Card Animation
 - Loading animation from [Natalia Betancur](http://codepen.io/Nnatt/pen/RWWBKm)
 - Switch button from [Nicolas Lanthemann](http://codepen.io/vanderlanth/)
 - Social media buttons from [Dominic Magnifico](http://codepen.io/magnificode/)
 - Social media icons from [Font Awesome](http://fontawesome.io/)
