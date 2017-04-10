Phaser = require 'Phaser'
assert = require '../utils/assert.coffee'

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

  constructor: (game, nb, spriteKey, sizeOut, sizeCenter, shiftCenter=0, oneSpriteOnly=true, shiftOut=20, outHeight=null, centerHeight=null) ->
    debug 'Constructor...', @, 'info', 30, debugThemes.Tracks

    super game, nb, spriteKey, sizeOut, sizeCenter, shiftCenter, oneSpriteOnly

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
    topLeftX = @game.world.centerX - @nbHalf * (@sizeCenter + @shiftCenter) + @shiftCenter / 2
    topLeftY = @centerHeight
    topLeft = new Coordinates topLeftX, topLeftY

    # Bottom Left corner of track
    bottomLeftX = @game.world.centerX - @nbHalf * (@sizeOut + @shiftOut) + @shiftOut / 2
    bottomLeftY = @outHeight
    bottomLeft = new Coordinates bottomLeftX, bottomLeftY

    # Top Right corner of track
    topRight = new Coordinates topLeft.x + @sizeCenter, topLeft.y

    # Bottom Right corner of track
    bottomRight = new Coordinates bottomLeft.x + @sizeOut, bottomLeft.y

    # Total sizes of tracks (size + shift)
    totalSizeCenter = @sizeCenter + @shiftCenter
    totalSizeOut = @sizeOut + @shiftOut

    if @oneSpriteOnly
      graphics = @game.add.graphics topLeft.x, topLeft.y

    for i in [0..@nb - 1] by 1
      @tracks[i] = new Track @game, @, i, topLeft, bottomLeft, topRight, bottomRight

      if @oneSpriteOnly
        @createTrackGraphics @tracks[i], graphics
      else
        graphics = @game.add.graphics()
        @tracks[i].addGraphics( @createTrackGraphics @tracks[i], graphics )
        @tracks[i].addSprite @spriteKey

      topLeft.x += totalSizeCenter
      bottomLeft.x += totalSizeOut
      topRight.x += totalSizeCenter
      bottomRight.x += totalSizeOut

    if @oneSpriteOnly
      @addGraphics graphics
      @addSprite @spriteKey


  createTrackGraphics: (track, graphics) ->

    topLeft = track.getTopLeft()
    bottomLeft = track.getBottomLeft()

    graphics.x = topLeft.x
    graphics.y = topLeft.y

    if track.num >= colors.length
      color = colors[colors.length - 1]
    else
      color = colors[track.num]

    diffLeft = Coordinates.Sub bottomLeft, topLeft

    graphics.beginFill color
    graphics.lineTo diffLeft.x, diffLeft.y
    graphics.lineTo diffLeft.x + @sizeOut, diffLeft.y
    graphics.lineTo @sizeCenter, 0
    graphics.endFill()

    return graphics


  addSprite: (spriteKey) ->
    super spriteKey

    center = @getCenter()

    @sprite.x = center.x
    @sprite.y = center.y


  getHeight: ->
    return @outHeight - @centerHeight


  getWidth: ->
    firstTrack = @tracks[0]
    lastTrack = @tracks[@tracks.length - 1]

    minX = Math.min firstTrack.getTopLeft().x, firstTrack.getBottomLeft().x
    maxX = Math.max lastTrack.getTopRight().x, lastTrack.getBottomRight().x

    return maxX - minX


  getCenter: ->
    firstTrack = @tracks[0]
    lastTrack = @tracks[@tracks.length - 1]

    minX = Math.min firstTrack.getTopLeft().x, firstTrack.getBottomLeft().x
    maxX = Math.max lastTrack.getTopRight().x, lastTrack.getBottomRight().x

    return new Coordinates (minX + maxX) / 2, (@outHeight + @centerHeight) / 2


  toString: ->
    debug 'ToString...', @, 'info', 30, debugThemes.Tracks

    return """
    #{super}
    TrackManagerFlat :
      - Shift Out : #{@shiftOut}
    """

module.exports = TrackManagerFlat
