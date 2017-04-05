Phaser = require 'Phaser'
assert = require '../utils/assert.coffee'

config      = require '../config/config.coffee'

debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

class HoleSpawner

  constructor: (game, track) ->
    debug 'Constructor...', @, 'info', 30, debugThemes.Other

    @game = game
    @holes = new Array()


  update: () ->
    for hole in @holes
      hole.update()

##TODO


  destroyCollectible: (hole) ->



module.exports = HoleSpawner
