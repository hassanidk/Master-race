Phaser = require 'Phaser'
assert = require 'assert'

Collectible = require 'Collectible'
CollectibleAnimated = require 'CollectibleAnimated'
CollectibleStatic = require 'CollectibleStatic'

config      = require '../config/config.coffee'

debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

class CollectibleSpawner
  constructor: (game) ->
    @game = game

  

module.exports = CollectibleSpawner
