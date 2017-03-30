class Coordinates
  constructor: (x, y) ->
    @x = x
    @y = y

  toString: ->
    return """
    Coordinates :
      - x : #{@x}
      - y : #{@y}
    """

module.exports = Coordinates
