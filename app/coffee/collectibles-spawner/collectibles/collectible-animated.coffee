Phaser = require 'Phaser'
assert = require '../../utils/assert.coffee'

Collectible = require './collectible.coffee'

config      = require '../../config/config.coffee'

debug       = require '../../utils/debug.coffee'
debugThemes = require '../../utils/debug-themes.coffee'

class CollectibleAnimated extends Collectible
  constructor: (game, track, spriteKey) ->
    debug 'Constructor...', @, 'info', 30, debugThemes.Collectibles
    # TODO
    undefined

  destroy: ->
    debug 'Destroy...', @, 'info', 30, debugThemes.Collectibles
    # TODO
    undefined


module.exports = Collectible
