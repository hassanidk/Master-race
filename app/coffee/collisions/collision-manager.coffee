Phaser = require 'Phaser'
assert = require 'assert'

Player             = require '../player/player.coffee'
CollectibleSpawner = require '../collectibles/collectible-spawner.coffee'
TrackManager       = require '../tracks/track-manager.coffee'

config      = require '../config/config.coffee'

debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

class CollisionManager
  @DEADLINE = 3

  constructor: (game, player, trackManager) ->
    assert game?, "Phaser game does not exist"
    asset player instanceof Player, "No Player"
    asset trackManager instanceof TrackManager, "No TrackManager"

    @game = game
    @player = player
    @trackManager = trackManager

  checkCollision: () ->
    if not @player.track?
      return false

    nbCollectibles = @player.track.collectibleSpawner.nb
    for i in [0..nbCollectibles - 1] by 1
      collectible = @player.track.collectibleSpawner.collectibles[i]

      # p for Player
      pBottomY = @player.getBottomBorderHeight()
      pSouthRangeY = pBottomY + @DEADLINE
      pNorthRangeY = pBottomY - @DEADLINE

      if collectible.getBottomBorderHeight() in [pNorthRangeY, pSouthRangeY]
        # TODO
        console.log "COLLISION"


module.exports = CollisionManager
