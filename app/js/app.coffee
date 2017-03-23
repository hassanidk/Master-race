"""

app.coffee

 - Fichier .coffee principal qui va regrouper les autres fichiers
  grace à require (nodejs)

 - Browserify va inclure les dépendances et en sortir un code minimal

"""

Phaser   = require 'Phaser'

config   = require './config.coffee'
Boot     = require './boot.coffee'
Preload  = require './preload.coffee'
Menu     = require './menu.coffee'
Game     = require './game.coffee'
Piste    = require './piste.coffee'

game = new Phaser.Game config.width, config.height, Phaser.AUTO, 'game-stage'

game.state.add 'Boot', Boot
game.state.add 'Preload', Preload
game.state.add 'Menu', Menu
game.state.add 'Game', Game
game.state.add 'Piste', Piste

game.state.start 'Boot'
