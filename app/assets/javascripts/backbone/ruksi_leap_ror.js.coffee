#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.RuksiLeapRor =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  View: Backbone.View.extend({
    remove: ->
      Backbone.View.prototype.remove.apply(this, arguments)
      @trigger('remove')
  })