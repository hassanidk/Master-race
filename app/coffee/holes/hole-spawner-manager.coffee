Phaser = require 'Phaser'
assert = require '../utils/assert.coffee'

debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

HoleSpawner = require './hole-spawner.coffee'
SpawnModes = require '../collectibles-spawner/spawn-modes.coffee'

class HoleSpawnerManager
  @MIN_SPAWN_PROB = 0
  @MAX_SPAWN_PROB = 1

  constructor: (game, trackManager, spawnMode) ->

# assert SpawnModes.indexOf spawnMode > 0, "Incorrect spawn mode"
    assert trackManager?, "No TrackManager"

    @game = game
    @trackManager = trackManager
    @spawnMode = spawnMode

    @spawnersHole = new Array @trackManager.nb

    for i in [0..@trackManager.nb - 1] by 1
      @spawnersHole[i] = new HoleSpawner @game, @trackManager.tracks[i]


  update: () ->
    for spawner in @spawnersHole
      spawner.update()

  destroy: () ->
    for spawner in @spawnersHole
      spawner.destroy()

    @spawnersHole = null

module.exports = HoleSpawnerManager
