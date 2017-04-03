Coordinates = require '../coordinates.coffee'

assert = require 'assert'

class Polygon

  @Lerp: (polyA, polyB) ->
    assert polyA instanceof Polygon, "PolyA is not a Polygon"
    assert polyB instanceof Polygon, "PolyB is not a Polygon"

    


  constructor: (coordinates...) ->
    for i in [0..coordinates.length - 1] by 1
      assert coordinates[i] instanceof Coordinates, "object specified is not of type \'Coordinates\'"

    @points = coordinates


  getPoint: (i) ->
    assert i >= 0 and i <  @points.length, "Polygon: Point n°" + i + "is out of bounds"
    return @points[i]


  getMiddlePoint: () ->
    sumX = 0
    sumY = 0
    nbPoints = @points.length

    for point in @points
      sumX += point.x
      sumY += point.y

    return new Coordinates sumX / nbPoints, sumY / nbPoints


  toString: ->
    return """
    Polygon :
      - Points :
        #{@points}
    """

module.exports = Polygon
