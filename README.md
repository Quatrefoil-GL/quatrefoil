
Quatrefoil
----

> Render Three.js with Respo style code(experimental).

Demo http://repo.quamolit.org/quatrefoil.calcit/

### Shortcuts for viewport movememnt

Keyword shortcuts for viewport moving:

* `w` move forward
* `s` move backward
* `a` move left
* `d` move left
* "Up" move up
* "Down" move down
* "Shift Up" rotate to view up
* "Shift Down" rotate to view down
* "Left" rotate to view left
* "Right" rotate to view right

### Schema

* `Material`, currently `:line-basic`, `:line-dashed`, `:mesh-basic`, `:mesh-lambert`, `:mesh-standard`.

```cirru
{}
  :kind :mesh-standard
  :opacity 0.9
  :transparent true
  :roughness 0.5
  :metalness 0.9
  :color 0x9050c0
```

* `group`, takes children elements:

```cirru
group $ {}
  :position $ [] 0 0 0
  :rotation $ [] 0 0 0
  :scale $ [] 1 1 1
```

* `scene`, which refers to a global scene element:

```cirru
scene ({})
```

* `box`

```cirru
box $ {}
  :width 10
  :height 10
  :depth 10
  :material Material
  :position $ [] 0 0 0
  :rotation $ [] 0 0 0
  :scale $ [] 1 1 1
  :material Material
```

* `sphere`

```cirru
sphere $ {}
  :radius 10
  :width-segments 10
  :height-segments
  :position $ [] 0 0 0
  :rotation $ [] 0 0 0
  :scale $ [] 1 1 1
  :material Material
```

* `point-light`

```cirru
point-light $ {}
  :color $ 0xaaaaff
  :intensity $ 1
  :distance 100
  :position $ [] 0 0 0
```

* `ambient-light`

```cirru
ambient-light $ {}
  :color $ 0xaaaaff
  :intensity 1
```

* `rect-area-light`

```cirru
rect-area-light $ {}
  :color $ 0xaaaaff
  :intensity 1
  :width 100
  :height 100
  :look-at $ [] 100 100 100
  :position $ [] 0 0 0
  :rotation $ [] 0 0 0
  :scale $ [] 1 1 1
```

* `perspective-camera`

```cirru
perspective-camera $ {}
  :fov 40
  :aspect $ / js/window.innerWidth js/window.innerHeight
  :near 10
  :far 100
```

* `text`

```cirru
text $ {}
  :text |Demo
  :position $ [] 0 0 0
  :rotation $ [] 0 0 0
  :scale $ [] 1 1 1
  :material Material
```

* `line`

```cirru
line $ {}
  :lines $ [][]
    10 20 10
    100 140 0
  :position $ [] 0 0 0
  :rotation $ [] 0 0 0
  :scale $ [] 1 1 1
  :material Material
```

* `spline`

```cirru
spline $ {}
  :points $ [][]
    10 20 10
    100 140 0
  :position $ [] 0 0 0
  :rotation $ [] 0 0 0
  :scale $ [] 1 1 1
  :material Material
```

* `torus`

```cirru
torus $ {}
  :r1 10
  :r2 2
  :s1 20
  :s2 40
  :arc $ * 2 &PI
  :position $ [] 0 0 0
  :rotation $ [] 0 0 0
  :scale $ [] 1 1 1
  :material Material
```

* `tube`

```cirru
tube $ {}
  :points-fn $ fn (radio factor)
    [] (* factor radio) 0 0
  :factor 1
  :radius 0.8
  :tubular-segments 400
  :radial-segments 20
  :position $ [] 0 0 0
  :rotation $ [] 0 0 0
  :scale $ [] 1 1 1
  :material Material
```

* `shape`

```cirru
shape $ {}
  :path $ [][]
    :move-to 0 0
    :line-to 10 10
    :line-to 10 5
    :line-to 0 0
  :position $ [] 0 0 0
  :rotation $ [] 0 0 0
  :scale $ [] 1 1 1
  :material Material
```

* `polyhedron`

```cirru
polyhedron $ {}
  :vertices $ [][] (8 4 -2)
    4 9 -3
    -5 -2 -4
    4 2 8
  :indices $ [][] (0 1 2)
    0 1 3
    0 2 3
    1 2 3
  :radius 10
  :detail 0
  :position $ [] 20 10 10
  :material Material
```

* `plane-reflector`

```cirru
plane-reflector $ {}
  :width 40
  :height 40
  :color 0xffaaaa
  :position $ [] 0 0 0
  :rotation $ [] 0 0 0
```

* `parametric` for parametric geometry

```cirru
parametric $ {}
  :func $ fn (u v)
    [] 0 0 0
  :slices 10
  :stacks 10
```

* `buffer-object` based on `BufferGeometry`

and `flat-values` is a macro for turning lists into a flat one.

```cirru
buffer-object $ {}
  :vertices $ flat-values
    0 0 0
    10 0 0
    5 0 8
    5 8 0
  :indices $ flat-values
    0 1 2
    0 2 3
    1 2 3
```

### JS methods

some helpers are split in npm package:

```bash
yarn add @quamolit/quatrefoil-utils
```

### Develop

Relies on https://github.com/calcit-lang/calcit_runner.rs .

```bash
yarn
cr --emit-js -1
cp assets/* js/out/
yarn vite
```

### License

MIT
