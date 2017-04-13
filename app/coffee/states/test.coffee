Phaser = require 'Phaser'

Square      = require '../utils/geometry/square.coffee'
Polygon     = require '../utils/geometry/polygon.coffee'
Coordinates = require '../utils/coordinates.coffee'

Degrees = require '../utils/math/degrees.coffee'

Player = require '../player/player.coffee'

TrackManager       = require '../tracks/track-manager.coffee'
TrackManagerFlat   = require '../tracks/track-manager-flat.coffee'
TrackManagerCircle = require '../tracks/track-manager-circle.coffee'

Coin = require '../collectibles-spawner/collectibles/coin.coffee'
Hole = require '../holes/hole.coffee'

Vortex = require '../vortex/vortex.coffee'

debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

class Test extends Phaser.State
  constructor: -> super


  preload: ->
    @game.load.spritesheet 'dude', 'assets/img/dude.png'
    @game.load.atlas 'player', 'assets/img/player.png', 'assets/player.json'
    @game.load.image 'coin', 'assets/img/coin.png'
    @game.load.image 'hole', 'assets/img/hole.png'
    @game.load.image 'bg', 'assets/img/game-background-960.jpg'
    @game.load.image 'space', 'assets/img/space.jpg'
    @game.load.image 'vortex', 'assets/img/cyberglow.png'
    @game.load.image 'ooze', 'assets/img/ooze-big.png'
    @game.load.image 'grass', 'assets/img/grass.png'
    @game.load.image 'factory', 'assets/img/factory.png'
    @game.load.image 'metal', 'assets/img/metal.png'
    @game.load.image 'cyberglow', 'assets/img/cyberglow.png'


  create: ->
    @background = @game.add.sprite 0, 0, 'space'

    squareTopLeft = new Coordinates @game.world.centerX - 100, @game.world.centerY - 100
    squareBottomRight = new Coordinates @game.world.centerX + 100, @game.world.centerY + 100
    square = new Square squareTopLeft, squareBottomRight

    graphics = @game.add.graphics square.getTopLeft().x, square.getTopLeft().y

    @graphics = square.toGraphics graphics


module.exports = Test