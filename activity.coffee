module.exports = () ->
  
  class activity
    
    constructor: () ->
      @MAX_SIZE = 5
      @count = 0
      @activities = []
      @ENTITY_TYPE_QUESTION = "14"
      @ENTITY_TYPE_RECOMMENDATION = "15"
      @ENTITY_TYPE_COMMENT = "16"
      @request_count = 0
      @recommendation_count = 0
      @comment_count = 0     

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
      
    getActivities: () ->
      return {activities: @activities, request_count: @request_count, recommendation_count: @recommendation_count, comment_count: @comment_count}
