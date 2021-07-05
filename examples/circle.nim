import shadytoy, shady, chroma, vmath

proc circle(gl_FragColor: var Color, uv: Vec2) =
  if uv.length < 400:
    gl_FragColor = color(1, 1, 1, 1)
  else:
    gl_FragColor = color(0, 0, 0, 1)

proc circleSmooth(gl_FragColor: var Color, uv: Vec2) =
  var a = 0.0
  for x in 0 ..< 8:
    for y in 0 ..< 8:
      if (uv + vec2(x.float32 - 4.0, y.float32 - 4.0) / 8.0).length < 400.0:
        a += 1
  a = a / (8 * 8)
  gl_FragColor = color(a, a, a, 1)

# test on the CPU:
var testColor: Color
circleSmooth(testColor, vec2(100, 100))
echo testColor


var shader = toShader(circleSmooth)
echo shader

run("Circle", shader)