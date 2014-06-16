module.exports = (app, io, activity) ->
  
  app.get('/home', (req, res)->
    res.send("You have hit home!")
  )

  app.get('/about', (req, res)->
    res.send("You have hit about!")
  )
  
  app.get('/ping', (req, res)->
    res.send(200)
    io.sockets.emit("ping", "I got it!")
  )
  
  app.post('/feed', (req, res) ->
    #console.log("got data")
    activity.saveActivity(req.body)
    res.send(200, req.body)
    io.sockets.emit("feed", req.body)  
  )
  
  app.post('/count', (req, res) ->
    activity.saveCount(req.body)
    res.send(200, req.body)
    io.sockets.emit("count", req.body)  
  )