class RuksiLeapRor.Routers.RecordingsRouter extends Backbone.Router

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
    @view = new RuksiLeapRor.Views.Recordings.NewView(collection: @recordings)
    $("#recordings").html(@view.render().el)

  index: ->
    @view = new RuksiLeapRor.Views.Recordings.IndexView(recordings: @recordings)
    $("#recordings").html(@view.render().el)

  show: (id) ->
    recording = @recordings.get(id)
    @view = new RuksiLeapRor.Views.Recordings.ShowView(model: recording)
    $("#recordings").html(@view.render().el)

  edit: (id) ->
    recording = @recordings.get(id)
    @view = new RuksiLeapRor.Views.Recordings.EditView(model: recording)
    $("#recordings").html(@view.render().el)
