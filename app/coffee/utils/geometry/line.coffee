Polygon = require './polygon.coffee'

Coordinates = require '../coordinates.coffee'

assert = require 'assert'

class Line extends Polygon
  constructor: (pointA, pointB) ->
    assert pointA instanceof Coordinates, "PointA is not Coordinates"
    assert pointB instanceof Coordinates, "PointB is not Coordinates"

    super pointA, pointB

  getPointA: ->
    return @points[0]

  getPointB: ->
    return @points[1]

  toString: ->
    return """
    Line :
      - Point A :
      #{@getPointA().toString()}
      - Point B :
      #{@getPointB().toString()}
    """

module.exports = Line
