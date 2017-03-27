Phaser = require 'Phaser'
assert = require 'assert'

Track  = require './track.coffee'
TrackStyles = require './track-styles.coffee'
debug = require './debug.coffee'
debugThemes = require './debug-themes.coffee'
config = require './config.coffee'

class TrackManager
  constructor: (trackStyle) ->
    assert trackStyle in TrackStyles.enums, "trackStyle is not an enum"

    # TODO

    # Example of debug
    debug 'Hello', 'log', debugThemes.Other

module.exports = TrackManager
