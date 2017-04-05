Phaser = require 'Phaser'

Square      = require '../utils/geometry/square.coffee'
Polygon     = require '../utils/geometry/polygon.coffee'
Coordinates = require '../utils/coordinates.coffee'

Player = require '../player/player.coffee'

TrackManager       = require '../tracks/track-manager.coffee'
TrackManagerFlat   = require '../tracks/track-manager-flat.coffee'
TrackManagerCircle = require '../tracks/track-manager-circle.coffee'

Coin = require '../collectibles-spawner/collectibles/coin.coffee'

config      = require '../config/config.coffee'

debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

class PistePhaser extends Phaser.State
  constructor: -> super

  preload: ->
    @game.load.spritesheet 'dude', 'assets/img/dude.png'
    @game.load.spritesheet 'player', 'assets/img/player.png', 108, 140
    @game.load.image 'coin', 'assets/img/coin.png'
    @game.load.image 'bg', 'assets/img/game-background-960.jpg'

  create: ->

    nb = 5
    spriteKey = 'bg'
    sizeOut = 120
    sizeCenter = 1
    shiftCenter = 0
    oneSpriteOnly = true
    shiftOut = 35

    @trackManager = new TrackManagerFlat @game, nb, spriteKey, sizeOut, sizeCenter, shiftCenter, oneSpriteOnly, shiftOut

    @myCoin = new Coin @game, @trackManager.tracks[2]
    @trackManager.collectibleSpawnerManager.spawners[2].collectibles.push @myCoin

    @player = new Player @game, @trackManager.tracks[2], 'player', 20


  update: ->
    @trackManager.update()
    @player.collisionManager.checkCollision()

    if @input.activePointer.justPressed()
      @trackManager.destroy()
      @createRandomTrackManagerFlat()

  createRandomTrackManager: ->
    if Math.random() > 0.5
      @createRandomTrackManagerFlat()
    else
      @createRandomTrackManagerCircle()


  render: ->
    @game.debug.spriteInfo @trackManager.sprite, 32, 32


  createRandomTrackManagerFlat: ->
    nbTracks = Math.floor(Math.random() * 11) + 1
    trackSizeCenter = Math.floor(Math.random() * (350 - 150) + 150)
    trackSizeOut = Math.floor(Math.random() * (250 - 50) + 50)
    shiftCenter = Math.floor(Math.random() * (50 - 0) + 0)
    shiftOut = Math.floor(Math.random() * (350 - 0) + 0)
    centerY = @game.world.centerY + Math.random() * (25 - (-25)) + 25
    outY = @game.world.height + Math.random() * (25 - (-25)) + 25

    @trackManager = new TrackManagerFlat @game, nbTracks, trackSizeOut, trackSizeCenter, shiftCenter, shiftOut, outY, centerY


  createRandomTrackManagerCircle: ->
    # TODO

    nbTracks = Math.floor(Math.random() * 11) + 1
    trackSizeCenter = Math.floor(Math.random() * (350 - 150) + 150)
    trackSizeOut = Math.floor(Math.random() * (250 - 50) + 50)
    shiftCenter = Math.floor(Math.random() * (50 - 0) + 0)
    shiftOut = Math.floor(Math.random() * (350 - 0) + 0)
    centerY = @game.world.centerY + Math.random() * (25 - (-25)) + 25
    outY = @game.world.height + Math.random() * (25 - (-25)) + 25

    # @trackManager = new TrackManagerCircle

module.exports = PistePhaser
