Phaser = require 'Phaser'
assert = require 'assert'

CollectibleStatic = require './collectible-static.coffee'

configCollectible = require './config-collectibles.coffee'

debug       = require '../../utils/debug.coffee'
debugThemes = require '../../utils/debug-themes.coffee'

class Coin extends CollectibleStatic
  constructor: (game, track) ->
    debug 'Constructor...', @, 'info', 30, debugThemes.Collectibles
    super game, track, configCollectible.coinSpriteKey

module.exports = Coin
