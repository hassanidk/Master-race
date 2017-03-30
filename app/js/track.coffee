Phaser = require 'Phaser'

Polygon = require './polygon.coffee'
Coordinates = require './coordinates.coffee'

config = require './config.coffee'
debug  = require './debug.coffee'
debugThemes = require './debug-themes.coffee'

class Track
  constructor: (game, graphics, topLeft, bottomLeft, topRight, bottomRight, texture, frame, mask) ->
    debug 'Constructor...', @, 'info', 30, debugThemes.Tracks

    @game = game
    @graphics = graphics
    @shape = new Polygon topLeft, bottomLeft, topRight, bottomRight

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

  destroy: ->
    @graphics.destroy()

  toString: ->
    debug 'toString...', @, 'info', 30, debugThemes.Tracks

    return """
    Track :
      - Shape
      #{@shape}
    """

module.exports = Track
