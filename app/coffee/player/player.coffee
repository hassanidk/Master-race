Phaser = require 'Phaser'
assert = require 'assert'

Track        = require '../tracks/track.coffee'
TrackManager = require '../tracks/track-manager.coffee'

config       = require '../config/config.coffee'

colors      = require '../utils/colors.coffee'
debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

configPlayer = require './config-player.coffee'

class Player
  @SPEED_MIN = 0
  @SPEED_MAX = Infinity

  constructor: (game, track, textureName, speed) ->
    debug 'Constructor...', @, 'info', 30, debugThemes.Player

    assert game?, "Phaser game does not exist"
    assert textureName?, "Player has no texture"

    assert speed >= Player.SPEED_MIN, "Speed is too low"
    assert speed <= Player.SPEED_MAX, "Speed is too high"

    # TODO ASSERT TRACK

    @game = game

    @track = track

    @textureName = textureName
    @speed = speed

    @leftKey = @game.input.keyboard.addKey configPlayer.leftKey
    @leftKey.onDown.add @moveLeft, @

    @rightKey = @game.input.keyboard.addKey configPlayer.rightKey
    @rightKey.onDown.add @moveRight, @

    ###
    @sprite = @game.add.sprite x, y, textureName
    @sprite.anchor.setTo 0.5, 0.5
    @sprite.animations.add 'runRight', [0, 1, 2, 3, 4, 5, 6, 7], speed, true
    @sprite.animations.add 'runLeft', [8, 9, 10, 11, 12, 13, 14, 15], speed, true

    @sprite.animations.play 'runRight'
    ###


  moveLeft: ->
    debug 'moveLeft...', @, 'info', 30, debugThemes.Player
    undefined


  moveRight: ->
    debug 'moveRight...', @, 'info', 30, debugThemes.Player
    undefined


  getBottomBorderHeight: ->
    # TODO
    undefined


  toString: ->
    debug 'ToString...', @, 'info', 30, debugThemes.Tracks

    return """
    Player :
      - speed        : #{@speed}
      - texture name : #{textureName}
    """

module.exports = Player
