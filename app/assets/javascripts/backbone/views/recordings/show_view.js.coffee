RuksiLeapRor.Views.Recordings ||= {}

class RuksiLeapRor.Views.Recordings.ShowView extends RuksiLeapRor.View

  template: JST['backbone/templates/recordings/show']

  events:
    'click .js-play' : 'togglePlay'
    'click .js-stop' : 'togglePlay'

  initialize: () ->
    if @isPlaying()
      @stopPlaying()

  render: ->
    @$el.html(@template(
      _.extend(
        @model.attributes,
        {isPlaying: @isPlaying()}, hasContent: @hasContent())
      )
    )
    return this

  togglePlay: ->
    if @isPlaying()
      @stopPlaying()
      @render()
      return
    player = window.getPlayer()
    unless player.state == 'recording'
      player.record()
    frameData = JSON.parse @model.get('content')
    player.recording.setFrames(frameData)
    player.setFrameIndex(0)
    player.play()
    @render()

  isPlaying: ->
    window.getPlayer().state == 'playing'

  stopPlaying: ->
    player = window.getPlayer()
    player.stop()

  hasContent: ->
    content = @model.get('content')
    _.isString(content) && content.length > 2 # empty recording is []