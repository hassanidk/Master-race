Phaser = require 'Phaser'

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
    @game.load.image 'bg', 'assets/img/game-background-960.jpg'

  create: ->

    @nbPistes = 9
    @decalageTop = 0
    @decalageBottom = 100
    @size = 150

    # trackManager = new TrackManagerFlat(@game, 5, 150)
    trackManager = new TrackManagerCircle(@game, 5, 150)

    @nbPistesHalf = @nbPistes / 2

    # Colors
    colors = [0xffd900, 0xff0000, 0x00ff00, 0x0000ff, 0xff00ff, 0x00ffff, 0xdfdf00, 0x1023aa, 0xaa00aa]

    # Si les pistes sont plates
    """
    cmpt = 0
    pointX = -@nbPistesHalf * (@size + @decalageBottom) + @decalageBottom / 2

    @graphics = @game.add.graphics @game.world.centerX, @game.world.centerY
    @graphics.moveTo -(@nbPistesHalf * @decalageTop), 0

    while cmpt < @nbPistes
      @graphics.moveTo 10, 0

      if cmpt >= colors.length
        color = colors[colors.length - 1]
      else
        color = colors[cmpt]

      @graphics.beginFill color
      @graphics.lineTo pointX, @game.world.height / 2
      @graphics.lineTo pointX + @size, @game.world.height / 2
      @graphics.endFill()

      pointX += @size + @decalageBottom
      cmpt += 1

    # @sprite = @game.add.sprite @game.world.centerX, @game.world.centerY, @graphics.generateTexture()
    # @sprite.anchor.set 0.5, 0
    """

    """
    # Si les pistes forment un cercle
    @graphics = @game.add.graphics @game.world.centerX, @game.world.centerY

    @halfSize = @size / 2
    @halfWidth = @game.world.width / 2
    @halfHeight = @game.world.height / 2

    @graphics.moveTo 0, 0
    @graphics.beginFill colors[0]
    @graphics.lineTo -@halfSize, @halfHeight
    @graphics.lineTo @halfSize, @halfHeight
    @graphics.endFill()

    @graphics.moveTo 0, 0
    @graphics.beginFill colors[1]
    @graphics.lineTo -@halfSize, -@halfHeight
    @graphics.lineTo @halfSize, -@halfHeight
    @graphics.endFill()

    @graphics.moveTo 0, 0
    @graphics.beginFill colors[2]
    @graphics.lineTo -@halfWidth, -@halfSize
    @graphics.lineTo -@halfWidth, @halfSize
    @graphics.endFill()

    @graphics.moveTo 0, 0
    @graphics.beginFill colors[3]
    @graphics.lineTo @halfWidth, -@halfSize
    @graphics.lineTo @halfWidth, @halfSize
    @graphics.endFill()

    @graphics.moveTo 0, 0
    @graphics.beginFill colors[4]
    @graphics.lineTo -@halfWidth + @size, -@halfHeight
    @graphics.lineTo -@halfWidth - @size, -@halfHeight
    @graphics.endFill()

    @graphics.moveTo 0, 0
    @graphics.beginFill colors[5]
    @graphics.lineTo -@halfWidth + @size, @halfHeight
    @graphics.lineTo -@halfWidth - @size, @halfHeight
    @graphics.endFill()

    @graphics.moveTo 0, 0
    @graphics.beginFill colors[6]
    @graphics.lineTo @halfWidth + @size, -@halfHeight
    @graphics.lineTo @halfWidth - @size, -@halfHeight
    @graphics.endFill()

    @graphics.moveTo 0, 0
    @graphics.beginFill colors[7]
    @graphics.lineTo @halfWidth + @size, @halfHeight
    @graphics.lineTo @halfWidth - @size, @halfHeight
    @graphics.endFill()
    """

    # @sprite = @game.add.sprite 0, 0, 'bg'
    # @sprite.mask = @graphics


  """
  update: ->
    @sprite.rotation += 0.01
  """

module.exports = PistePhaser
