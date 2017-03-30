Coordinates = require './coordinates.coffee'

assert = require 'assert'

class Polygon
  constructor: (coordinates...) ->
    for i in [0..coordinates.length - 1] by 1
      assert coordinates[i] instanceof Coordinates, "object specified is not of type \'Coordinates\'"

    @points = coordinates

  toString: ->
    return """
    Polygon :
      - Points :
        #{@points}
    """

module.exports = Polygon
