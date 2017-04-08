Phaser = require 'Phaser'
assert = require '../utils/assert.coffee'

Track        = require '../tracks/track.coffee'
TrackManager = require '../tracks/track-manager.coffee'
TrackManagerFlat = require '../tracks/track-manager-flat.coffee'
TrackManagerCircle = require '../tracks/track-manager-circle.coffee'

CollisionManager = require '../collisions/collision-manager.coffee'

config       = require '../config/config.coffee'

colors      = require '../utils/colors.coffee'
debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

configPlayer = require './config-player.coffee'

class Player
  @SPEED_MIN = 0
  @SPEED_MAX = Infinity
  @i = 0
  constructor: (game, track, textureName, speed) ->
    debug 'Constructor...', @, 'info', 30, debugThemes.Player

    assert game?, "Phaser game does not exist"
    assert textureName?, "Player has no texture"

    assert speed >= Player.SPEED_MIN, "Speed is too low"
    assert speed <= Player.SPEED_MAX, "Speed is too high"

    assert track instanceof Track, "No track"

    # Args
    @game = game
    @track = track
    @textureName = textureName
    @speed = speed

    # Sprite
    @sprite = @game.add.sprite @game.world.centerX, @game.world.centerY, textureName
    @sprite.anchor.setTo 0.5, 0.75
    @sprite.animations.add 'run', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], @speed, true
    @sprite.animations.play 'run'

    # Position and rotation
    @setPositionFromTrack()
    @setRotationFromTrack()

    # Input
    @leftKey = @game.input.keyboard.addKey configPlayer.leftKey
    @leftKey.onDown.add @moveLeft, @
    @rightKey = @game.input.keyboard.addKey configPlayer.rightKey
    @rightKey.onDown.add @moveRight, @

    # Collision Manager
    @collisionManager = new CollisionManager @game, @

  setPositionFromTrack: () ->
    @coords = @track.getCoordsInMidLine 0.9
    @sprite.x = @coords.x
    @sprite.y = @coords.y


  setRotationFromTrack: () ->
    @sprite.angle = @track.getPlayerRotation()


  setScaleFromTrack: () ->
    @sprite.scale.setTo 0.9, 0.9

  updateProperties: () ->
    @setPositionFromTrack()
    @setRotationFromTrack()
    @setScaleFromTrack()

  moveLeft: ->
    debug 'moveLeft...', @, 'info', 30, debugThemes.Player
    @move -1

  moveRight: ->
    debug 'moveRight...', @, 'info', 30, debugThemes.Player
    @move 1


  move: (step) ->
    debug 'move...', @, 'info', 30, debugThemes.Player

    numNewTrack = @track.num + step

    # Check limits of TrackManagerFlat
    if @track.trackManager instanceof TrackManagerFlat
      if numNewTrack < 0 or numNewTrack >= @track.trackManager.nb
        return

    @track = @track.trackManager.tracks[numNewTrack]
    @setPositionFromTrack()
    @setRotationFromTrack()


  getBottomBorderHeight: ->
    # TODO manage sprite anchor
    return @sprite.y


  toString: ->
    debug 'ToString...', @, 'info', 30, debugThemes.Tracks

    return """
    Player :
      - speed        : #{@speed}
      - texture name : #{textureName}
    """

module.exports = Player
