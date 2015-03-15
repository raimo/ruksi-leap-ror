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
    'change .js-import-json': (e) ->
      if e?.target?.files? && e.target.files.length > 0
        file = e.target.files[0]
        reader = new FileReader();
        self = @
        reader.onload = ->
          self.model.set 'content', @result
          self.render()
        reader.readAsText(file)

  constructor: (options) ->
    super(options)
    @.on('remove', =>
      LeapWrap.off 'recordingFinished', @saveRecording
      if @isPlaying()
        @stopPlaying()
    )
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
        Backbone.history.navigate "/#{@model.id}", true
      error: (recording, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    @$el.html(@template(
        _.extend(
          @model.attributes,
          {isRecording: @isRecording(), isPlaying: @isPlaying(), isPlayable: @model.isPlayable()})
      )
    )
    this.$('form').backboneLink(@model)
    LeapWrap.off 'recordingFinished', @saveRecording
    LeapWrap.on 'recordingFinished', @saveRecording
    return this

  saveRecording: =>
    player = LeapWrap.getPlayer()
    str = JSON.stringify(player.recording.frameData)
    @model.set('content', str);
    @_isRecording = false
    player.stop()
    @render()

  isRecording: ->
    @_isRecording

  isPlaying: ->
    LeapWrap.getPlayer().state == 'playing'

  startRecording: ->
    player = LeapWrap.getPlayer()
    if @isPlaying()
      player.stop()
    player.record()
    @_isRecording = true
    @render()

  stopRecording: ->
    if @isRecording()
      player = LeapWrap.getPlayer()
      player.finishRecording()

  startPlaying: ->
    player = LeapWrap.getPlayer()
    unless player.state == 'recording'
      player.record()
    if @model.isPlayable()
      frameData = JSON.parse @model.get('content')
      player.recording.setFrames(frameData)
      player.setFrameIndex(0)
      player.play()
      @render()

  stopPlaying: ->
    player = LeapWrap.getPlayer()
    player.stop()