Phaser = require 'Phaser'
assert = require 'assert'

config      = require '../config/config.coffee'

debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

Collectible = require './collectibles/collectible.coffee'
CollectibleAnimated = require './collectibles/collectible-animated.coffee'
CollectibleStatic = require './collectibles/collectible-static.coffee'

SpawnModes = require './spawn-modes.coffee'

class CollectibleSpawner
  @MIN_SPAWN_PROB = 0
  @MAX_SPAWN_PROB = 1

  constructor: (game, spawnMode) ->
    debug 'Constructor...', @, 'info', 30, debugThemes.Collectibles

    # TODO
    # assert spawnMode in SpawnModes, "Incorrect spawn mode"

    @game = game
    @spawnMode = spawnMode
    @collectibles = new Array()

  update: () ->
    for collectible in @collectibles
      collectible.update()

    # TODO
    # If collectible.isOut
    #     Alors detruit et arrange l'array

module.exports = CollectibleSpawner
