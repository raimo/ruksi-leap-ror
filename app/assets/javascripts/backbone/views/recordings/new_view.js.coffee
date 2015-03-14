RuksiLeapRor.Views.Recordings ||= {}

class RuksiLeapRor.Views.Recordings.NewView extends RuksiLeapRor.View

  template: JST['backbone/templates/recordings/new']

  _isRecording: false

  events:
    'submit #new-recording': 'save'
    'click .js-record-start': 'startRecording'
    'click .js-record-stop': 'stopRecording'
    'click .js-play-start': 'startPlaying'
    'click .js-play-stop': ->
      @stopPlaying()
      @render()

  constructor: (options) ->
    super(options)
    @model = new @collection.model()
    @model.bind('change:errors', () =>
      @render()
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
    @$el.html(@template(
        _.extend(
          @model.attributes,
          {isRecording: @isRecording(), isPlaying: @isPlaying()})
      )
    )
    this.$('form').backboneLink(@model)
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