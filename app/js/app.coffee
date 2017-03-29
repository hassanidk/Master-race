###

app.coffee

###

Phaser   = require 'Phaser'

# States
Boot     = require './boot.coffee'
Preload  = require './preload.coffee'
Menu     = require './menu.coffee'
Game     = require './game.coffee'
Piste    = require './piste-test.coffee'

config = require './config.coffee'
debug  = require './debug.coffee'
debugThemes = require './debug-themes.coffee'

game = new Phaser.Game config.width, config.height, Phaser.AUTO, 'game-stage'

if game?
  debug 'Phaser Game created successfully!', null, 'info', 0, debugThemes.Phaser
else
  debug 'Phaser Game could not be created!', null, 'error', 0, debugThemes.Phaser

game.state.add 'Boot', Boot
game.state.add 'Preload', Preload
game.state.add 'Menu', Menu
game.state.add 'Game', Game
game.state.add 'Piste', Piste

debug 'Phaser States : ', null, 'info', 10, debugThemes.Phaser, game.state.states

game.state.start 'Boot'
