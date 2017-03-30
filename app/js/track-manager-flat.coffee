Phaser = require 'Phaser'
assert = require 'assert'

Coordinates = require './coordinates.coffee'
Track        = require './track.coffee'
TrackManager = require './track-manager.coffee'


debug        = require './debug.coffee'
debugThemes  = require './debug-themes.coffee'
colors       = require './colors.coffee'
config       = require './config.coffee'

class TrackManagerFlat extends TrackManager
  @MIN_SHIFT_OUT = 0
  @MAX_SHIFT_OUT = Infinity

  constructor: (game, nbTracks, trackSizeOut, trackSizeCenter, shiftCenter=0, shiftOut=20, outHeight=null, centerHeight=null) ->
    debug 'Constructor...', @, 'info', 30, debugThemes.Tracks

    super(game, nbTracks, trackSizeOut, trackSizeCenter, shiftCenter)

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
    startCenterX = @game.world.centerX - @nbTracksHalf * (@trackSizeCenter + @shiftCenter) + @shiftCenter / 2
    startCenterY = @centerHeight

    startOutX = @game.world.centerX - @nbTracksHalf * (@trackSizeOut + @shiftOut) + @shiftOut / 2
    startOutY = @outHeight

    startCenter = new Coordinates startCenterX, startCenterY
    startOut = new Coordinates startOutX, startOutY

    for i in [0..@nbTracks - 1] by 1
      @createTrackGraphics(i, startCenter, startOut)
      startCenter.x += @trackSizeCenter + @shiftCenter
      startOut.x += @trackSizeOut + @shiftOut

    ###
    sprite = game.add.sprite game.world.centerX, game.world.centerY, @graphics.generateTexture()
    sprite.anchor.set 0.5, 0
    ###

    ###
    ok = @game.add.sprite 0, 0, 'bg'
    ok.mask = @graphics
    ###

    debug @toString(), @

    # ok = new Track@graphics(game, 'bg')

    # @tracks[0] = new Track game, 0, 0, 'bg', @graphics

  createTrackGraphics: (numTrack, startCenter, startOut) ->
    # Polygone, 4 sommets

    graphics = @game.add.graphics startCenter.x, startCenter.y

    if numTrack >= colors.length
      color = colors[colors.length - 1]
    else
      color = colors[numTrack]

    graphics.beginFill color
    graphics.lineTo startOut.x - startCenter.x, startOut.y - startCenter.y
    graphics.lineTo startOut.x + @trackSizeOut - startCenter.x, startOut.y - startCenter.y
    graphics.lineTo @trackSizeCenter, 0
    graphics.endFill()

    endCenter = new Coordinates startCenter.x + @trackSizeCenter, startCenter.y
    endOut = new Coordinates startOut.x + @trackSizeOut, startOut.y

    @tracks[numTrack] = new Track @game, graphics, startCenter, startOut, endCenter, endOut

    ###
    graphics = @game.create.graphics @game.world.centerX, @game.world.centerY

    if numTrack >= colors.length
      color = colors[colors.length - 1]
    else
      color = colors[numTrack]

    graphics.beginFill color
    graphics.lineTo pointX, @game.world.height / 2
    graphics.lineTo pointX + @trackSizeOut, @game.world.height / 2
    graphics.endFill()

    pointX += @trackSizeOut + @shiftTracks
    ###


  toString: ->
    debug 'ToString...', @, 'info', 30, debugThemes.Tracks

    return """
    #{super}
    TrackManagerFlat :
      - Shift Out : #{@shiftOut}
    """

module.exports = TrackManagerFlat
