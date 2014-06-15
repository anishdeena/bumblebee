module.exports = () ->
  
  class activity
    
    constructor: () ->
      @MAX_SIZE = 5
      @count = 0
      @activities = []
      @ENTITY_TYPE_QUESTION = "14"
      @ENTITY_TYPE_RECOMMENDATION = "15"
      @ENTITY_TYPE_COMMENT = "16"
      @ENTITY_TYPE_BUSINESS = "2"
      @ENTITY_TYPE_LOCATION = "3"
      @ENTITY_TYPE_CATEGORY = "4"
      @ENTITY_TYPE_USER = "5"
      @request_count = 0
      @recommendation_count = 0
      @comment_count = 0
      @entity_count_hash = {}     

    saveActivity: (activity) ->
      if activity.activity_type == @ENTITY_TYPE_QUESTION
        @request_count = activity.count
      if activity.activity_type == @ENTITY_TYPE_RECOMMENDATION
        @recommendation_count = activity.count
      if activity.activity_type == @ENTITY_TYPE_COMMENT
        @comment_count = activity.count
              
      if @count < 5
        @activities[@count%@MAX_SIZE] = activity
        @count++
      else
        i = 1
        while i < @MAX_SIZE
          @activities[i-1] = @activities[i]
          i++
        @activities[i-1] = activity
        
    saveCount: (count_params) ->
      if count_params.type == @ENTITY_TYPE_BUSINESS
        @entity_count_hash[@ENTITY_TYPE_BUSINESS] = count_params.count
      if count_params.type == @ENTITY_TYPE_USER
        @entity_count_hash[@ENTITY_TYPE_USER] = count_params.count
      if count_params.type == @ENTITY_TYPE_CATEGORY
        @entity_count_hash[@ENTITY_TYPE_CATEGORY] = count_params.count
      if count_params.type == @ENTITY_TYPE_LOCATION
        @entity_count_hash[@ENTITY_TYPE_LOCATION] = count_params.count               
        
      
    getActivities: () ->
      return {
        activities: @activities, 
        request_count: @request_count, 
        recommendation_count: @recommendation_count, 
        comment_count: @comment_count, 
        business_count: @entity_count_hash[@ENTITY_TYPE_BUSINESS],
        user_count: @entity_count_hash[@ENTITY_TYPE_USER],
        category_count: @entity_count_hash[@ENTITY_TYPE_CATEGORY],
        location_count: @entity_count_hash[@ENTITY_TYPE_LOCATION]
      }
