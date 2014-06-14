class App.Routers.PublicRouter extends Backbone.Router
  #initialize: (options) ->
    #this.route(/^frilpone$/i, "frilpOne") #adding case insensitive route for frilpone page   
          
  routes:
    ".*"                  : "Splash"
    "about"               : "About"
  
  Splash:()->
    @view = new App.Views.Public.SplashView(render_element: "base")

  About:()->
    @view = new App.Views.Public.AboutView(render_element: "base")              
