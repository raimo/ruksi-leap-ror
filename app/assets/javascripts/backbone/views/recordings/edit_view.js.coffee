RuksiLeapRor.Views.Recordings ||= {}

class RuksiLeapRor.Views.Recordings.EditView extends RuksiLeapRor.View

  template: JST['backbone/templates/recordings/edit']

  _isRecording: false

  events:
    'submit #edit-recording': 'update'
    'click .js-cancel-edit': 'cancelEdit'
    'click .js-record-start': 'startRecording'
    'click .js-record-stop': 'stopRecording'
    'click .js-play-start': 'startPlaying'
    'click .js-play-stop': ->
      @stopPlaying()
      @render()

  initialize: ->
    @.on('remove', =>
      if @isPlaying()
        @stopPlaying()
    )
    @realModel = @model
    @model = @model.clone()
    @_isRecording = (window.getPlayer().state == 'recording')

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @realModel.set(@model.attributes);
    @realModel.save(null,
      success: (recording) =>
        @realModel = recording
        window.location.hash = "/#{@model.id}"
    )

  render: ->
    @$el.html(@template(
        _.extend(
          @model.attributes,
          {isRecording: @isRecording(), isPlaying: @isPlaying(), isPlayable: @model.isPlayable()})
      )
    )
    @$('form').backboneLink(@model)
    # TODO: remove listener on view remove to replace removeAllListeners
    window.controller
      .removeAllListeners('playback.recordingFinished')
      .on('playback.recordingFinished', =>
        player = window.getPlayer()
        str = JSON.stringify(player.recording.frameData)
        @model.set('content', str);
        @_isRecording = false
        player.stop()
        @render()
      )
    return this

  isRecording: ->
    @_isRecording

  isPlaying: ->
    window.getPlayer().state == 'playing'

  cancelEdit: ->
    window.location.hash = "/#{@model.id}"

  startRecording: ->
    player = window.getPlayer()
    if @isPlaying()
      player.stop()
    player.record()
    @_isRecording = true
    @render()

  stopRecording: ->
    if @isRecording()
      player = window.getPlayer()
      player.finishRecording()

  startPlaying: ->
    player = window.getPlayer()
    unless player.state == 'recording'
      player.record()
    frameData = JSON.parse @model.get('content')
    player.recording.setFrames(frameData)
    player.setFrameIndex(0)
    player.play()
    @render()

  stopPlaying: ->
    player = window.getPlayer()
    player.stop()
