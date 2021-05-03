
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
