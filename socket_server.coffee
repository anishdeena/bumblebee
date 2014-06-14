module.exports = (io, people, activity) ->
  io.sockets.on("connection",
    (socket) =>
      socket.emit("history", activity.getActivities())
      
      socket.on("join",
        (name) =>
          people[socket.id] = name
          socket.emit("update", "You have joined the chat session!")
          io.sockets.emit("update", name + " has joined the chat session!")
          io.sockets.emit("update-people", people)
        
      )
  
      socket.on("send",
        (data) =>
          io.sockets.emit("message", people[socket.id], data)
      )
  )
