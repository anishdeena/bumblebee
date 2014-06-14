(function() {
  var _base,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  (_base = App.Views).Public || (_base.Public = {});

  App.Views.Public.SplashView = (function(_super) {
    __extends(SplashView, _super);

    function SplashView(options) {
      SplashView.__super__.constructor.call(this, options);
      this.render_element = options.render_element;
      this.is_rendered = false;
      this.ENTITY_TYPE_RECOMMENDATION = "15";
      this.ENTITY_TYPE_QUESTION = "14";
      this.ENTITY_TYPE_COMMENT = "16";
      this.MAX_SIZE = 15;
      this.count = 0;
      this.activities_container = [];
      this.render();
    }

    SplashView.prototype.constructCard = function(card_params) {
      var card, template;
      if (card_params.activity_type === this.ENTITY_TYPE_QUESTION) {
        $("#request_count").html(card_params.count);
        template = _.template($("#template_feed_card_request").html());
        card = template({
          card_params: card_params
        });
        return card;
      }
      if (card_params.activity_type === this.ENTITY_TYPE_RECOMMENDATION) {
        $("#recommendation_count").html(card_params.count);
        template = _.template($("#template_feed_card_recommendation").html());
        card = template({
          card_params: card_params
        });
        return card;
      }
      if (card_params.activity_type === this.ENTITY_TYPE_COMMENT) {
        $("#comment_count").html(card_params.count);
        template = _.template($("#template_feed_card_comment").html());
        card = template({
          card_params: card_params
        });
        return card;
      }
    };

    SplashView.prototype.updateAllActivityCount = function(activity_params) {
      var comAnim, recAnim, reqAnim;
      reqAnim = new countUp("request_count", 0, activity_params.request_count, 0, 1.5);
      recAnim = new countUp("recommendation_count", 0, activity_params.recommendation_count, 0, 1.5);
      comAnim = new countUp("comment_count", 0, activity_params.comment_count, 0, 1.5);
      reqAnim.start();
      recAnim.start();
      return comAnim.start();
    };

    SplashView.prototype.setupSocketClient = function() {
      this.socket.on('history', (function(_this) {
        return function(activity_params) {
          var activities, card, i;
          activities = activity_params.activities;
          _this.updateAllActivityCount(activity_params);
          i = 0;
          while (i < activities.length) {
            _this.activities_container[_this.count % _this.MAX_SIZE] = activities[i];
            _this.count = _this.count + 1;
            i = i + 1;
            card = _this.constructCard(activities[i - 1]);
            $(_this.content).prepend(card);
          }
          return _this.enableTimeUpdate();
        };
      })(this));
      return this.socket.on('feed', (function(_this) {
        return function(card_params) {
          var card;
          _this.activities_container[_this.count % _this.MAX_SIZE] = card_params;
          _this.count = _this.count + 1;
          card = _this.constructCard(card_params);
          return $(_this.content).prepend(card);
        };
      })(this));
    };

    SplashView.prototype.updateTime = function() {
      return $(".card_timestamp").each(function() {
        var timestamp;
        timestamp = $(this).attr("data_time");
        return $(this).text($.timeago(timestamp));
      });
    };

    SplashView.prototype.enableTimeUpdate = function() {
      return setInterval((function(_this) {
        return function() {
          return _this.updateTime();
        };
      })(this), 60000);
    };

    SplashView.prototype.render = function() {
      var template;
      $('body').prepend("<script src='/socket.io/socket.io.js'></script>");
      template = _.template($("#template_feed_main").html());
      $(this.el).append(template());
      $("#" + this.render_element).html(this.el);
      this.socket = io.connect("http://localhost:3001");
      this.content = $("#content");
      $("abbr.timeago").timeago();
      this.setupSocketClient();
      return this;
    };

    return SplashView;

  })(Backbone.View);

}).call(this);
