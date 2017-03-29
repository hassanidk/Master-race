Phaser = require 'Phaser'
assert = require 'assert'

Track  = require './track.coffee'
debug  = require './debug.coffee'
debugThemes = require './debug-themes.coffee'
colors = require './colors.coffee'
config = require './config.coffee'

class TrackManager
  # Static vars
  @MIN_NB_TRACKS = 1
  @MAX_NB_TRACKS = Infinity

  @MIN_SHIFT_CENTER = 0
  @MAX_SHIFT_CENTER = Infinity

  constructor: (game, nbTracks, trackSize, shiftCenter=0) ->
    debug 'Constructor...', @, 'info', 30, debugThemes.Tracks

    # Assertions
    assert game?, "Phaser game does not exist"

    assert nbTracks >= TrackManager.MIN_NB_TRACKS, "nbTracks is too low"
    assert nbTracks <= TrackManager.MAX_NB_TRACKS, "nbTracks is too high"

    assert shiftCenter >= TrackManager.MIN_SHIFT_CENTER, "shiftCenter is too low"
    assert shiftCenter <= TrackManager.MAX_SHIFT_CENTER, "shiftCenter is too high"

    # Vars initialization froms args
    @nbTracks = nbTracks
    @trackSize = trackSize
    @shiftCenter = shiftCenter

    # Tracks will be stored in this array
    @tracks = new Array(@nbPistes)

  toString: ->
    debug 'ToString...', @, 'info', 30, debugThemes.Tracks

    return """
    TrackManager :
      - Number of tracks : #{@nbTracks}
      - Track Size       : #{@tracksSize}
      - Shift Center     : #{@shiftCenter}
      - Tracks           :
        #{@tracks}
    """

module.exports = TrackManager
