class App.Routers.CoreRouter extends Backbone.Router
  #initialize: (options) ->
    #this.route(/^frilpone$/i, "frilpOne") #adding case insensitive route for frilpone page   
          
  routes:
    "home"                : "Home"    
    
  Home:()->
    @view = new App.Views.Core.HomeView(render_element: "base")          
