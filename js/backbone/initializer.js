(function() {
  (function($) {
    var core_router, public_router;
    window.JST = {};
    public_router = new App.Routers.PublicRouter();
    core_router = new App.Routers.CoreRouter();
    return Backbone.history.start();
  })();

}).call(this);
