class RuksiLeapRor.Routers.RecordingsRouter extends Backbone.Router

  view: null

  initialize: (options) ->
    @recordings = new RuksiLeapRor.Collections.RecordingsCollection()
    @recordings.reset options.recordings

  routes:
    "new"      : "newRecording"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newRecording: ->
    if (@view)
      @view.remove()
    @view = new RuksiLeapRor.Views.Recordings.NewView(collection: @recordings)
    $("#recordings").html(@view.render().el)

  index: ->
    if (@view)
      @view.remove()
    @view = new RuksiLeapRor.Views.Recordings.IndexView(recordings: @recordings)
    $("#recordings").html(@view.render().el)

  show: (id) ->
    if (@view)
      @view.remove()
    recording = @recordings.get(id)
    @view = new RuksiLeapRor.Views.Recordings.ShowView(model: recording)
    $("#recordings").html(@view.render().el)

  edit: (id) ->
    if (@view)
      @view.remove()
    recording = @recordings.get(id)
    @view = new RuksiLeapRor.Views.Recordings.EditView(model: recording)
    $("#recordings").html(@view.render().el)
