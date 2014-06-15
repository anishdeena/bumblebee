App.Views.Public ||= {}

class App.Views.Public.SplashView extends Backbone.View
  
  
  constructor: (options) ->
    super(options)
    @render_element = options.render_element
    @is_rendered = false
    @ENTITY_TYPE_RECOMMENDATION = "15"
    @ENTITY_TYPE_QUESTION = "14"
    @ENTITY_TYPE_COMMENT = "16"
    @ENTITY_TYPE_BUSINESS= "2"
    @ENTITY_TYPE_LOCATION = "3"
    @ENTITY_TYPE_CATEGORY = "4"
    @ENTITY_TYPE_USER= "5"
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
    reqAnim = new countUp("request_count", 0, activity_params.request_count, 0, 0.5)
    recAnim = new countUp("recommendation_count", 0, activity_params.recommendation_count, 0, 1.5)
    comAnim = new countUp("comment_count", 0, activity_params.comment_count, 0, 1.0)
    busAnim = new countUp("business_count", 0, activity_params.business_count, 0, 1.0)
    usrAnim = new countUp("user_count", 0, activity_params.user_count, 0, 1.0)
    catAnim = new countUp("category_count", 0, activity_params.category_count, 0, 1.0)
    locAnim = new countUp("location_count", 0, activity_params.location_count, 0, 1.0)
    reqAnim.start()
    recAnim.start()
    comAnim.start()
    busAnim.start()
    usrAnim.start()
    catAnim.start()
    locAnim.start()
    
  updateCount: (count_params) ->
    if count_params.type == @ENTITY_TYPE_BUSINESS
      $("#business_count").html(count_params.count)
    if count_params.type == @ENTITY_TYPE_USER
      $("#user_count").html(count_params.count)
    if count_params.type == @ENTITY_TYPE_CATEGORY
      $("#category_count").html(count_params.count)
    if count_params.type == @ENTITY_TYPE_LOCATION
      $("#location_count").html(count_params.count)           
    
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
    
    @socket.on('count',
      (count_params) =>
        @updateCount(count_params)        
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
    @socket = io.connect("http://ec2-54-87-19-224.compute-1.amazonaws.com:3001")
    @content = $("#content")
    $("abbr.timeago").timeago()
    @setupSocketClient()
    #@enableTimeUpdate()
    return this
