assert = require 'assert'

class Coordinates


  @Assert2Coords: (coordsA, coordsB) ->
    assert coordsA instanceof Coordinates, "CoordsA is not coordinates"
    assert coordsB instanceof Coordinates, "CoordsB is not coordinates"

  @GetMiddle: (coordsA, coordsB) ->
    Coordinates.Assert2Coords coordsA, coordsB
    return new Coordinates (coordsA.x + coordsB.x) / 2, (coordsA.y + coordsB.y) / 2


  @Add: (coordsA, coordsB) ->
    Coordinates.Assert2Coords coordsA, coordsB
    return new Coordinates coordsA.x + coordsB.x, coordsA.y + coordsB.y


  @Sub: (coordsA, coordsB) ->
    Coordinates.Assert2Coords coordsA, coordsB
    return new Coordinates coordsA.x - coordsB.x, coordsA.y - coordsB.y


  @Mult: (coordsA, coordsB) ->
    Coordinates.Assert2Coords coordsA, coordsB
    return new Coordinates coordsA.x * coordsB.x, coordsA.y * coordsB.y


  @Divide: (coordsA, coordsB) ->
    Coordinates.Assert2Coords coordsA, coordsB
    return new Coordinates coordsA.x / coordsB.x, coordsA.y / coordsB.y


  constructor: (x, y) ->
    @x = x
    @y = y


  mult: (factor) ->
    @x *= factor
    @y *= factor


  divide: (factor) ->
    @x /= factor
    @y /= factor


  clone: ->
    return new Coordinates @x, @y


  toString: ->
    return """
    Coordinates :
      - x : #{@x}
      - y : #{@y}
    """

module.exports = Coordinates
