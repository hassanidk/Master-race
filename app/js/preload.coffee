Phaser = require 'Phaser'

config = require './config.coffee'

class Preload extends Phaser.State
  constructor: -> super

  preload: ->
    @load.setPreloadSprite @add.sprite @game.world.centerX - 160, @game.world.centerY - 16, 'preloadBar'

    @stage.backgroundColor = 'black'

    @load.pack 'main', config.pack

  create: ->
    @state.start 'Menu'

module.exports = Preload
