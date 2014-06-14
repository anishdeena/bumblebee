module.exports = (app, io, activity) ->
  
  app.get('/home', (req, res)->
    res.send("You have hit home!")
  )

  app.get('/about', (req, res)->
    res.send("You have hit about!")
  )
  
  app.post('/feed', (req, res) ->
    activity.saveActivity(req.body)
    res.send(200, req.body)
    io.sockets.emit("feed", req.body)  
  )