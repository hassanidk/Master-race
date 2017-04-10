Phaser = require 'Phaser'
assert = require '../utils/assert.coffee'

CollectibleSpawnerManager = require '../collectibles-spawner/collectible-spawner-manager.coffee'
HoleSpawnerManager = require '../holes/hole-spawner-manager.coffee'
SpawnModes = require '../collectibles-spawner/spawn-modes.coffee'

Coordinates = require '../utils/coordinates.coffee'
colors      = require '../utils/colors.coffee'
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


  createTrackGraphics: (track, graphics) ->

    # Get track points
    topLeft = track.getTopLeft()
    bottomLeft = track.getBottomLeft()
    topRight = track.getTopRight()
    bottomRight = track.getBottomRight()

    # Calculate points from topLeft
    bottomLeft = Coordinates.Sub bottomLeft, topLeft
    topRight = Coordinates.Sub topRight, topLeft
    bottomRight = Coordinates.Sub bottomRight, topLeft

    # Set graphics
    graphics.x = topLeft.x
    graphics.y = topLeft.y

    if track.num >= colors.length
      color = colors[colors.length - 1]
    else
      color = colors[track.num]

    graphics.beginFill color
    graphics.lineTo bottomLeft.x, bottomLeft.y
    graphics.lineTo bottomRight.x, bottomRight.y
    graphics.lineTo topRight.x, topRight.y
    graphics.endFill()

    return graphics

  addGraphics: (graphics) ->
    if @graphics?
      @graphics.destroy()

    @graphics = graphics


  addSprite: (spriteKey) ->
    assert @graphics?, "TrackManager: No graphics for sprite"

    if @sprite?
      @sprite.destroy()

    @sprite = @game.add.sprite @game.world.centerX, @game.world.centerY, spriteKey
    @sprite.anchor.setTo 0.5, 0.5

    @sprite.mask = @graphics

  getPlayerRotation: (track) ->
    return 0


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
