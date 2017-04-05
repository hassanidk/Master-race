Coordinates = require '../coordinates.coffee'

assert = require '../assert.coffee'

class Polygon

  constructor: (coordinates...) ->
    for i in [0..coordinates.length - 1] by 1
      assert coordinates[i] instanceof Coordinates, "object specified is not of type \'Coordinates\'"

    @points = coordinates


  getPoint: (i) ->
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
