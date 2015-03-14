RuksiLeapRor.Views.Recordings ||= {}

class RuksiLeapRor.Views.Recordings.ShowView extends Backbone.View

  template: JST['backbone/templates/recordings/show']

  events:
    'click .js-play' : 'play'

  render: ->
    @$el.html(@template(@model.toJSON()))
    # TODO: remove listener on view remove to replace removeAllListeners
    window.controller
      .removeAllListeners('playback.play')
      .on('playback.play', ->
        console.log 'playing'
      )
    return this

  play: ->
    console.log window.getPlayer()