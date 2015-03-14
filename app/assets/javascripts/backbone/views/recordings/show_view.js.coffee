RuksiLeapRor.Views.Recordings ||= {}

class RuksiLeapRor.Views.Recordings.ShowView extends Backbone.View

  template: JST["backbone/templates/recordings/show"]

  render: ->
    @$el.html(@template(@model.toJSON()))
    return this
