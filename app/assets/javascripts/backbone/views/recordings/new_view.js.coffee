RuksiLeapRor.Views.Recordings ||= {}

class RuksiLeapRor.Views.Recordings.NewView extends RuksiLeapRor.View

  template: JST['backbone/templates/recordings/new']

  events:
    'submit #new-recording': 'save'

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind('change:errors', () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset('errors')

    @collection.create(@model.toJSON(),
      success: (recording) =>
        @model = recording
        window.location.hash = "/#{@model.id}"

      error: (recording, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$('form').backboneLink(@model)

    return this
