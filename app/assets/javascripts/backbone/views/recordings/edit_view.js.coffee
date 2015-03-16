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
    'change .js-import-json': (e) ->
      if e?.target?.files? && e.target.files.length > 0
        file = e.target.files[0]
        reader = new FileReader();
        self = @
        reader.onload = ->
          self.model.set 'content', LZString.compressToBase64(@result)
          self.render()
        reader.readAsText(file)

  initialize: ->
    @.on('remove', =>
      LeapWrap.off 'recordingFinished', @saveRecording
      if @isPlaying()
        @stopPlaying()
    )
    @realModel = @model
    @model = @model.clone()
    @_isRecording = (LeapWrap.getPlayer().state == 'recording')

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @realModel.set(@model.attributes);
    @realModel.save(null,
      success: (recording) =>
        @realModel = recording
        Backbone.history.navigate "/#{@model.id}", true
    )

  render: ->
    @$el.html(@template(
        _.extend(
          @model.attributes,
          {isRecording: @isRecording(), isPlaying: @isPlaying(), isPlayable: @model.isPlayable()})
      )
    )
    @$('form').backboneLink(@model)
    LeapWrap.off 'recordingFinished', @saveRecording
    LeapWrap.on 'recordingFinished', @saveRecording
    return this

  saveRecording: =>
    player = LeapWrap.getPlayer()
    str = JSON.stringify(player.recording.frameData)
    @model.set('content', LZString.compressToBase64(str));
    @_isRecording = false
    player.stop()
    @render()

  isRecording: ->
    @_isRecording

  isPlaying: ->
    LeapWrap.getPlayer().state == 'playing'

  cancelEdit: ->
    Backbone.history.navigate "/#{@model.id}", true

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
    frameData = JSON.parse LZString.decompressFromBase64(@model.get('content'))
    player.recording.setFrames(frameData)
    player.setFrameIndex(0)
    player.play()
    @render()

  stopPlaying: ->
    player = LeapWrap.getPlayer()
    player.stop()
