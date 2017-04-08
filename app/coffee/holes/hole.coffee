Phaser = require 'Phaser'
assert = require '../utils/assert.coffee'

Track = require '../tracks/track.coffee'
Coordinates = require '../utils/coordinates.coffee'

config      = require '../config/config.coffee'
configHoles = require './config-holes.coffee'

debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

class Hole
  constructor: (game, track) ->
    debug 'Constructor...', @, 'info', 30, debugThemes.Other

    assert track instanceof Track, 'Incorrect Track'

    @game = game
    @track = track

    startCoords = @track.getCollectibleStart()

    @sprite = game.add.sprite startCoords.x, startCoords.y, configHoles.holeSpriteKey
    @sprite.scale.setTo 0.1, 0.1
    @sprite.anchor.setTo 0.5, 0


    # TODO
    # @speed
    @isOut = false

    @sprite.checkWorldBounds = true;
    @sprite.events.onOutOfBounds.add @destroy

    startPoint = @track.getCollectibleStart()
    endPoint = @track.getCollectibleEnd()

    @initialScale = new Coordinates @sprite.scale.x, @sprite.scale.y
    @vector = Coordinates.Sub endPoint, startPoint

  update: () ->
    currentScale = new Coordinates @sprite.scale.x, @sprite.scale.y

    factor = Coordinates.GetFactor currentScale, @initialScale

    @sprite.x += ((@vector.x / 750) * factor)
    @sprite.y += ((@vector.y / 750) * factor)

    # Manage scale
    #@sprite.scale.x *= 1.025
    #@sprite.scale.y *= 1.025




  getBottomBorderHeight: ->
    return @sprite.y


  destroy: ->
    debug 'Destroy...', @, 'info', 30, debugThemes.Other

    if @sprite?
      @sprite.destroy()

    @isOut = true

module.exports = Hole
