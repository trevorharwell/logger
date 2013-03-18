app = require('express')()
eyes = require 'eyes'
# App Routes
app.get '/', (req, resp) ->
  resp.end 'Send logs to /log'
app.all '/log', (req, res) ->
  try
    message = JSON.parse(req.param('log'))
  catch e
    message = req.param('log') || ''
  eyes.inspect message
  # add JSONP support
  if req.query.callback
    res.type 'json'
    res.end "#{req.query.callback}(#{JSON.stringify({ valid: true})})"
  else
    res.end JSON.stringify({ valid: true })
# Listen
app.listen 3810, -> console.log 'Listening on port 3810'