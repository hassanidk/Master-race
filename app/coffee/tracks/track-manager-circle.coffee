Phaser = require 'Phaser'
assert = require 'assert'

Track        = require './track.coffee'
TrackManager = require './track-manager.coffee'

config      = require '../config/config.coffee'

colors      = require '../utils/colors.coffee'
debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

class TrackManagerCircle extends TrackManager
  constructor: (game, nbTracks, trackSizeOut, trackSizeCenter, shiftCenter=0) ->
    debug 'Constructor...', @, 'info', 30, debugThemes.Tracks

    super(game, nbTracks, trackSizeOut, trackSizeCenter, shiftCenter)

    @game = game
    @graphics = @game.add.graphics @game.world.centerX, @game.world.centerY

    @halfSize = @trackSize / 2
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
    @graphics.lineTo -@halfWidth + @trackSize, -@halfHeight
    @graphics.lineTo -@halfWidth - @trackSize, -@halfHeight
    @graphics.endFill()

    @graphics.moveTo 0, 0
    @graphics.beginFill colors[5]
    @graphics.lineTo -@halfWidth + @trackSize, @halfHeight
    @graphics.lineTo -@halfWidth - @trackSize, @halfHeight
    @graphics.endFill()

    @graphics.moveTo 0, 0
    @graphics.beginFill colors[6]
    @graphics.lineTo @halfWidth + @trackSize, -@halfHeight
    @graphics.lineTo @halfWidth - @trackSize, -@halfHeight
    @graphics.endFill()

    @graphics.moveTo 0, 0
    @graphics.beginFill colors[7]
    @graphics.lineTo @halfWidth + @trackSize, @halfHeight
    @graphics.lineTo @halfWidth - @trackSize, @halfHeight
    @graphics.endFill()

    ok = @game.add.sprite 0, 0, 'bg'
    ok.mask = @graphics

  toString: ->
    debug 'ToString...', @, 'info', 3000, debugThemes.Tracks

    return """
    #{super}
    TrackManagerCircle :
    """

module.exports = TrackManagerCircle
