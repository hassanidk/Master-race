Phaser = require 'Phaser'
assert = require 'assert'

Coordinates = require '../utils/coordinates.coffee'

config      = require '../config/config.coffee'

debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

Polygon     = require '../utils/geometry/polygon.coffee'

class Track
  constructor: (game, num, topLeft, bottomLeft, topRight, bottomRight) ->
    debug 'Constructor...', @, 'info', 30, debugThemes.Tracks

    @game = game
    @num = num
    @shape = new Polygon topLeft.clone(), bottomLeft.clone(), topRight.clone(), bottomRight.clone()

    ###

    Je ne pense pas qu'il y ait besoin de faire une classe qui extends Phaser.sprite

    Deux manières de faire :
      - Héritage : On étend le sprite
      - En variable (privée de préference)

    J'opterai pour la 2°

    # TODO
    super game, x, y, texture, frame

    game.add.existing @
    ###

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


  getTopLeft: ->
    return @shape.getPoint 0


  getBottomLeft: ->
    return @shape.getPoint 1


  getTopRight: ->
    return @shape.getPoint 2


  getBottomRight: ->
    return @shape.getPoint 3


  destroy: ->
    if @graphics?
      @graphics.destroy()

    if @sprite?
      @sprite.destroy()

  toString: ->
    debug 'toString...', @, 'info', 30, debugThemes.Tracks

    return """
    Track :
      - Shape
      #{@shape}
    """

module.exports = Track
