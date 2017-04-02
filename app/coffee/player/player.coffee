Phaser = require 'Phaser'
assert = require 'assert'

Track        = require '../tracks/track.coffee'
TrackManager = require '../tracks/track-manager.coffee'

config      = require '../config/config.coffee'

colors      = require '../utils/colors.coffee'
debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

class Player
  @SPEED_MIN = 0
  @SPEED_MAX = Infinity

  constructor: (game, x, y, textureName, speed) ->
    debug 'Constructor...', @, 'info', 30, debugThemes.Tracks

    assert game?, "Phaser game does not exist"
    assert textureName?, "Player has no texture"

    assert x, "Player has no x coords"
    assert y, "Player has no y coords"

    assert speed >= Player.SPEED_MIN, "Speed is too low"
    assert speed <= Player.SPEED_MAX, "Speed is too high"

    @game = game
    @speed = speed
    @textureName = textureName

    @sprite = @game.add.sprite x, y, textureName
    @sprite.anchor.setTo 0.5, 0.5
    @sprite.animations.add 'runRight', [0, 1, 2, 3, 4, 5, 6, 7], speed, true
    @sprite.animations.add 'runLeft', [8, 9, 10, 11, 12, 13, 14, 15], speed, true

    @sprite.animations.play 'runRight'

  toString: ->
    debug 'ToString...', @, 'info', 30, debugThemes.Tracks

    return """
    Player :
      - speed        : #{@speed}
      - texture name : #{textureName}
    """

module.exports = Player
