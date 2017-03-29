Phaser = require 'Phaser'

TrackManager = require './track-manager.coffee'

config = require './config.coffee'
debug  = require './debug.coffee'
debugThemes = require './debug-themes.coffee'

class Menu extends Phaser.State
  constructor: ->
    debug 'Constructor...', @, 'info', 30, debugThemes.Phaser
    super

  preload: ->
    debug 'Preload...', @, 'info', 30, debugThemes.Phaser
    @load.pack 'menu', config.pack

  create: ->
    debug 'Create...', @, 'info', 30, debugThemes.Phaser

    @state.start 'Piste'

    # Set game background
    @game.add.tileSprite 0, 0, config.width, config.height, 'menu-background'

    @soundEnabled = true

    # Set sound button
    @buttonSound = @game.add.sprite @game.world.centerX, @game.world.centerY, 'soundOn'
    @buttonSound.anchor.setTo 1, 0
    @buttonSound.inputEnabled = true
    @buttonSound.events.onInputDown.add @toggleSound, @

    @textStart = 'Cliquez pour commencer'

    @game.add.text(@game.world.centerX - 275, @game.world.centerY - 50, @textStart, { font: "50px Helvetica", fill: "#00CA39" })

  # Ici, update est la pour 'montrer que ça marche'
  update: ->
    # Si on clique ...
    if @input.activePointer.justPressed()
      @state.start 'Piste'

  toggleSound: ->
    debug 'ToggleSound...', @, 'info', 50, debugThemes.Phaser
    if @soundEnabled then @disableSound() else @enableSound()

  disableSound: ->
    debug 'Disable Sound...', @, 'info', 50, debugThemes.Phaser
    console.log "DISABLE"

  enableSound: ->
    debug 'Enable Sound...', @, 'info', 50, debugThemes.Phaser
    console.log "ENABLE"

module.exports = Menu
