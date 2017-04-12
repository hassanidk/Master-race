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

class PistePhaser extends Phaser.State
  constructor: -> super

  preload: ->
    @game.load.spritesheet 'dude', 'assets/img/dude.png'
    @game.load.atlas 'player', 'assets/img/player.png', 'assets/player.json'
    @game.load.image 'coin', 'assets/img/coin.png'
    @game.load.image 'hole', 'assets/img/hole.png'
    @game.load.image 'bg', 'assets/img/game-background-960.jpg'
    @game.load.image 'space', 'assets/img/space.jpg'
    @game.load.image 'vortex', 'assets/img/cyberglow.png'

  create: ->

    nb = 10
    spriteKey = 'space'
    sizeOut = 120
    sizeCenter = 1
    shiftCenter = 0
    oneSpriteOnly = true
    shiftOut = 35
    outHeight = @game.world.height
    centerHeight = 200

    startAngle = new Degrees 262
    diffAngle = new Degrees 15

    startCoordsVortex = new Coordinates 0, 0

    @vortex = new Vortex @game, 'vortex', startCoordsVortex, @game.width, @game.height


    # @trackManager = new TrackManagerFlat @game, nb, spriteKey, sizeOut, sizeCenter, shiftCenter, oneSpriteOnly, shiftOut, outHeight, centerHeight
    @trackManager = new TrackManagerCircle @game, nb, spriteKey, startAngle, diffAngle, sizeCenter, shiftCenter, oneSpriteOnly

    @myCoin = new Coin @game, @trackManager.tracks[2]
    @trackManager.collectibleSpawnerManager.spawners[2].collectibles.push @myCoin

    # @myHole = new Hole @game, @trackManager.tracks[2]
    # @trackManager.holeSpawnerManager.spawnersHole[2].holes.push @myHole

    @player = new Player @game, @trackManager.tracks[0], 'player', 20, 0.6


  update: ->
    @trackManager.update()
    @player.collisionManager.checkCollision()

    @vortex.update()

    if @input.activePointer.justPressed()
      @trackManager.destroy()
      @createRandomTrackManagerFlat()


  createRandomTrackManager: ->
    if Math.random() > 0.5
      @createRandomTrackManagerFlat()
    else
      @createRandomTrackManagerCircle()


  render: ->
    # @game.debug.spriteInfo @trackManager.sprite, 32, 32


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
