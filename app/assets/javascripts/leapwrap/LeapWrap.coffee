# Leap Singleton Wrapper
class LeapWrap

  ###
  Events:
  - recordingFinished
  ###

  # add events to the singleton
  _.extend @prototype, Backbone.Events

  # static function to get the singleton
  # and a few helpers for faster access
  @get: ->
    new LeapWrap()

  @getPlayer: ->
    wrap = new LeapWrap()
    wrap._controller.plugins['playback'].player

  @getController: ->
    wrap = new LeapWrap()
    wrap._controller

  @on: ->
    wrap = new LeapWrap()
    wrap.on.apply wrap, arguments

  @off: ->
    wrap = new LeapWrap()
    wrap.off.apply wrap, arguments

  constructor: ->

    if typeof LeapWrap._instance == 'object'
      return LeapWrap._instance

    Leap.loop({})
    .use('playback',
      overlay: false
      requiredProtocolVersion: 6
      autoPlay: true
      pauseOnHand: false
      loop: true
    )
    .use('riggedHand',
      materialOptions:
        color: new THREE.Color(0.5, 0, 0.75)
        blending: THREE.NoBlending
      boneColors: (boneMesh, leapHand) ->
        if (boneMesh.name.indexOf('Finger_1') == 0) || (boneMesh.name.indexOf('Finger_4') == 0)
          return {
            hue: 0.9,
            saturation: leapHand.pinchStrength
          }
        if (boneMesh.name.indexOf('Finger_2') == 0) || (boneMesh.name.indexOf('Finger_3') == 0)
          return {
            hue: 0.8,
            saturation: leapHand.pinchStrength
          }
    );

    @_controller = Leap.loopController

    # Fix camera position issue that happened when updating
    # from leap-0.6.0 to leap-0.6.4 and
    # from leap.rigged-hand-0.1.4 to leap.rigged-hand-0.1.7
    @_controller.plugins['riggedHand'].camera.position.set(0, 400, 500)

    @bindPlaybackEvents()

    LeapWrap._instance = @
    return LeapWrap._instance

  bindPlaybackEvents: ->
    @_controller.on('playback.recordingFinished', =>
      @trigger('recordingFinished');
    )

window.LeapWrap = LeapWrap
