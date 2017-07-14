express = require 'express'
app     = express()

engines          = require 'consolidate'

oldHandler = (req, res) -> 
  # console.log res
  # console.log req.url 
  url = req.url.replace(/^\/*/, '')
  res.redirect(302, url)
  

app.engine 'jade', engines.jade 
  

  
newHandler = (req, res) ->
  url = req.url.replace(/^\/*/, '')
  # console.log url
  
  # <meta http-equiv="refresh" content="0; url=mailto:john+leftiumbot@leftium.com?Subject=About%20John%27s%20Messenger%20Bot">
  content = '0; url=' + url
  addresses = url.match(/^[^?]*/) or "none"
  
  addresses = decodeURIComponent(url.replace(/^mailto:/, '').replace(/\?.*/, ''))
  
  title = "Send email to: " + addresses

  
  res.render 'redirect.jade',
    content: content
    addresses: addresses
    url: url
    title: title


app.get '/', (req, res) ->
  res.render('index.jade')

app.get '*', newHandler

# listen for requests :)
listener = app.listen process.env.PORT, () ->
  console.log "Your app is listening on port #{listener.address().port}"
