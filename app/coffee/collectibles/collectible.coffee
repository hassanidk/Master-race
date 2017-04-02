Phaser = require 'Phaser'
assert = require 'assert'

config      = require '../config/config.coffee'

debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

class Collectible
  constructor: (game, sprite) ->
    console.log instanceof sprite

    @game = game
    @sprite = sprite

  destroy: ->
    if @sprite?
      @sprite.destroy()


module.exports = Collectible
