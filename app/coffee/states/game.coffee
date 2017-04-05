Phaser = require 'Phaser'

TrackManager = require '../tracks/track-manager.coffee'

config      = require '../config/config.coffee'

debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

class Game extends Phaser.State
  constructor: ->
    debug 'Constructor...', @, 'info', 30, debugThemes.Phaser
    super

  preload: ->
    debug 'Preload...', @, 'info', 30, debugThemes.Phaser

    @load.pack 'game', config.pack

    @game.load.spritesheet 'dude', 'assets/img/dude.png', 32, 48

  create: ->
    debug 'Create...', @, 'info', 30, debugThemes.Phaser

    # Start physics system
    @game.physics.startSystem Phaser.Physics.ARCADE

    @background = @game.add.sprite 0, 0, 'game-background'

    @platforms = @game.add.group()
    @platforms.enableBody = true

    @ground = @platforms.create 0, @game.world.height - 64, 'game-platform'
    @ground.scale.setTo 3, 2
    @ground.body.immovable = true

    @ledge = @platforms.create 400, 400, 'game-platform'
    @ledge.scale.setTo 2, 1
    @ledge.body.immovable = true
    @ledge = @platforms.create -150, 250, 'game-platform'
    @ledge.scale.setTo 1, 1
    @ledge.body.immovable = true

    # Attach events to keys
    @ESCAPE = @game.input.keyboard.addKey Phaser.Keyboard.ESC

    # Player
    @player = @game.add.sprite 32, @game.world.height - 150, 'dude'
    @game.physics.arcade.enable @player

    @playerSpeedX = 150
    @playerSpeedY = -350

    # Nice properties
    @player.body.bounce.y = 0.2
    @player.body.gravity.y = 300

    # Collide world bounds ONE LINE
    @player.body.collideWorldBounds = true

    # Nice animations
    @player.animations.add 'left', [0, 1, 2, 3], 10, true
    @player.animations.add 'right', [5, 6, 7, 8], 10, true

    # Add cursors (arrows) input
    @cursors = @game.input.keyboard.createCursorKeys()

  update: ->
    if @ESCAPE.isDown
      @state.start 'Menu'

    hitPlatform = @game.physics.arcade.collide @player, @platforms

    @player.body.velocity.x = 0

    if @cursors.left.isDown
      @player.body.velocity.x = -@playerSpeedX
      @player.animations.play 'left'
    else if @cursors.right.isDown
      @player.body.velocity.x = @playerSpeedX
      @player.animations.play 'right'
    else
      @player.animations.stop()
      @player.frame = 4

    if @cursors.up.isDown && @player.body.touching.down && hitPlatform
      @player.body.velocity.y = @playerSpeedY

module.exports = Game
