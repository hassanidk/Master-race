Phaser = require 'Phaser'
assert = require 'assert'

Player = require './player.coffee'

config      = require '../config/config.coffee'

debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

class CollisionManager
  constructor: (game, player, collectibleSpawner) ->
    assert game?, "Phaser game does not exist"
    asset player instanceof Player, "Player is incorrect"
    assert collectibleSpawner instanceof C
