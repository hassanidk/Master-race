Phaser = require 'Phaser'
assert = require '../utils/assert.coffee'

CollectibleSpawnerManager = require '../collectibles-spawner/collectible-spawner-manager.coffee'
HoleSpawnerManager = require '../holes/hole-spawner-manager.coffee'
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

  constructor: (game, nb, spriteKey, sizeOut, sizeCenter, shiftCenter=0, oneSpriteOnly=null) ->
    debug 'Constructor...', @, 'info', 30, debugThemes.Tracks

    assert game?, "Phaser game does not exist"

    assert nb >= TrackManager.MIN_NB_TRACKS, "nb is too low"
    assert nb <= TrackManager.MAX_NB_TRACKS, "nb is too high"

    assert shiftCenter >= TrackManager.MIN_SHIFT_CENTER, "shiftCenter is too low"
    assert shiftCenter <= TrackManager.MAX_SHIFT_CENTER, "shiftCenter is too high"

    # Args
    @game = game
    @nb = nb                   # Number of tracks
    @spriteKey = spriteKey     # Key for sprite
    @sizeOut = sizeOut         # Size of tracks that goes out (of the screen)
    @sizeCenter = sizeCenter   # Size of tracks around center
    @shiftCenter = shiftCenter # Shift between tracks around center

    # If null, a track = a sprite. Else, track manager = sprite
    @oneSpriteOnly = oneSpriteOnly # Use one sprite for all tracks

    # Speed of track TODO !
    # TODO

    # To use later...
    @nbHalf = @nb / 2

    # Group for displayed objects
    @tracksGroup = @game.add.group()

    # Tracks will be stored in this array
    @tracks = new Array(@nbPistes)

    # Collectible Spawner Manager
    @collectibleSpawnerManager = new CollectibleSpawnerManager @game, @, SpawnModes.friendly
    @holeSpawnerManager = new HoleSpawnerManager @game, @, SpawnModes.friendly


  addGraphics: (graphics) ->
    if @graphics?
      @graphics.destroy()

    @graphics = graphics


  addSprite: (spriteKey) ->
    assert @graphics?, "Track: No graphics for sprite"

    if @sprite?
      @sprite.destroy()


  destroy: ->
    for track in @tracks
      track.destroy()

    if @graphics?
      @graphics.destroy()

    if @sprite?
      @sprite.destroy()

    @tracksGroup.destroy()
    @tracksGroup = null
    @tracks = null


  update: ->

    if @sprite?
      @sprite.y += 0.1

    @collectibleSpawnerManager.update()
    @holeSpawnerManager.update()


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
