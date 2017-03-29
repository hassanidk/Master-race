Phaser = require 'Phaser'

config = require './config.coffee'
debug  = require './debug.coffee'
debugThemes = require './debug-themes.coffee'

class Track
  constructor: (game, x, y, texture, frame, mask) ->
    debug 'Constructor...', @, 'info', 30, debugThemes.Tracks

    ###

    Je ne pense pas qu'il y ait besoin de faire une classe qui extends Phaser.spritesheet

    Deux manières de faire :
      - Héritage : On étend le sprite
      - En variable (privée de préference)

    J'opterai pour la 2°

    # TODO
    super game, x, y, texture, frame

    game.add.existing @
    ###

module.exports = Track
