Phaser = require 'Phaser'
assert = require 'assert'

Coordinates = require '../utils/coordinates.coffee'

debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

CollectibleSpawner = require '../collectibles-spawner/collectible-spawner.coffee'
SpawnModes = require '../collectibles-spawner/spawn-modes.coffee'

Polygon     = require '../utils/geometry/polygon.coffee'
Line = require '../utils/geometry/line.coffee'

class Track
  constructor: (game, trackManager, num, topLeft, bottomLeft, topRight, bottomRight) ->
    debug 'Constructor...', @, 'info', 30, debugThemes.Tracks

    @game = game
    @trackManager = trackManager
    @num = num
    @shape = new Polygon topLeft.clone(), bottomLeft.clone(), topRight.clone(), bottomRight.clone()

    topMiddle = Coordinates.GetMiddle topLeft, topRight
    bottomMiddle = Coordinates.GetMiddle bottomLeft, bottomRight
    @midLine = new Line topMiddle, bottomMiddle
    @collectibleSpawner = new CollectibleSpawner @game, SpawnModes.friendly



  addGraphics: (graphics) ->
    if @graphics?
      @graphics.destroy()

    @graphics = graphics


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


  update: ->
    @collectibleSpawner.update()


  destroy: ->
    if @graphics?
      @graphics.destroy()

    if @sprite?
      @sprite.destroy()


  getCollectibleStart: ->
    return @midLine.getPointA()


  getCollectibleEnd: ->
    return @midLine.getPointB()


  getPlayerPosition: ->
    return @midLine.getPointB()


  getPlayerRotation: ->
    return 0

    # TODO trackManagerCircle
    throw "Unhandled Exception : Track Manager Circle"


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
