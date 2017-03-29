Phaser = require 'Phaser'
assert = require 'assert'

Track        = require './track.coffee'
TrackManager = require './track-manager.coffee'
debug        = require './debug.coffee'
debugThemes  = require './debug-themes.coffee'
colors       = require './colors.coffee'
config       = require './config.coffee'

class TrackManagerFlat extends TrackManager
  @MIN_SHIFT_TRACKS = 0
  @MAX_SHIFT_TRACKS = Infinity

  constructor: (game, nbTracks, trackSize, shiftCenter=0, shiftTracks=20) ->
    debug 'Constructor...', @, 'info', 30, debugThemes.Tracks

    super(game, nbTracks, trackSize, shiftCenter)

    assert shiftTracks >= TrackManagerFlat.MIN_SHIFT_TRACKS, "shiftTracks is too low"
    assert shiftTracks <= TrackManagerFlat.MAX_SHIFT_TRACKS, "shiftTracks is too high"

    @shiftTracks = shiftTracks

    nbTracksHalf = @nbTracks / 2

    cmpt = 0
    pointX = -nbTracksHalf * (@trackSize + @shiftTracks) + @shiftTracks / 2

    graphics = game.add.graphics game.world.centerX, game.world.centerY

    graphics.moveTo -(@nbPistesHalf * @shiftCenter), 0

    while cmpt < @nbTracks
      graphics.moveTo @shiftCenter, 0

      if cmpt >= colors.length
        color = colors[colors.length - 1]
      else
        color = colors[cmpt]

      graphics.beginFill color
      graphics.lineTo pointX, game.world.height / 2
      graphics.lineTo pointX + @trackSize, game.world.height / 2
      graphics.endFill()

      pointX += @trackSize + @shiftTracks
      cmpt += 1

    ###
    sprite = game.add.sprite game.world.centerX, game.world.centerY, graphics.generateTexture()
    sprite.anchor.set 0.5, 0
    ###

    ok = game.add.sprite 0, 0, 'bg'
    ok.mask = graphics

    # ok = new TrackGraphics(game, 'bg')

    # @tracks[0] = new Track game, 0, 0, 'bg', graphics


  toString: ->
    debug 'ToString...', @, 'info', 30, debugThemes.Tracks

    return """
    #{super}
    TrackManagerFlat :
      - Shift Tracks : #{@shiftTracks}
    """

module.exports = TrackManagerFlat
