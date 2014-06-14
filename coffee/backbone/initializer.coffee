(($) ->
  window.JST = {}
  public_router = new App.Routers.PublicRouter()
  core_router = new App.Routers.CoreRouter()
  Backbone.history.start()
)()
