RuksiLeapRor.Views.Recordings ||= {}

class RuksiLeapRor.Views.Recordings.EditView extends Backbone.View

  template: JST["backbone/templates/recordings/edit"]

  events:
    "submit #edit-recording": "update"

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success: (recording) =>
        @model = recording
        window.location.hash = "/#{@model.id}"
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
