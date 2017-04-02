Phaser = require 'Phaser'
assert = require 'assert'

Track        = require './track.coffee'
TrackManager = require './track-manager.coffee'

Coordinates  = require '../utils/coordinates.coffee'

config      = require '../config/config.coffee'

colors      = require '../utils/colors.coffee'
debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

class TrackManagerFlat extends TrackManager
  @MIN_SHIFT_OUT = 0
  @MAX_SHIFT_OUT = Infinity

  constructor: (game, nbTracks, trackSizeOut, trackSizeCenter, shiftCenter=0, shiftOut=20, outHeight=null, centerHeight=null) ->
    debug 'Constructor...', @, 'info', 30, debugThemes.Tracks

    super game, nbTracks, trackSizeOut, trackSizeCenter, shiftCenter

    assert shiftOut >= TrackManagerFlat.MIN_SHIFT_OUT, "shiftTracks is too low"
    assert shiftOut <= TrackManagerFlat.MAX_SHIFT_OUT, "shiftTracks is too high"

    if not outHeight?
      outHeight = @game.world.height

    if not centerHeight?
      centerHeight = @game.world.centerY

    @shiftOut = shiftOut
    @outHeight = outHeight
    @centerHeight = centerHeight

    # Finally create tracks
    @createTracks()

  createTracks: () ->
    # Top Left corner of track
    startCenterX = @game.world.centerX - @nbTracksHalf * (@trackSizeCenter + @shiftCenter) + @shiftCenter / 2
    startCenterY = @centerHeight
    startCenter = new Coordinates startCenterX, startCenterY

    # Bottom Left corner of track
    startOutX = @game.world.centerX - @nbTracksHalf * (@trackSizeOut + @shiftOut) + @shiftOut / 2
    startOutY = @outHeight
    startOut = new Coordinates startOutX, startOutY

    # Top Right corner of track
    endCenter = new Coordinates startCenter.x + @trackSizeCenter, startCenter.y

    # Bottom Right corner of track
    endOut = new Coordinates startOut.x + @trackSizeOut, startOut.y

    # Total sizes of tracks (size + shift)
    totalSizeCenter = @trackSizeCenter + @shiftCenter
    totalSizeOut = @trackSizeOut + @shiftOut

    for i in [0..@nbTracks - 1] by 1
      @createTrack i, startCenter, startOut, endCenter, endOut

      startCenter.x += totalSizeCenter
      startOut.x += totalSizeOut
      endCenter.x += totalSizeCenter
      endOut.x += totalSizeOut

    ###
    sprite = game.add.sprite game.world.centerX, game.world.centerY, @graphics.generateTexture()
    sprite.anchor.set 0.5, 0
    ###

    ###
    ok = @game.add.sprite 0, 0, 'bg'
    ok.mask = @graphics
    ###

    # debug @toString(), @

    # ok = new Track@graphics(game, 'bg')

    # @tracks[0] = new Track game, 0, 0, 'bg', @graphics

  createTrack: (num, startCenter, startOut, endCenter, endOut) ->

    topLeft = startCenter
    bottomLeft = startOut
    topRight = endCenter
    bottomRight = endOut

    graphics = @game.add.graphics topLeft.x, topLeft.y

    if num >= colors.length
      color = colors[colors.length - 1]
    else
      color = colors[num]

    diffLeft = Coordinates.Sub bottomLeft, topLeft

    graphics.beginFill color
    graphics.lineTo diffLeft.x, diffLeft.y
    graphics.lineTo diffLeft.x + @trackSizeOut, diffLeft.y
    graphics.lineTo @trackSizeCenter, 0
    graphics.endFill()

    @tracks[num] = new Track @game, num, startCenter, startOut, endCenter, endOut
    @tracks[num].addGraphics graphics
    @tracks[num].addSprite 'bg'
    # @tracks[num].addAnimatedSprite 'player'


  toString: ->
    debug 'ToString...', @, 'info', 30, debugThemes.Tracks

    return """
    #{super}
    TrackManagerFlat :
      - Shift Out : #{@shiftOut}
    """

module.exports = TrackManagerFlat
