App.Views.Core ||= {}

class App.Views.Core.HomeView extends Backbone.View
  
  constructor: (options) ->
    super(options)
    @render_element = options.render_element
    @is_rendered = false
    @render()
    
  render: () ->
    $(@el).html("<h1> Home! </h1>")
    $("#" + @render_element).html(@el)
    return this
