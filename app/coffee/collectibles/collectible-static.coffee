Phaser = require 'Phaser'
assert = require 'assert'

Collectible = require './collectible.coffee'

config      = require '../config/config.coffee'

debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

class CollectibleStatic extends Collectible
  constructor: (game, x, y, spriteKey) ->
    sprite = game.add.sprite x, y, spriteKey
    super game, sprite




module.exports = CollectibleStatic
