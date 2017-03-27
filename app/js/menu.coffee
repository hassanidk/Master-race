Phaser = require 'Phaser'

TrackManager = require './track-manager.coffee'
TrackStyles = require './track-styles.coffee'
config = require './config.coffee'

class Menu extends Phaser.State
  constructor: -> super

  preload: ->
    @load.pack 'menu', config.pack

  create: ->
    # TODO

    @trackManager = new TrackManager(TrackStyles.Flat)

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
    if @soundEnabled then @disableSound() else @enableSound()

  disableSound: ->
    console.log "DISABLE"

  enableSound: ->
    console.log "ENABLE"

module.exports = Menu
