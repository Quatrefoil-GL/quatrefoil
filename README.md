
Quatrefoil
----

> Render Three.js with Respo style code(experimental).

Demo http://repo.quamolit.org/quatrefoil.calcit/

### Patching operations

* [x] `add-element`
* [x] `remove-element`
* [x] `replace-element`
* [x] `add-children`
* [x] `remove-children`
* [x] `add-material`
* [x] `update-material`
* [ ] `replace-material`
* [ ] `remove-material`
* [x] `add-params`(partial)
* [x] `update-params`
* [ ] `remove-params`
* [ ] `add-events`
* [ ] `remove-events`

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

### Develop

Relies on https://github.com/calcit-lang/calcit_runner.rs .

```bash
yarn
calcit_runner --emit-js -1
cp assets/* js/out/
yarn vite
```

### License

MIT
