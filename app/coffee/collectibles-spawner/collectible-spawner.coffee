Phaser = require 'Phaser'
assert = require '../utils/assert.coffee'

config      = require '../config/config.coffee'

debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

Collectible = require './collectibles/collectible.coffee'
CollectibleAnimated = require './collectibles/collectible-animated.coffee'
CollectibleStatic = require './collectibles/collectible-static.coffee'

class CollectibleSpawner

  constructor: (game, track) ->
    debug 'Constructor...', @, 'info', 30, debugThemes.Collectibles

    @game = game
    @collectibles = new Array()


  update: () ->
    for collectible in @collectibles
      collectible.update()

      # if collectible.isOut
      # DO


  destroyCollectible: (collectible) ->



module.exports = CollectibleSpawner
