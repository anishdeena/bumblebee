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
      this.ENTITY_TYPE_BUSINESS = "2";
      this.ENTITY_TYPE_LOCATION = "3";
      this.ENTITY_TYPE_CATEGORY = "4";
      this.ENTITY_TYPE_USER = "5";
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
      var busAnim, catAnim, comAnim, locAnim, recAnim, reqAnim, usrAnim;
      reqAnim = new countUp("request_count", 0, activity_params.request_count, 0, 0.5);
      recAnim = new countUp("recommendation_count", 0, activity_params.recommendation_count, 0, 1.5);
      comAnim = new countUp("comment_count", 0, activity_params.comment_count, 0, 1.0);
      busAnim = new countUp("business_count", 0, activity_params.business_count, 0, 1.0);
      usrAnim = new countUp("user_count", 0, activity_params.user_count, 0, 1.0);
      catAnim = new countUp("category_count", 0, activity_params.category_count, 0, 1.0);
      locAnim = new countUp("location_count", 0, activity_params.location_count, 0, 1.0);
      reqAnim.start();
      recAnim.start();
      comAnim.start();
      busAnim.start();
      usrAnim.start();
      catAnim.start();
      return locAnim.start();
    };

    SplashView.prototype.updateCount = function(count_params) {
      if (count_params.type === this.ENTITY_TYPE_BUSINESS) {
        $("#business_count").html(count_params.count);
      }
      if (count_params.type === this.ENTITY_TYPE_USER) {
        $("#user_count").html(count_params.count);
      }
      if (count_params.type === this.ENTITY_TYPE_CATEGORY) {
        $("#category_count").html(count_params.count);
      }
      if (count_params.type === this.ENTITY_TYPE_LOCATION) {
        return $("#location_count").html(count_params.count);
      }
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
      this.socket.on('feed', (function(_this) {
        return function(card_params) {
          var card;
          _this.activities_container[_this.count % _this.MAX_SIZE] = card_params;
          _this.count = _this.count + 1;
          card = _this.constructCard(card_params);
          return $(_this.content).prepend(card);
        };
      })(this));
      return this.socket.on('count', (function(_this) {
        return function(count_params) {
          return _this.updateCount(count_params);
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
