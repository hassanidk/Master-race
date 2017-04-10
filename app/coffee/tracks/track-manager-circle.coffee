Phaser = require 'Phaser'
assert = require '../utils/assert.coffee'

Degrees = require '../utils/math/degrees.coffee'

Square = require '../utils/geometry/square.coffee'

Coordinates = require '../utils/coordinates.coffee'
colors      = require '../utils/colors.coffee'
debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

config      = require '../config/config.coffee'

Track        = require './track.coffee'
TrackManager = require './track-manager.coffee'

class TrackManagerCircle extends TrackManager
  @START_ANGLE_DEGREES = -275

  constructor: (game, nb, spriteKey, startAngle, diffAngle, sizeCenter, shiftCenter=0, oneSpriteOnly=true) ->
    debug 'Constructor...', @, 'info', 30, debugThemes.Tracks

    # TODO
    sizeOut = 0

    assert startAngle instanceof Degrees, "TrackManagerCircle: StartAngle must be in degrees"
    assert diffAngle instanceof Degrees, "TrackManagerCircle: DiffAngle must be in degrees"

    assert diffAngle.value < (Degrees.MAX_DEGREES / nb), "TrackManagerCircle: DiffAngle is too high"

    super game, nb, spriteKey, sizeOut, sizeCenter, shiftCenter, oneSpriteOnly

    # Angle per track
    @anglePerTrack = new Degrees (Degrees.MAX_DEGREES - nb * diffAngle.value) / nb

    @startAngle = startAngle
    @diffAngle = diffAngle

    radius = (1/2) * (Math.sqrt(Math.pow(@game.width, 2) + Math.pow(@game.height, 2)))
    radius = radius * Math.sqrt(2)

    @createTracks radius

    if @oneSpriteOnly
      @graphics = @game.add.graphics()

    for track in @tracks
      if @oneSpriteOnly
        @createTrackGraphics track, @graphics
      else
        graphics = @game.add.graphics()
        graphics = @createTrackGraphics track, graphics
        @tracks[i].addGraphics graphics
        @tracks[i].addSprite @spriteKey


    if @oneSpriteOnly
      @addSprite @spriteKey

    # Graphics are correct, but tracks not
    # We need to set our track in a square
    # Easy solution :
    @tracks = new Array()
    minSquareSize = Math.min @game.width, @game.height
    radius = minSquareSize * Math.sqrt(2) * 0.5
    @createTracks radius
    # TODO Better solution...


  createTracks: (radius) ->
    # Game middle will be the center of the circle
    gameMiddle = new Coordinates @game.world.centerX, @game.world.centerY

    tempAngle = @startAngle

    for i in [0..@nb - 1] by 1
      # Calculate coordinates...
      @tracks[i] = @createTrack gameMiddle, radius, tempAngle, i

      tempAngle.value -= @diffAngle.value

  createTrack: (middle, radius, startAngle, num) ->
    # We start from topRight to Bottom Right and then topLeft to bottomLeft
    # For now, topLeft = topRight = middle

    topLeft = middle
    topRight = middle

    # topRight to bottomRight
    bottomRightX = topRight.x + Math.cos(startAngle.toRadians()) * radius
    bottomRightY = topRight.y + Math.sin(startAngle.toRadians()) * radius
    bottomRight = new Coordinates bottomRightX, bottomRightY

    startAngle.value -= @anglePerTrack.value

    bottomLeftX = topLeft.x + Math.cos(startAngle.toRadians()) * radius
    bottomLeftY = topLeft.y + Math.sin(startAngle.toRadians()) * radius
    bottomLeft = new Coordinates bottomLeftX, bottomLeftY

    return new Track @game, @, num, topLeft, bottomLeft, topRight, bottomRight


  getPlayerRotation: (track) ->
    rot = new Degrees @startAngle.value
    rot.value += TrackManagerCircle.START_ANGLE_DEGREES
    rot.value -= (track.num + 0.5) * @anglePerTrack.value
    rot.value -= track.num * @diffAngle.value

    return rot.getInverse()


  toString: ->
    debug 'ToString...', @, 'info', 3000, debugThemes.Tracks

    return """
    #{super}
    TrackManagerCircle :
    """

module.exports = TrackManagerCircle
