Phaser = require 'Phaser'
assert = require 'assert'

Track  = require './track.coffee'

config      = require '../config/config.coffee'

colors      = require '../utils/colors.coffee'
debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

class TrackManager
  # Static vars
  @MIN_NB_TRACKS = 1
  @MAX_NB_TRACKS = Infinity

  @MIN_SHIFT_CENTER = 0
  @MAX_SHIFT_CENTER = Infinity

  constructor: (game, nbTracks, trackSizeOut, trackSizeCenter, shiftCenter=0) ->
    debug 'Constructor...', @, 'info', 30, debugThemes.Tracks

    assert game?, "Phaser game does not exist"

    assert nbTracks >= TrackManager.MIN_NB_TRACKS, "nbTracks is too low"
    assert nbTracks <= TrackManager.MAX_NB_TRACKS, "nbTracks is too high"

    assert shiftCenter >= TrackManager.MIN_SHIFT_CENTER, "shiftCenter is too low"
    assert shiftCenter <= TrackManager.MAX_SHIFT_CENTER, "shiftCenter is too high"

    # Game phaser component
    @game = game

    # Group of tracks
    @nbTracks = nbTracks
    @nbTracksHalf = @nbTracks / 2

    # Speed of track TODO !

    # Track properties
    @trackSizeOut = trackSizeOut
    @trackSizeCenter = trackSizeCenter
    @shiftCenter = shiftCenter

    # Group for displayed objects
    @tracksGroup = @game.add.group()

    # Tracks will be stored in this array
    @tracks = new Array(@nbPistes)

  destroy: ->
    for track in @tracks
      track.destroy()

    @tracksGroup.destroy()

  toString: ->
    debug 'ToString...', @, 'info', 30, debugThemes.Tracks

    return """
    TrackManager :
      - Number of tracks  : #{@nbTracks}
      - Track Size Out    : #{@trackSizeOut}
      - Track Size Center : #{@trackSizeCenter}
      - Shift Center      : #{@shiftCenter}
      - Tracks            :
        #{@tracks}
    """

module.exports = TrackManager
