(function() {
  var _base,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  (_base = App.Views).Core || (_base.Core = {});

  App.Views.Core.HomeView = (function(_super) {
    __extends(HomeView, _super);

    function HomeView(options) {
      HomeView.__super__.constructor.call(this, options);
      this.render_element = options.render_element;
      this.is_rendered = false;
      this.render();
    }

    HomeView.prototype.render = function() {
      $(this.el).html("<h1> Home! </h1>");
      $("#" + this.render_element).html(this.el);
      return this;
    };

    return HomeView;

  })(Backbone.View);

}).call(this);
