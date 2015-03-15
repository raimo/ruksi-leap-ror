RuksiLeapRor.Views.Recordings ||= {}

class RuksiLeapRor.Views.Recordings.RecordingView extends RuksiLeapRor.View

  template: JST['backbone/templates/recordings/recording']

  events:
    'click': ->
      Backbone.history.navigate "/#{@model.id}", true
    'click .js-destroy' : 'destroy'

  tagName: 'tr'

  destroy: () ->
    @model.destroy()
    this.remove()
    return false

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
