Phaser = require 'Phaser'
assert = require '../utils/assert.coffee'

debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

CollectibleSpawner = require './collectible-spawner.coffee'
SpawnModes = require './spawn-modes.coffee'

class CollectibleSpawnerManager
  @MIN_SPAWN_PROB = 0
  @MAX_SPAWN_PROB = 1

  constructor: (game, trackManager, spawnMode) ->

    # assert SpawnModes.indexOf spawnMode > 0, "Incorrect spawn mode"
    assert trackManager?, "No TrackManager"

    @game = game
    @trackManager = trackManager
    @spawnMode = spawnMode

    @spawners = new Array @trackManager.nb

    for i in [0..@trackManager.nb - 1] by 1
      @spawners[i] = new CollectibleSpawner @game, @trackManager.tracks[i]


  update: () ->
    for spawner in @spawners
      spawner.update()

  destroy: () ->
    for spawner in @spawners
      spawner.destroy()

    @spawners = null

module.exports = CollectibleSpawnerManager
