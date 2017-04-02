Phaser = require 'Phaser'
assert = require 'assert'

config      = require '../config/config.coffee'

debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

class Collectible
  constructor: (game, x, y, sprite) ->
    console.log instanceof sprite

    @game = game
    @x = x
    @y = y
    @sprite = sprite

    # TODO
    @sprite.checkWorldBounds = true;
    @sprite.events.onOutOfBounds

  getBottomBorderHeight: ->
    # TODO
    undefined

  destroy: ->
    if @sprite?
      @sprite.destroy()


module.exports = Collectible
