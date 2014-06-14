App.Views.Public ||= {}

class App.Views.Public.SplashView extends Backbone.View
  
  
  constructor: (options) ->
    super(options)
    @render_element = options.render_element
    @is_rendered = false
    @ENTITY_TYPE_RECOMMENDATION = "15"
    @ENTITY_TYPE_QUESTION = "14"
    @ENTITY_TYPE_COMMENT = "16"
    @MAX_SIZE = 15
    @count = 0
    @activities_container = []
    @render()
    
  constructCard: (card_params) ->
    if card_params.activity_type == @ENTITY_TYPE_QUESTION
      $("#request_count").html(card_params.count)
      template = _.template($("#template_feed_card_request").html())
      card = template({card_params:card_params})
      return card
    if card_params.activity_type == @ENTITY_TYPE_RECOMMENDATION
      $("#recommendation_count").html(card_params.count)
      template = _.template($("#template_feed_card_recommendation").html())
      card = template({card_params:card_params})
      return card
    if card_params.activity_type == @ENTITY_TYPE_COMMENT
      $("#comment_count").html(card_params.count)
      template = _.template($("#template_feed_card_comment").html())
      card = template({card_params:card_params})
      return card
      
  updateAllActivityCount: (activity_params) ->
    #$("#request_count").html(activity_params.request_count)
    #$("#recommendation_count").html(activity_params.recommendation_count)
    #$("#comment_count").html(activity_params.comment_count)
    reqAnim = new countUp("request_count", 0, activity_params.request_count, 0, 1.5)
    recAnim = new countUp("recommendation_count", 0, activity_params.recommendation_count, 0, 1.5)
    comAnim = new countUp("comment_count", 0, activity_params.comment_count, 0, 1.5)
    reqAnim.start()
    recAnim.start()
    comAnim.start()
    
  setupSocketClient: () ->
    
    @socket.on('history',
      (activity_params) =>
        activities = activity_params.activities
        @updateAllActivityCount(activity_params)
        i = 0
        while i < activities.length 
            @activities_container[@count%@MAX_SIZE] = activities[i]
            @count = @count + 1
            i = i + 1
            card = @constructCard(activities[i-1])
            $(@content).prepend(card)
        @enableTimeUpdate()        
    )
    
    @socket.on('feed',
      (card_params) =>
        @activities_container[@count%@MAX_SIZE] = card_params
        @count = @count + 1     
        card = @constructCard(card_params)
        $(@content).prepend(card)        
    )
    
  updateTime: () ->
    $(".card_timestamp").each(
      () ->
        timestamp = $(this).attr("data_time")
        $(this).text($.timeago(timestamp))
    )
    
  enableTimeUpdate: () ->
    setInterval(
      () => 
        @updateTime()
      60000
    )
    #@updateTime()
    
  render: () ->
    $('body').prepend("<script src='/socket.io/socket.io.js'></script>")
    template = _.template($("#template_feed_main").html())
    $(@el).append(template())
    
    $("#" + @render_element).html(@el)
    @socket = io.connect("http://localhost:3001")
    @content = $("#content")
    $("abbr.timeago").timeago()
    @setupSocketClient()
    #@enableTimeUpdate()
    return this
