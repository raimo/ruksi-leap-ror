RuksiLeapRor.Views.Recordings ||= {}

class RuksiLeapRor.Views.Recordings.RecordingView extends Backbone.View

  template: JST["backbone/templates/recordings/recording"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()
    return false

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
