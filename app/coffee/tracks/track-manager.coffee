Phaser = require 'Phaser'
assert = require '../utils/assert.coffee'

CollectibleSpawnerManager = require '../collectibles-spawner/collectible-spawner-manager.coffee'
SpawnModes = require '../collectibles-spawner/spawn-modes.coffee'

debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

Track  = require './track.coffee'

class TrackManager
  # Static vars
  @MIN_NB_TRACKS = 1
  @MAX_NB_TRACKS = Infinity

  @MIN_SHIFT_CENTER = 0
  @MAX_SHIFT_CENTER = Infinity

  constructor: (game, nb, sizeOut, sizeCenter, shiftCenter=0) ->
    debug 'Constructor...', @, 'info', 30, debugThemes.Tracks

    assert game?, "Phaser game does not exist"

    assert nb >= TrackManager.MIN_NB_TRACKS, "nb is too low"
    assert nb <= TrackManager.MAX_NB_TRACKS, "nb is too high"

    assert shiftCenter >= TrackManager.MIN_SHIFT_CENTER, "shiftCenter is too low"
    assert shiftCenter <= TrackManager.MAX_SHIFT_CENTER, "shiftCenter is too high"

    # Game phaser component
    @game = game

    # Group of tracks
    @nb = nb
    @nbHalf = @nb / 2

    # Speed of track TODO !

    # Track properties
    @sizeOut = sizeOut
    @sizeCenter = sizeCenter
    @shiftCenter = shiftCenter

    # Group for displayed objects
    @tracksGroup = @game.add.group()

    # Tracks will be stored in this array
    @tracks = new Array(@nbPistes)

    # Collectible Spawner Manager
    @collectibleSpawnerManager = new CollectibleSpawnerManager @game, @, SpawnModes.friendly


  destroy: ->
    for track in @tracks
      track.destroy()

    @tracksGroup.destroy()
    @tracksGroup = null
    @tracks = null


  update: ->
    @collectibleSpawnerManager.update()

  toString: ->
    debug 'ToString...', @, 'info', 30, debugThemes.Tracks

    return """
    TrackManager :
      - Number of tracks  : #{@nb}
      - Track Size Out    : #{@sizeOut}
      - Track Size Center : #{@sizeCenter}
      - Shift Center      : #{@shiftCenter}
      - Tracks            :
        #{@tracks}
    """

module.exports = TrackManager
