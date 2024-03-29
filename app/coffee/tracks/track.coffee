Phaser = require 'Phaser'
assert = require '../utils/assert.coffee'

Coordinates = require '../utils/coordinates.coffee'

debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

Polygon     = require '../utils/geometry/polygon.coffee'
LineSegment = require '../utils/geometry/line-segment.coffee'

clamp = require '../utils/math/clamp.coffee'

class Track
  constructor: (game, trackManager, num, topLeft, bottomLeft, topRight, bottomRight) ->
    debug 'Constructor...', @, 'info', 30, debugThemes.Tracks

    @game = game
    @trackManager = trackManager
    @num = num
    @shape = new Polygon topLeft.clone(), bottomLeft.clone(), topRight.clone(), bottomRight.clone()

    # Creation of the midLineSegment
    topMiddle = Coordinates.GetMiddle topLeft, topRight
    bottomMiddle = Coordinates.GetMiddle bottomLeft, bottomRight
    @midLineSegment = new LineSegment topMiddle, bottomMiddle


  addGraphics: (graphics) ->
    if @graphics?
      @graphics.destroy()

    @graphics = graphics


  getCollectibleSpawner: () ->
    return @trackManager.collectibleSpawnerManager.spawners[@num]


  getHoleSpawner: () ->
    return @trackManager.holeSpawnerManager.spawnersHole[@num]


  addSprite: (spriteKey) ->
    assert @graphics?, "Track: No graphics for sprite"

    if @sprite?
      @sprite.destroy()

    middlePoint = @shape.getMiddlePoint()

    @sprite = @game.add.sprite middlePoint.x, middlePoint.y, spriteKey
    @sprite.anchor.setTo 0.5, 0.5
    @sprite.mask = @graphics


  addAnimatedSprite: (spriteKey) ->
    assert @graphics?, "Track: No graphics for animated sprite"

    if @sprite?
      @sprite.destroy()

    middlePoint = @shape.getMiddlePoint()

    @sprite = @game.add.sprite middlePoint.x, middlePoint.y, spriteKey
    @sprite.animations.add 'runRight', [0, 1, 2, 3, 4, 5, 6, 7], 20, true
    @sprite.animations.add 'runLeft', [8, 9, 10, 11, 12, 13, 14, 15], 20, true

    @sprite.anchor.setTo 0.5, 0.5
    @sprite.mask = @graphics

    @sprite.animations.play 'runRight'


  destroy: ->
    if @graphics?
      @graphics.destroy()

    if @sprite?
      @sprite.destroy()


  getCoordsInMidLineSegment: (value) ->
    return Coordinates.LerpUnclamped @midLineSegment.getStart(), @midLineSegment.getEnd(), value


  getCollectibleStart: ->
    return @midLineSegment.getStart()


  getCollectibleEnd: ->
    return @midLineSegment.getEnd()


  getPlayerPosition: ->
    return @midLineSegment.getEnd()


  getPlayerRotation: ->
    return @trackManager.getPlayerRotation @


  getHeight: ->
    return @trackManager.getHeight()


  getWidth: ->
    return @trackManager.getWidth()


  getTopLeft: ->
    return @shape.getPoint 0


  getBottomLeft: ->
    return @shape.getPoint 1


  getTopRight: ->
    return @shape.getPoint 2


  getBottomRight: ->
    return @shape.getPoint 3


  toString: ->
    debug 'toString...', @, 'info', 30, debugThemes.Tracks

    return """
    Track :
      - Shape
      #{@shape}
    """

module.exports = Track
