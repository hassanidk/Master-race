Phaser = require 'Phaser'

Square = require './square.coffee'
Polygon = require './polygon.coffee'
Coordinates = require './coordinates.coffee'
Player = require './player.coffee'
TrackManager = require './track-manager.coffee'
TrackManagerFlat = require './track-manager-flat.coffee'
TrackManagerCircle = require './track-manager-circle.coffee'

config = require './config.coffee'
debug  = require './debug.coffee'
debugThemes = require './debug-themes.coffee'

class PistePhaser extends Phaser.State
  constructor: -> super

  preload: ->
    @game.load.spritesheet 'dude', 'assets/img/dude.png'
    @game.load.spritesheet 'player', 'assets/img/player.png', 108, 140
    @game.load.image 'bg', 'assets/img/game-background-960.jpg'

  create: ->

    @nbPistes = 9
    @decalageTop = 0
    @decalageBottom = 100
    @size = 150

    @trackManager = new TrackManagerFlat @game, 5, 150, 150, 20, 20
    # trackManager = new TrackManagerCircle(@game, 5, 150)

    square = new Square(new Coordinates(25, 25), new Coordinates(50, 50))
    # console.log square.toString()

    polygon = new Polygon(square.getTopLeft(), square.getBottomLeft())
    # console.log polygon.toString()

    @player = new Player(@game, @game.world.centerX, @game.world.height - 70, 'player', 20)

  update: ->
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
