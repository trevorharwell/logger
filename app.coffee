app = require('express')()
# App Routes
app.get '/', (req, resp) ->
  resp.end 'Send logs to /log'
app.all '/log', (req, res) ->
  try
    console.log JSON.parse(req.param('log'))
  catch e
    console.log req.param('log') || ''
  # add JSONP support
  if req.query.callback
    res.type 'json'
    res.end "#{req.query.callback}(#{JSON.stringify({ valid: true})})"
  else
    res.end JSON.stringify({ valid: true })
# Listen
app.listen 3810, -> console.log 'Listening on port 3810'