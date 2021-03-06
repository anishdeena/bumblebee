(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.Routers.PublicRouter = (function(_super) {
    __extends(PublicRouter, _super);

    function PublicRouter() {
      return PublicRouter.__super__.constructor.apply(this, arguments);
    }

    PublicRouter.prototype.routes = {
      ".*": "Splash",
      "about": "About",
      "home": "Home"
    };

    PublicRouter.prototype.Splash = function() {
      return this.view = new App.Views.Public.SplashView({
        render_element: "base"
      });
    };

    PublicRouter.prototype.About = function() {
      return this.view = new App.Views.Public.AboutView({
        render_element: "base"
      });
    };

    PublicRouter.prototype.Home = function() {
      return this.view = new App.Views.Core.HomeView({
        render_element: "base"
      });
    };

    return PublicRouter;

  })(Backbone.Router);

}).call(this);
