RuksiLeapRor.Views.Recordings ||= {}

class RuksiLeapRor.Views.Recordings.EditView extends Backbone.View

  template: JST['backbone/templates/recordings/edit']

  events:
    'submit #edit-recording': 'update'
    'click .js-record-start': 'startRecording'
    'click .js-record-stop': 'stopRecording'

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
    @$('form').backboneLink(@model)
    # TODO: remove listener on view remove to replace removeAllListeners
    window.controller
      .removeAllListeners('playback.recordingFinished')
      .on('playback.recordingFinished', ->
        console.log 'recordingFinished'
        player = window.getPlayer()
        str = JSON.stringify(player.recording.frameData)
        $('#content').text(str).trigger('change');
      )
    return this

  close: ->
    console.log 'wat'

  startRecording: ->
    player = window.getPlayer()
    if player.state == 'recording'
      console.log 'already recording'
    else
      player.record()
      console.log 'recording'

  stopRecording: ->
    player = window.getPlayer()
    if player.recording
      player.finishRecording()