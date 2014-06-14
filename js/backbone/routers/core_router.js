(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.Routers.CoreRouter = (function(_super) {
    __extends(CoreRouter, _super);

    function CoreRouter() {
      return CoreRouter.__super__.constructor.apply(this, arguments);
    }

    CoreRouter.prototype.routes = {
      "home": "Home"
    };

    CoreRouter.prototype.Home = function() {
      return this.view = new App.Views.Core.HomeView({
        render_element: "base"
      });
    };

    return CoreRouter;

  })(Backbone.Router);

}).call(this);
