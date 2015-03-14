RuksiLeapRor.Views.Recordings ||= {}

class RuksiLeapRor.Views.Recordings.IndexView extends Backbone.View

  template: JST['backbone/templates/recordings/index']

  initialize: () ->
    @options.recordings.bind('reset', @addAll)

  addAll: () =>
    @options.recordings.each(@addOne)

  addOne: (recording) =>
    view = new RuksiLeapRor.Views.Recordings.RecordingView({model : recording})
    @$('tbody').append(view.render().el)

  render: =>
    @$el.html(@template(recordings: @options.recordings.toJSON() ))
    @addAll()
    return this
