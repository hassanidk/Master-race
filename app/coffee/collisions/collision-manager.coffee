Phaser = require 'Phaser'
assert = require '../utils/assert.coffee'

Track = require '../tracks/track.coffee'

config      = require '../config/config.coffee'

debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

class CollisionManager
  @DEADLINE = 5

  constructor: (game, player) ->
    assert game?, "Phaser game does not exist"

    @game = game
    @player = player

  checkCollision: () ->
    if not @player.track?
      return false

    collectibleSpawner = @player.track.getCollectibleSpawner()
    nbCollectibles = collectibleSpawner.collectibles.length

    for i in [0..nbCollectibles - 1] by 1
      collectible = collectibleSpawner.collectibles[i]

      # p for Player
      pBottomY = @player.getBottomBorderHeight()
      pSouthRangeY = pBottomY
      pNorthRangeY = pBottomY - CollisionManager.DEADLINE * 10

      cBottomY = collectible.getBottomBorderHeight()
      if cBottomY >= pNorthRangeY and cBottomY <= pSouthRangeY
        # TODO
        collectible.destroy()


module.exports = CollisionManager
