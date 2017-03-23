Phaser = require 'Phaser'
config = require './config.coffee'

class Piste extends Phaser.State
  constructor: -> super

  preload: ->
    @game.load.spritesheet 'dude', 'assets/img/dude.png'

  create: ->
    @graphics = @game.add.graphics @game.world.centerX, @game.world.centerY

    @nbPistes = 9
    @decalageTop = 10
    @decalageBottom = 50
    @size = 400

    @nbPistesHalf = @nbPistes / 2

    @graphics.moveTo -(@nbPistesHalf * @decalageTop), 0

    # Colors
    colors = [0xffd900, 0xff0000, 0x00ff00, 0x0000ff, 0xff00ff, 0x00ffff, 0xdfdf00, 0x1023aa, 0xaa00aa]

    cmpt = 0
    pointX = -@nbPistesHalf * (@size + @decalageBottom) + @decalageBottom / 2

    while cmpt < @nbPistes
      console.log "Iter " + cmpt
      console.log pointX
      console.log pointX + @size

      @graphics.moveTo 10, 0
      @graphics.beginFill colors[cmpt]
      @graphics.lineTo pointX, @game.world.height / 2
      @graphics.lineTo pointX + @size, @game.world.height / 2
      @graphics.endFill()

      pointX += @size + @decalageBottom
      cmpt += 1

    getRandomColor: ->


module.exports = Piste
