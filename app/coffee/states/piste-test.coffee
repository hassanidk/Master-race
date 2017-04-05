Phaser = require 'Phaser'

Square      = require '../utils/geometry/square.coffee'
Polygon     = require '../utils/geometry/polygon.coffee'
Coordinates = require '../utils/coordinates.coffee'

Player = require '../player/player.coffee'

TrackManager       = require '../tracks/track-manager.coffee'
TrackManagerFlat   = require '../tracks/track-manager-flat.coffee'
TrackManagerCircle = require '../tracks/track-manager-circle.coffee'

Coin = require '../collectibles-spawner/collectibles/coin.coffee'
Hole = require '../holes/hole.coffee'

config      = require '../config/config.coffee'

debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

class PistePhaser extends Phaser.State
  constructor: -> super

  preload: ->
    @game.load.spritesheet 'dude', 'assets/img/dude.png'
    @game.load.spritesheet 'player', 'assets/img/player.png', 108, 140
    @game.load.image 'coin', 'assets/img/coin.png'
    @game.load.image 'hole', 'assets/img/hole.png'
    @game.load.image 'bg', 'assets/img/game-background-960.jpg'

  create: ->

    @nbPistes = 9
    @decalageTop = 0
    @decalageBottom = 100
    @size = 150


    # @trackManager = new TrackManagerFlat @game, 5, 150, 150, 20, 20
    @trackManager = new TrackManagerFlat @game, 5, 120, 1, 0, 35
    # @trackManager = new TrackManagerCircle(@game, 5, 150)

    @myCoin = new Coin @game, @trackManager.tracks[2]
    @myHole = new Hole @game, @trackManager.tracks[2]
    @trackManager.holeSpawnerManager.spawnersHole[2].holes.push @myHole
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
