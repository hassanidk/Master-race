Phaser = require 'Phaser'

Square      = require '../utils/geometry/square.coffee'
Polygon     = require '../utils/geometry/polygon.coffee'
Coordinates = require '../utils/coordinates.coffee'

Degrees = require '../utils/math/degrees.coffee'

Player = require '../player/player.coffee'

TrackManager       = require '../tracks/track-manager.coffee'
TrackManagerFlat   = require '../tracks/track-manager-flat.coffee'
TrackManagerCircle = require '../tracks/track-manager-circle.coffee'

Coin = require '../collectibles-spawner/collectibles/coin.coffee'
Hole = require '../holes/hole.coffee'

Vortex = require '../vortex/vortex.coffee'

debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

class Test extends Phaser.State
  constructor: -> super


  preload: ->
    @game.load.spritesheet 'dude', 'assets/img/dude.png'
    @game.load.atlas 'player', 'assets/img/player.png', 'assets/player.json'
    @game.load.image 'coin', 'assets/img/coin.png'
    @game.load.image 'hole', 'assets/img/hole.png'
    @game.load.image 'bg', 'assets/img/game-background-960.jpg'
    @game.load.image 'space', 'assets/img/space.jpg'
    @game.load.image 'vortex', 'assets/img/cyberglow.png'
    @game.load.image 'ooze', 'assets/img/ooze-big.png'
    @game.load.image 'grass', 'assets/img/grass.png'
    @game.load.image 'factory', 'assets/img/factory.png'
    @game.load.image 'metal', 'assets/img/metal.png'
    @game.load.image 'cyberglow', 'assets/img/cyberglow.png'


  create: ->

    @background = @game.add.sprite 0, 0, 'space'

    point0 = new Coordinates @game.world.centerX - 250, @game.world.centerY - 256
    point1 = new Coordinates point0.x + 400, point0.y
    point2 = new Coordinates point0.x, point0.y + 512
    point3 = new Coordinates point1.x, point1.y + 512
    point4 = new Coordinates point1.x + 112, point1.y + 256

    shape = new Polygon point0, point1, point4, point3, point2

    ###
    something = 15.0
    ok = something.toString();
    ok = ok.concat(".0")
    console.log ok.toString()

    fragmentSrc = [
        "precision mediump float;"

        "uniform float     time;"
        "uniform vec2      resolution;"
        "uniform sampler2D iChannel0;"

        "#ifdef GL_ES"
        "precision highp float;"
        "#endif"

        "#define PI 3.1416"

        "void main( void ) {"

            "//map the xy pixel co-ordinates to be between -1.0 to +1.0 on x and y axes"
            "//and alter the x value according to the aspect ratio so it isn't 'stretched'"

            "vec2 p = (" + ok + " * gl_FragCoord.xy / resolution.xy - 1.0) * vec2(resolution.x / resolution.y, 1.0);"

            "//now, this is the usual part that uses the formula for texture mapping a ray-"
            "//traced cylinder using the vector p that describes the position of the pixel"
            "//from the centre."

            "vec2 uv = vec2(atan(p.y, p.x) * 1.0/PI, 1.0 / sqrt(dot(p, p))) * vec2(2.0, 1.0);"

            "//now this just 'warps' the texture read by altering the u coordinate depending on"
            "//the val of the v coordinate and the current time"

            "uv.x += sin(2.0 * uv.y + time * 0.5);"

            "//this divison makes the color value 'darker' into the distance, otherwise"
            "//everything will be a uniform brightness and no sense of depth will be present."

            "vec3 c = texture2D(iChannel0, uv).xyz / (uv.y * 0.5 + 1.0);"

            "gl_FragColor = vec4(c, 1.0);"

        "}"
    ]
    ###

    fragmentSrcPart1 = [
      "precision mediump float;"

      "uniform float     time;"
      "uniform vec2      resolution;"
      "uniform sampler2D iChannel0;"

      "#ifdef GL_ES"
      "precision highp float;"
      "#endif"

      "void main( void ) {"
    ]

    fragmentSrc = fragmentSrcPart1.concat(fragmentSrcPart2, fragmentSrcPart3)

    graphics = @game.add.graphics point0.x, point0.y

    @graphics = shape.toGraphics graphics

    @sprite = @game.add.sprite @game.world.centerX, @game.world.centerY, @graphics.generateTexture()
    @sprite.anchor.setTo 0.5, 0.5

    customUniforms =
        iChannel0:
          type: 'sampler2D'
          value: @sprite.texture
          textureData:
            repeat: true

    @filter = new Phaser.Filter @game, customUniforms, fragmentSrc
    @filter.setResolution @sprite.width, @sprite.height

    @sprite.filters = [ @filter ]

    @graphics.destroy()

  addPointForGlsl: (number) ->
    str = number.toString()
    if str.length >= 2 and str.substring(str.length - 2, 1) != '.'
      str = str.concat '.0'

    return str

  update: ->
    @filter.update()

module.exports = Test
