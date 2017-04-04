Phaser = require 'Phaser'
assert = require '../utils/assert.coffee'

Coordinates = require '../utils/coordinates.coffee'

config      = require '../config/config.coffee'

debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

Track = require './track-coffee'

class TrackAnimated extends Track
  constructor: (game, num, topLeft, bottomLeft, topRight, bottomRight) ->
    super game, numn topLeft, bottomLeft, topRight, bottomRight

    # TODO
    # Add a dynamic / animated sprite (tilesprite)

module.exports = TrackStatic
