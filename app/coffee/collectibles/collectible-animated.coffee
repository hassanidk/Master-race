Phaser = require 'Phaser'
assert = require 'assert'

Collectible = require './collectible.coffee'

config      = require '../config/config.coffee'

debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

class CollectibleAnimated extends Collectible
  constructor: (spriteKey) ->
    undefined

  destroy: ->
    undefined


module.exports = Collectible
