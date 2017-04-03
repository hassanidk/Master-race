Phaser = require 'Phaser'
assert = require 'assert'

Collectible = require './collectible.coffee'

config      = require '../../config/config.coffee'

debug       = require '../../utils/debug.coffee'
debugThemes = require '../../utils/debug-themes.coffee'

class CollectibleStatic extends Collectible
  constructor: (game, track, spriteKey) ->
    debug 'Constructor...', @, 'info', 30, debugThemes.Collectibles

    startCoords = track.getCollectibleStart()
    sprite = game.add.sprite startCoords.x, startCoords.y, spriteKey
    sprite.scale.setTo 0.1, 0.1
    sprite.anchor.setTo 0.5, 0.5
    super game, track, sprite


module.exports = CollectibleStatic
