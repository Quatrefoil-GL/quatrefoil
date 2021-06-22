
{} (:package |quatrefoil)
  :configs $ {} (:init-fn |quatrefoil.app.main/main!) (:reload-fn |quatrefoil.app.main/reload!)
    :modules $ [] |touch-control/
    :version |0.0.3
  :files $ {}
    |quatrefoil.app.comp.portal $ {}
      :ns $ quote
        ns quatrefoil.app.comp.portal $ :require
          quatrefoil.alias :refer $ group box sphere text
          quatrefoil.core :refer $ defcomp
      :defs $ {}
        |comp-portal $ quote
          defcomp comp-portal (on-change)
            group ({})
              comp-tab :todolist |Todolist ([] -40 30 0) on-change
              comp-tab :demo |Demo ([] 0 30 0) on-change
              comp-tab :lines |Lines ([] 0 15 0) on-change
              comp-tab :shapes |Shapes ([] -40 15 0) on-change
              comp-tab :multiply |Multiply ([] -40 0 0) on-change
              comp-tab :triflorum |Triflorum ([] 0 0 0) on-change
              comp-tab :mirror "\"Mirror.. <3" ([] -40 -15 0) on-change
        |comp-tab $ quote
          defcomp comp-tab (k title position on-change)
            box
              {} (:width 16) (:height 4) (:depth 6) (:position position)
                :material $ {} (:kind :mesh-lambert) (:color 0xccc80) (:opacity 0.6) (:transparent true)
                :event $ {}
                  :click $ fn (e d!) (on-change k d!)
              text $ {} (:text title) (:size 4) (:height 1)
                :position $ [] 0 0 4
                :material $ {} (:kind :mesh-lambert) (:color 0xffcccc) (:opacity 0.9) (:transparent true)
      :proc $ quote ()
    |quatrefoil.alias $ {}
      :ns $ quote
        ns quatrefoil.alias $ :require
          quatrefoil.schema :refer $ Shape Component comp? shape?
      :defs $ {}
        |point-light $ quote
          defn point-light (props & children) (create-element :point-light props children)
        |buffer-object $ quote
          defn buffer-object (props & children) (create-element :buffer-object props children)
        |create-element $ quote
          defn create-element (el-name props children)
            %{} Shape (:name el-name)
              :params $ -> props (dissoc :material) (dissoc :event) (dissoc :position) (dissoc :scale) (dissoc :rotation)
              :position $ :position props
              :scale $ :scale props
              :material $ :material props
              :rotation $ :rotation props
              :event $ :event props
              :children $ arrange-children children
        |perspective-camera $ quote
          defn perspective-camera (props & children) (create-element :perspective-camera props children)
        |shape $ quote
          defn shape (props & children) (create-element :shape props children)
        |group $ quote
          defn group (props & children) (create-element :group props children)
        |arrange-children $ quote
          defn arrange-children (children)
            let
                cursor $ first children
                result $ if
                  and
                    = 1 $ count children
                    not $ or (comp? cursor) (shape? cursor)
                  , cursor
                    -> children
                      map-indexed $ fn (idx p) ([] idx p)
                      pairs-map
              ; .log js/console "|Handle children:" children result
              , result
        |polyhedron $ quote
          defn polyhedron (props & children) (create-element :polyhedron props children)
        |parametric $ quote
          defn parametric (props & children) (create-element :parametric props children)
        |camera $ quote
          defn camera (props & children) (create-element :camera props children)
        |box $ quote
          defn box (props & children) (create-element :box props children)
        |ambient-light $ quote
          defn ambient-light (props & children) (create-element :ambient-light props children)
        |spline $ quote
          defn spline (props & children) (create-element :spline props children)
        |rect-area-light $ quote
          defn rect-area-light (props & children) (create-element :rect-area-light props children)
        |text $ quote
          defn text (props & children) (create-element :text props children)
        |plane-reflector $ quote
          defn plane-reflector (props & children) (create-element :plane-reflector props children)
        |flat-values $ quote
          defmacro flat-values (& points)
            &let
              chunk $ &list:concat & points
              quasiquote $ [] ~@chunk
        |line $ quote
          defn line (props & children) (create-element :line props children)
        |tube $ quote
          defn tube (props & children) (create-element :tube props children)
        |sphere $ quote
          defn sphere (props & children) (create-element :sphere props children)
        |torus $ quote
          defn torus (props & children) (create-element :torus props children)
        |scene $ quote
          defn scene (props & children) (create-element :scene props children)
      :proc $ quote ()
    |quatrefoil.globals $ {}
      :ns $ quote
        ns quatrefoil.globals $ :require ("\"three" :as THREE)
      :defs $ {}
        |*global-tree $ quote (defatom *global-tree nil)
        |*global-renderer $ quote (defatom *global-renderer nil)
        |*global-camera $ quote (defatom *global-camera nil)
        |*proxied-dispatch $ quote (defatom *proxied-dispatch nil)
        |*viewer-angle $ quote
          defatom *viewer-angle $ &/ &PI 2
        |*viewer-y-shift $ quote (defatom *viewer-y-shift 0)
        |*global-scene $ quote
          defatom *global-scene $ new THREE/Scene
      :proc $ quote ()
      :configs $ {}
    |quatrefoil.app.comp.todolist $ {}
      :ns $ quote
        ns quatrefoil.app.comp.todolist $ :require
          quatrefoil.alias :refer $ group box sphere point-light perspective-camera scene text
          quatrefoil.core :refer $ defcomp
      :defs $ {}
        |comp-todolist $ quote
          defcomp comp-todolist (tasks)
            group ({})
              group
                {} $ :position ([] 0 30 0)
                box $ {} (:width 40) (:height 6) (:depth 1)
                  :material $ {} (:kind :mesh-lambert) (:color 0xffaaaa) (:opacity 0.9) (:transparent true)
                  :event $ {}
                    :click $ fn (e d!)
                      d! :add-task $ js/prompt "|Task content?"
              group
                {} $ :position ([] 0 20 0)
                -> (vals tasks)
                  map-indexed $ fn (idx task)
                    [] (:id task) (comp-task task idx)
                  pairs-map
        |comp-task $ quote
          defcomp comp-task (task idx)
            group
              {} $ :position
                [] 0 (* idx -8) 0
              sphere $ {} (:radius 2)
                :position $ [] -30 0 0
                :material $ {} (:kind :mesh-lambert) (:opacity 0.8) (:transparent true)
                  :color $ if (:done? task) 0x905055 0x9050ff
                :event $ {}
                  :click $ fn (event dispatch!)
                    dispatch! :toggle-task $ :id task
              box
                {} (:width 40) (:height 4) (:depth 1)
                  :material $ {} (:kind :mesh-lambert) (:color 0xcccccc) (:opacity 0.6) (:transparent true)
                  :event $ {}
                    :click $ fn (event dispatch!)
                      dispatch! :edit-task $ [] (:id task)
                        js/prompt "|New task:" $ :text task
                text $ {}
                  :text $ :text task
                  :size 3
                  :height 1
                  :position $ [] -10 0 0
                  :material $ {} (:kind :mesh-lambert) (:color 0xffcccc) (:opacity 0.8) (:transparent true)
              sphere $ {} (:radius 2)
                :position $ [] 30 0 0
                :material $ {} (:kind :mesh-lambert) (:opacity 0.8) (:color 0xff5050) (:transparent true)
                :event $ {}
                  :click $ fn (event dispatch!)
                    dispatch! :delete-task $ :id task
      :proc $ quote ()
    |quatrefoil.app.comp.lines $ {}
      :ns $ quote
        ns quatrefoil.app.comp.lines $ :require
          quatrefoil.alias :refer $ group box sphere text line spline tube
          quatrefoil.core :refer $ defcomp
      :defs $ {}
        |comp-lines $ quote
          defcomp comp-lines () $ group ({})
            text $ {} (:text |Lines) (:size 4) (:height 1)
              :position $ [] 0 0 4
              :material $ {} (:kind :mesh-lambert) (:color 0xffcccc) (:opacity 0.9) (:transparent true)
            line $ {}
              :points $ [] ([] 0 0 0) ([] 3 3 4) ([] 1 4 6) ([] -2 8 0) ([] 2 5 1)
              :position $ [] 0 0 0
              :material $ {} (:kind :line-dashed) (:color 0xaaaaff) (:opacity 0.9) (:transparent true) (:linewidth 4) (:gapSize 0.5) (:dashSize 0.5)
            spline $ {}
              :points $ [] ([] 10 10 0) ([] 8 0 0) ([] 18 0 0) ([] 19 6 4) ([] 15 6 4) ([] 13 8 0) ([] 12 5 1)
              :position $ [] 0 0 0
              :material $ {} (:kind :line-dashed) (:color 0xaaaaff) (:opacity 0.9) (:transparent true) (:linewidth 4) (:gapSize 1) (:dashSize 1)
            tube $ {} (:points-fn tube-fn) (:radius 0.8) (:tubular-segments 400) (:radial-segments 20)
              :position $ [] -10 0 0
              :material $ {} (:kind :mesh-standard) (:color 0xcccc77) (:opacity 1) (:transparent true)
        |tube-fn $ quote
          defn tube-fn (t factor)
            []
              *
                + 2 $ * t 20
                sin $ * 40 t
              * 30 t
              *
                + 2 $ * t 20
                cos $ * 40 t
      :proc $ quote ()
      :configs $ {}
    |quatrefoil.app.comp.multiply $ {}
      :ns $ quote
        ns quatrefoil.app.comp.multiply $ :require
          quatrefoil.alias :refer $ group box sphere text line tube
          quatrefoil.core :refer $ defcomp
          quatrefoil.math :refer $ q* &q* v-scale q+ invert
          quatrefoil.app.materials :refer $ cover-line
      :defs $ {}
        |comp-multiply $ quote
          defcomp comp-multiply () $ group ({})
            line $ {}
              :points $ [] ([] -100 0 0) zero-point ([] 100 0 0) zero-point ([] 0 100 0) zero-point ([] 0 -100 0)
              :material cover-line
            line $ {}
              :points $ [][] (0 0 200) (0 0 -200)
              :material $ assoc cover-line :color 0xffff99
            , &
              identity $ concat &
                -> (range 4)
                  map $ fn (idx)
                    let
                        points $ calc-points
                          q+ ([] 8 5 0 0)
                            v-scale ([] 0 0 2 0) idx
                          , multiplier
                      []
                        group ({}) & $ -> points
                          map-indexed $ fn (idx p)
                            comp-point p $ = 0 idx
                        line $ {} (:points points)
                          :position $ [] 0 0 0
                          :material $ {} (:kind :line-dashed) (:color 0xaaaaff) (:opacity 1) (:transparent false)
              , &
                identity $ let
                    inverted-p $ invert multiplier
                    p0 $ q+ ([] 8 5 0 0)
                      v-scale ([] 0 0 6 0) 1
                    p1 $ &q* multiplier p0
                    p2 $ &q* p1 inverted-p
                    points $ [] p0 p1 p2
                  []
                    group ({}) & $ -> points
                      map-indexed $ fn (idx p)
                        comp-point p $ = 0 idx
                    line $ {} (:points points)
                      :position $ [] 0 0 0
                      :material $ {} (:kind :line-dashed) (:color 0xaaaaff) (:opacity 1) (:transparent false)
                ; sphere $ {} (:radius 40)
                  :position $ [] 0 0 0
                  :material $ {} (:kind :mesh-basic) (:opacity 0.2) (:transparent true) (:color 0xcccc88)
                comp-point (v-scale multiplier 10) true
                box $ {} (:width 40) (:height 40) (:depth 0.04)
                  :position $ [] 0 0 6
                  :material $ {} (:kind :mesh-lambert) (:color 0x808080) (:opacity 0.4) (:transparent true)
        |zero-point $ quote
          def zero-point $ [] 0 0 0
        |comp-point $ quote
          defcomp comp-point (position first?)
            group ({})
              sphere $ {} (:radius 0.5) (:position position)
                :material $ {} (:kind :mesh-standard) (:opacity 0.6) (:transparent true)
                  :color $ if first? 0xffaa88 0xcc88cc
              tube $ {} (:points-fn w-hint-fn)
                :factor $ last position
                :radius 0.1
                :tubularSegments 400
                :radialSegments 20
                :position position
                :material $ {} (:kind :mesh-standard) (:color 0xdd0088) (:opacity 0.6) (:transparent false)
        |w-hint-fn $ quote
          defn w-hint-fn (ratio factor)
            [] 0 (* ratio factor) 0
        |multiplier $ quote
          def multiplier $ let
              x 0
              y 0
              w 0.6
              rest-space $ - 1 (pow x 2) (pow y 2) (pow w 2)
              z_ $ if (>= rest-space 0) (sqrt rest-space) 0
            w-log $ [] x y z_ w
        |calc-points $ quote
          defn calc-points (p0 next)
            apply-args
                []
                , p0 12
              fn (acc p n)
                if (<= n 0) acc $ recur (conj acc p) (&q* next p) (dec n)
      :proc $ quote ()
      :configs $ {}
    |quatrefoil.cursor $ {}
      :ns $ quote (ns quatrefoil.cursor)
      :defs $ {}
        |update-states $ quote
          defn update-states (store pair)
            let[] (cursor new-state) pair $ assoc-in store
              concat ([] :states) cursor $ [] :data
              , new-state
      :proc $ quote ()
      :configs $ {}
    |quatrefoil.dsl.object3d-dom $ {}
      :ns $ quote
        ns quatrefoil.dsl.object3d-dom $ :require
          quatrefoil.util.core :refer $ purify-tree collect-children find-element scale-zero
          "\"three" :as THREE
          quatrefoil.globals :refer $ *global-renderer *global-camera *global-scene *global-tree *proxied-dispatch
          "\"./make-curve" :refer $ makeCurve createMultiMaterialMesh
          "\"three/examples/jsm/helpers/RectAreaLightHelper" :refer $ RectAreaLightHelper
          "\"three/examples/jsm/objects/Reflector" :refer $ Reflector
      :defs $ {}
        |create-perspective-camera $ quote
          defn create-perspective-camera (params position)
            let
                fov $ :fov params
                aspect $ :aspect params
                near $ :near params
                far $ :far params
                object3d $ new THREE/PerspectiveCamera fov aspect near far
              set-position! object3d position
              reset! *global-camera object3d
              , object3d
        |set-position! $ quote
          defn set-position! (object position)
            if (some? position)
              let[] (x y z) position $ .set (.-position object) x y z
        |create-sphere-element $ quote
          defn create-sphere-element (params position rotation scale material event coord)
            let
                geometry $ new THREE/SphereGeometry
                  or (:radius params) 8
                  or (:width-segments params) 12
                  or (:height-segments params) 12
                object3d $ new THREE/Mesh geometry (create-material material)
              set-position! object3d position
              set-rotation! object3d rotation
              set-scale! object3d scale
              set! (.-coord object3d) coord
              set! (.-castShadow object3d) true
              set! (.-receiveShadow object3d) true
              ; .log js/console |Sphere: object3d
              , object3d
        |create-box-element $ quote
          defn create-box-element (params position rotation scale material event coord)
            let
                geometry $ new THREE/BoxGeometry (:width params) (:height params) (:depth params)
                object3d $ new THREE/Mesh geometry (create-material material)
              set-position! object3d position
              set-rotation! object3d rotation
              set-scale! object3d scale
              set! (.-castShadow object3d) true
              set! (.-receiveShadow object3d) true
              set! (.-coord object3d) coord
              , object3d
        |create-torus-element $ quote
          defn create-torus-element (params position rotation scale material)
            let
                geometry $ ->
                  new THREE/TorusGeometry (:r1 params) (:r2 params) (:s1 params) (:s2 params) (:arc params)
                object3d $ new THREE/Mesh geometry (create-material material)
              set! (.-castShadow object3d) true
              set! (.-receiveShadow object3d) true
              set-position! object3d position
              set-scale! object3d scale
              , object3d
        |create-spline-element $ quote
          defn create-spline-element (params position rotation scale material)
            let
                points0 $ :points params
                curve $ new THREE/CatmullRomCurve3
                  js-array & $ -> points0
                    map $ fn (p) (new THREE/Vector3 & p)
                points $ .getPoints curve
                  * 16 $ count points0
                geometry $ -> (new THREE/BufferGeometry) (.setFromPoints points)
                object3d $ new THREE/Line geometry (create-material material)
              set! (.-castShadow object3d) true
              set! (.-receiveShadow object3d) true
              set-position! object3d position
              set-rotation! object3d rotation
              set-scale! object3d scale
              , object3d
        |create-rect-area-light $ quote
          defn create-rect-area-light (params position rotation)
            let
                color $ :color params
                intensity $ :intensity params
                width $ :width params
                height $ :height params
                look-at $ :look-at params
                object3d $ new THREE/RectAreaLight color intensity width height
              .lookAt object3d & look-at
              set! (.-castShadow object3d) true
              set-position! object3d position
              set-rotation! object3d rotation
              ; js/console.log "|Area Light:" object3d
              .add object3d $ new RectAreaLightHelper object3d
              , object3d
        |create-buffer-object-element $ quote
          defn create-buffer-object-element (params position rotation scale material)
            let
                vertices $ new js/Float32Array
                  js-array & $ either (:vertices params) ([])
                indices $ js-array &
                  either (:indices params) ([])
                geometry $ new THREE/BufferGeometry
                object3d $ do
                  .setAttribute geometry "\"position" $ new THREE/BufferAttribute vertices 3
                  if
                    > (.-length indices) 0
                    .setIndex geometry indices
                  .computeVertexNormals geometry
                  new THREE/Mesh geometry $ create-material material
              set! (.-castShadow object3d) true
              set! (.-receiveShadow object3d) true
              set-position! object3d position
              set-rotation! object3d rotation
              set-scale! object3d scale
              , object3d
        |create-material $ quote
          defn create-material (material)
            &let
              m $ case-default (:kind material)
                do (.warn js/console "|Unknown material:" material)
                  new THREE/LineBasicMaterial $ to-js-data (dissoc material :kind)
                :line-basic $ new THREE/LineBasicMaterial
                  to-js-data $ dissoc material :kind
                :line-dashed $ new THREE/LineDashedMaterial
                  to-js-data $ dissoc material :kind
                :mesh-basic $ new THREE/MeshBasicMaterial
                  to-js-data $ dissoc material :kind
                :mesh-lambert $ new THREE/MeshLambertMaterial
                  to-js-data $ dissoc material :kind
                :mesh-standard $ new THREE/MeshStandardMaterial
                  to-js-data $ dissoc material :kind
              set! (.-side m) THREE/DoubleSide
              , m
        |create-polyhedron-element $ quote
          defn create-polyhedron-element (params position rotation scale material)
            let
                vertices $ js-array &
                  concat & $ :vertices params
                indices $ js-array &
                  concat & $ :indices params
                radius $ :radius params
                detail $ :detail params
                geometry $ new THREE/PolyhedronGeometry vertices indices radius detail
                object3d $ new THREE/Mesh geometry (create-material material)
              set! (.-castShadow object3d) true
              set! (.-receiveShadow object3d) true
              set-position! object3d position
              set-rotation! object3d rotation
              set-scale! object3d scale
              , object3d
        |create-tube-element $ quote
          defn create-tube-element (params position rotation scale material)
            let
                points-fn $ :points-fn params
                factor $ :factor params
                geometry $ ->
                  new THREE/TubeGeometry (makeCurve points-fn factor)
                    -> (:tubular-segments params)
                      either $ :tubular params
                      either 40
                    either (:radius params) 2
                    -> (:radial-segments params)
                      either $ :radial params
                      either 8
                    either (:closed? params) false
                object3d $ new THREE/Mesh geometry (create-material material)
              set! (.-castShadow object3d) true
              set! (.-receiveShadow object3d) true
              set-position! object3d position
              set-rotation! object3d rotation
              set-scale! object3d scale
              , object3d
        |create-shape $ quote
          defn create-shape (element coord)
            ; js/console.log |Element: element $ :coord element
            let
                params $ :params element
                position $ :position element
                scale $ :scale element
                rotation $ :rotation element
                material $ either (:material element)
                  {} (:kind :mesh-basic) (:color 0xa0a0a0)
                event $ :event element
              case-default (:name element)
                do (.warn js/console "|Unknown element" element) (new js/Object3D)
                :scene @*global-scene
                :group $ create-group-element params position rotation scale
                :box $ create-box-element params position rotation scale material event coord
                :sphere $ create-sphere-element params position rotation scale material event coord
                :point-light $ create-point-light params position
                :ambient-light $ create-ambient-light params position
                :rect-area-light $ create-rect-area-light params position rotation
                :perspective-camera $ create-perspective-camera params position
                :text $ create-text-element params position rotation scale material
                :line $ create-line-element params position rotation scale material
                :spline $ create-spline-element params position rotation scale material
                :torus $ create-torus-element params position rotation scale material
                :tube $ create-tube-element params position rotation scale material
                :shape $ create-shape-element params position rotation scale material
                :polyhedron $ create-polyhedron-element params position rotation scale material
                :plane-reflector $ create-plane-reflector params position rotation scale
                :parametric $ create-parametric-element params position rotation scale material
                :buffer-object $ create-buffer-object-element params position rotation scale material
        |create-text-element $ quote
          defn create-text-element (params position rotation scale material)
            let
                geometry $ new THREE/TextGeometry
                  either (:text params) |Quatrefoil
                  to-js-data $ assoc params :font font-resource
                object3d $ new THREE/Mesh geometry (create-material material)
              set-position! object3d position
              set-rotation! object3d rotation
              set-scale! object3d scale
              , object3d
        |load-file $ quote
          defmacro load-file (filename) (read-file filename)
        |create-plane-reflector $ quote
          defn create-plane-reflector (params position rotation scale)
            let
                geometry $ new THREE/PlaneGeometry
                  either (:width params) 80
                  either (:height params) 80
                object3d $ new Reflector geometry
                  js-object
                    "\"clipBias" $ either (:clip-bias params) 0.003
                    "\"textureWidth" $ * js/window.innerWidth js/window.devicePixelRatio
                    "\"textureHeight" $ * js/window.innerHeight js/window.devicePixelRatio
                    "\"color" $ either (:color params) "\"0x7777ff"
              set-position! object3d position
              set-rotation! object3d rotation
              set-scale! object3d scale
              , object3d
        |create-ambient-light $ quote
          defn create-ambient-light (params position)
            let
                color $ :color params
                intensity $ either (:intensity params) 1
                object3d $ new THREE/AmbientLight color intensity
              set-position! object3d position
              ; js/console.log |Light: object3d
              , object3d
        |create-shape-element $ quote
          defn create-shape-element (params position rotation scale material)
            let
                shape-2d $ &let
                  s $ new THREE/Shape
                  &doseq
                    op $ :path params
                    write-shape-path! s op
                  , s
                geometry $ new THREE/ShapeGeometry shape-2d
                object3d $ new THREE/Mesh geometry (create-material material)
              set! (.-castShadow object3d) true
              set! (.-receiveShadow object3d) true
              set-position! object3d position
              set-rotation! object3d rotation
              set-scale! object3d scale
              , object3d
        |create-line-element $ quote
          defn create-line-element (params position rotation scale material)
            let
                points $ &let
                  ps $ new js/Array
                  &doseq
                    p $ :points params
                    .push ps $ new THREE/Vector3 & p
                  , ps
                geometry $ -> (new THREE/BufferGeometry) (.setFromPoints points)
                object3d $ new THREE/Line geometry (create-material material)
              set-position! object3d position
              set-rotation! object3d rotation
              set-scale! object3d scale
              , object3d
        |on-canvas-click $ quote
          defn on-canvas-click (event)
            let
                element-tree @*global-tree
                mouse $ new THREE/Vector2
                raycaster $ new THREE/Raycaster
              set! (.-x mouse)
                dec $ * 2
                  / (.-clientX event) js/window.innerWidth
              set! (.-y mouse)
                - 1 $ * 2
                  / (.-clientY event) js/window.innerHeight
              .setFromCamera raycaster mouse @*global-camera
              let
                  intersects $ .intersectObjects raycaster
                    let
                        children $ to-js-data ([])
                        collect! $ fn (x) (.push children x)
                      collect-children @*global-scene collect!
                      , children
                  maybe-target $ aget intersects 0
                ; js/console.log intersects
                if (some? maybe-target)
                  let
                      coord $ -> maybe-target .-object .-coord
                      target-el $ find-element element-tree coord
                      maybe-handler $ -> target-el (get :event) (get :click)
                    if (some? maybe-handler) (maybe-handler event @*proxied-dispatch) (println "|Found no handler for" coord)
        |set-rotation! $ quote
          defn set-rotation! (object3d rotation)
            if (some? rotation)
              let[] (x y z) rotation $ .set (.-rotation object3d) x y z
        |build-tree $ quote
          defn build-tree (coord tree) (; js/console.log "\"build tree:" coord tree)
            if (some? tree)
              let
                  object3d $ create-shape (assoc tree :children nil) coord
                  children $ -> (:children tree) (to-pairs)
                    map $ fn (entry)
                      update entry 1 $ fn (child)
                        build-tree
                          conj coord $ first entry
                          , child
                  virtual-element $ {} (:object3d object3d) (:children children)
                ; js/console.log "\"handle children" children $ :children tree
                &doseq (entry children)
                  let
                      child $ last entry
                    ; js/console.log |Child: child entry
                    .addBy object3d (first entry) child
                , object3d
              new THREE/Object3D
        |font-resource $ quote
          def font-resource $ new THREE/Font
            js/JSON.parse $ load-file |assets/hind.json
        |set-scale! $ quote
          defn set-scale! (object scale)
            if (some? scale)
              let[] (x y z) scale $ .set (.-scale object) (scale-zero x) (scale-zero y) (scale-zero z)
        |write-shape-path! $ quote
          defn write-shape-path! (s op)
            key-match op
                :move-to x y
                .moveTo s x y
              (:line-to x y) (.lineTo s x y)
              (:quadratic-curve-to x0 y0 x1 y1) (.quadraticCurveTo s x0 y0 x1 y1)
              (:bezier-curve-to x0 y0 x1 y1 x2 y2) (.bezierCurveTo s x0 y0 x1 y1 x2 y2)
              _ $ js/console.log "\"Unknown shape path" op
        |create-point-light $ quote
          defn create-point-light (params position)
            let
                color $ :color params
                intensity $ :intensity params
                distance $ :distance params
                object3d $ new THREE/PointLight color intensity distance
              set! (.-castShadow object3d) true
              set-position! object3d position
              ; js/console.log |Light: object3d
              , object3d
        |create-group-element $ quote
          defn create-group-element (params position rotation scale)
            let
                object3d $ new THREE/Group
              set-position! object3d position
              set-rotation! object3d rotation
              set-scale! object3d scale
              , object3d
        |create-parametric-element $ quote
          defn create-parametric-element (params position rotation scale material)
            let
                func $ either (:func params)
                  fn (a b) ([] a b 0)
                slices $ either (:slices params) 10
                stacks $ either (:stacks params) 10
                geometry $ new THREE/ParametricGeometry
                  fn (u v target)
                    let[] (x y z) (func u v) (.set target x y z)
                  , slices stacks
                object3d $ new THREE/Mesh geometry (create-material material)
              set! (.-castShadow object3d) true
              set! (.-receiveShadow object3d) true
              set-position! object3d position
              set-rotation! object3d rotation
              set-scale! object3d scale
              , object3d
      :proc $ quote ()
    |quatrefoil.app.comp.container $ {}
      :ns $ quote
        ns quatrefoil.app.comp.container $ :require
          quatrefoil.alias :refer $ group box sphere point-light ambient-light perspective-camera scene text
          quatrefoil.core :refer $ defcomp >>
          quatrefoil.app.comp.todolist :refer $ comp-todolist
          quatrefoil.app.comp.portal :refer $ comp-portal
          quatrefoil.app.comp.lines :refer $ comp-lines
          quatrefoil.app.comp.shapes :refer $ comp-shapes
          quatrefoil.app.comp.triflorum :refer $ comp-triflorum
          quatrefoil.app.comp.multiply :refer $ comp-multiply
          quatrefoil.app.comp.mirror :refer $ comp-mirror
      :defs $ {}
        |comp-demo $ quote
          defcomp comp-demo () $ group ({})
            box $ {} (:width 16) (:height 4) (:depth 6)
              :position $ [] -40 0 0
              :material $ {} (:kind :mesh-lambert) (:color 0x808080) (:opacity 0.6)
              :event $ {}
                :click $ fn (e d!) (d! :demo nil)
            sphere $ {} (:radius 8)
              :position $ [] 10 0 0
              :material $ {} (:kind :mesh-lambert) (:opacity 0.6) (:color 0x9050c0)
              :event $ {}
                :click $ fn (e d!) (d! :canvas nil)
            group ({})
              text $ {} (:text |Quatrefoil) (:size 4) (:height 2)
                :position $ [] -30 0 20
                :material $ {} (:kind :mesh-lambert) (:color 0xffcccc)
            sphere $ {} (:radius 4) (:emissive 0xffffff) (:metalness 0.8) (:color 0x00ff00) (:emissiveIntensity 1) (:roughness 0)
              :position $ [] -10 20 0
              :material $ {} (:kind :mesh-basic) (:color 0xffff55) (:opacity 0.8) (:transparent true)
              :event $ {}
                :click $ fn (e d!) (d! :canvas nil)
            point-light $ {} (:color 0xffff55) (:intensity 2) (:distance 200)
              :position $ [] -10 20 0
        |comp-container $ quote
          defcomp comp-container (store)
            let
                states $ :states store
                cursor $ :cursor states
                state $ either (:data states)
                  {} $ :tab :portal
                tab $ :tab state
              scene ({})
                perspective-camera $ {} (:fov 45)
                  :aspect $ / js/window.innerWidth js/window.innerHeight
                  :near 0.1
                  :far 500
                  :position $ [] 0 0 100
                case-default tab
                  comp-portal $ fn (next d!)
                    d! cursor $ assoc state :tab next
                  :portal $ comp-portal
                    fn (next d!)
                      d! cursor $ assoc state :tab next
                  :todolist $ comp-todolist (:tasks store)
                  :demo $ comp-demo
                  :lines $ comp-lines
                  :shapes $ comp-shapes
                  :triflorum $ comp-triflorum
                  :multiply $ comp-multiply
                  :mirror $ comp-mirror (>> states :mirror)
                if (not= tab :portal)
                  comp-back $ fn (d!)
                    d! cursor $ assoc state :tab :portal
                ambient-light $ {} (:color 0xaa6666)
                point-light $ {} (:color 0xffffff) (:intensity 1.4) (:distance 200)
                  :position $ [] 20 40 50
                ; point-light $ {} (:color 0xffffff) (:intensity 2) (:distance 200)
                  :position $ [] 0 60 0
        |comp-back $ quote
          defcomp comp-back (on-back)
            box
              {} (:width 16) (:height 4) (:depth 6)
                :position $ [] 60 30 0
                :material $ {} (:kind :mesh-lambert) (:color 0x808080) (:opacity 0.6)
                :event $ {}
                  :click $ fn (e d!) (on-back d!)
              text $ {} (:text |Back) (:size 4) (:height 2)
                :position $ [] 0 0 10
                :material $ {} (:kind :mesh-lambert) (:color 0xffcccc)
      :proc $ quote ()
    |quatrefoil.math $ {}
      :ns $ quote
        ns quatrefoil.math $ :require ("\"three" :as THREE)
      :defs $ {}
        |invert $ quote
          defn invert (a)
            let[] (x y z w) a $ v-scale (conjugate a) (q-length a)
        |v-scale $ quote
          defn v-scale (v n)
            let[] (x y z w) v $ [] (&* n x) (&* n y) (&* n z)
              &* n $ either w 0
        |conjugate $ quote
          defn conjugate (a)
            let[] (x y z w) a $ [] (&- 0 x) (&- 0 y) (&- 0 z) w
        |q-length $ quote
          defn q-length (a)
            let[] (x y z w) a $ sqrt
              + (pow x 2) (pow y 2) (pow z 2) (pow w 2)
        |v+ $ quote
          defn v+ (& xs)
            foldl xs ([] 0 0 0)
              fn (acc x) (&v+ acc x)
        |rand-around $ quote
          defn rand-around (base x)
            + base (rand x) (* -0.5 x)
        |&c+ $ quote
          defn &c+ (a b)
            let-sugar
                  [] x0 y0
                  , a
                ([] x1 y1) b
              [] (+ x0 x1) (+ y0 y1)
        |&v+ $ quote
          defn &v+ (a b)
            let[] (x y z) a $ let[] (x2 y2 z2) b
              [] (+ x x2) (+ y y2) (+ z z2)
        |&q+ $ quote
          defn &q+ (a b)
            let-sugar
                  [] x y z w
                  , a
                ([] x1 y1 z1 w1) b
              [] (+ x x1) (+ y y1) (+ z z1) (+ w w1)
        |&c* $ quote
          defn &c* (a b)
            let-sugar
                  [] x0 y0
                  , a
                ([] x1 y1) b
              []
                - (* x0 x1) (* y0 y1)
                + (* x0 y1) (* x1 y0)
        |q+ $ quote
          defn q+ (& xs)
            foldl xs ([] 0 0 0 0)
              fn (acc x) (&q+ acc x)
        |&q* $ quote
          defn &q* (a b)
            &let
              v $ .toArray
                .multiply
                  new THREE/Quaternion (nth a 0) (nth a 1) (nth a 2) (nth a 3)
                  new THREE/Quaternion (nth b 0) (nth b 1) (nth b 2) (nth b 3)
              [] (aget v 0) (aget v 1) (aget v 2) (aget v 3)
      :proc $ quote ()
      :configs $ {}
    |quatrefoil.app.comp.shapes $ {}
      :ns $ quote
        ns quatrefoil.app.comp.shapes $ :require
          quatrefoil.alias :refer $ group box sphere point-light perspective-camera scene text torus shape rect-area-light polyhedron plane-reflector parametric buffer-object flat-values
          quatrefoil.core :refer $ defcomp
          "\"three" :as THREE
      :defs $ {}
        |comp-shapes $ quote
          defcomp comp-shapes () $ group ({})
            box $ {} (:width 1) (:height 10) (:depth 10)
              :position $ [] 0 0 0
              :material $ {} (:kind :mesh-lambert) (:opacity 0.8) (:transparent true) (:color 0xffddaa)
            torus $ {} (:r1 10) (:r2 2) (:s1 20) (:s2 40)
              :arc $ * 2 &PI
              :position $ [] 0 0 0
              :material $ {} (:kind :mesh-standard) (:opacity 0.9) (:transparent true) (:roughness 0.5) (:metalness 0.9) (:color 0x9050c0)
            shape $ {}
              :path $ [][] (:move-to 0 0) (:line-to 7 2) (:line-to 16 10) (:line-to 20 20) (:line-to 8 17) (:line-to 4 12) (:line-to 0 0)
              :position $ [] 20 0 0
              :material $ {} (:kind :mesh-lambert) (:opacity 0.9) (:transparent true) (:color 0x249825)
            rect-area-light $ {} (:intensity 18) (:width 8) (:color 0xffca00) (:height 30)
              :look-at $ [] -2 0 3
              :position $ [] 13 0 -4
            polyhedron $ {}
              :vertices $ [][] (8 4 -2) (4 9 -3) (-5 -2 -4) (4 2 8)
              :indices $ [][] (0 1 2) (0 1 3) (0 2 3) (1 2 3)
              :radius 10
              :detail 0
              :position $ [] 20 10 10
              :material $ {} (:kind :mesh-lambert) (:opacity 0.9) (:transparent true) (:color 0x9498c5)
            parametric $ {}
              :func $ fn (u v)
                [] (* 8 u)
                  +
                    * 1 $ sin
                      + (* 5 &PI v) (* 8 &PI u)
                    * 1 $ cos
                      + (* 10 &PI v) (* 3 &PI u)
                  * 8 v
              :slices 40
              :stacks 40
              :position $ [] 20 -10 10
              :material $ {} (:kind :mesh-lambert) (:opacity 0.6) (:transparent true) (:color 0xfefea5)
            buffer-object $ {}
              :vertices $ flat-values (0 0 0) (10 0 0) (5 0 8) (5 8 0)
              :indices $ flat-values (0 1 2) (0 2 3) (1 2 3)
              :position $ [] 30 -10 10
              :material $ {} (:kind :mesh-lambert) (:opacity 0.8) (:transparent true) (:color 0xfe2ec5)
      :proc $ quote ()
      :configs $ {} (:extension nil)
    |quatrefoil.dsl.diff $ {}
      :ns $ quote
        ns quatrefoil.dsl.diff $ :require
          quatrefoil.util.core :refer $ purify-tree
          quatrefoil.schema :refer $ comp? shape?
      :defs $ {}
        |diff-params $ quote
          defn diff-params (prev-params params coord collect!) (; "\"unused code, when params changed, geometry would be recreated, so not diffed")
            let
                prev-keys $ keys
                  either prev-params $ {}
                curr-keys $ keys
                  either params $ {}
                added-params $ difference curr-keys prev-keys
                removed-params $ difference prev-keys curr-keys
                common-keys $ intersection prev-keys curr-keys
                changed-params $ -> common-keys
                  filter $ fn (k)
                    not= (get prev-params k) (get params k)
                  map $ fn (k)
                    [] k $ get params k
                  pairs-map
              if
                not $ empty? removed-params
                collect! $ [] coord :remove-params removed-params
              if
                not $ empty? added-params
                collect! $ [] coord :add-params (select-keys params added-params)
              if
                not $ empty? changed-params
                collect! $ [] coord :update-params changed-params
        |diff-children $ quote
          defn diff-children (prev-children children coord collect!)
            let
                prev-keys $ keys prev-children
                curr-keys $ keys children
                removed-keys $ difference prev-keys curr-keys
                added-children $ -> (difference curr-keys prev-keys)
                  map $ fn (k)
                    [] k $ purify-tree (get children k)
                common-keys $ intersection prev-keys curr-keys
              if
                not $ empty? removed-keys
                collect! $ [] coord :remove-children removed-keys
              if
                not $ empty? added-children
                collect! $ [] coord :add-children added-children
              ; js/console.log "|Common keys to diff:" common-keys prev-children children
              &doseq (k common-keys) (; js/console.log "|Diffing children:" coord common-keys)
                let
                    prev-child $ get prev-children k
                    child $ get children k
                  if
                    not $ identical? prev-child child
                    diff-tree prev-child child (conj coord k) collect!
        |diff-events $ quote
          defn diff-events (prev-events events coord collect!)
            let
                prev-event-names $ keys
                  either prev-events $ {}
                event-names $ keys
                  either events $ {}
                added-events $ difference event-names prev-event-names
                removed-events $ difference prev-event-names event-names
              if
                not $ empty? added-events
                collect! $ [] coord :add-events added-events
              if
                not $ empty? removed-events
                collect! $ [] coord :remove-events removed-events
        |diff-material $ quote
          defn diff-material (prev-material material coord collect!)
            if
              not= (get prev-material :kind) (get material :kind)
              collect! $ [] coord :replace-material material
              let
                  prev-keys $ keys
                    either prev-material $ {}
                  curr-keys $ keys
                    either material $ {}
                  added-material $ -> (difference curr-keys prev-keys)
                    map $ fn (k)
                      [] k $ get material k
                    pairs-map
                  removed-keys $ difference prev-keys curr-keys
                  updated-material $ -> (intersection prev-keys curr-keys)
                    filter $ fn (k)
                      not= (get prev-material k) (get material k)
                    map $ fn (k)
                      [] k $ get material k
                    pairs-map
                if
                  not $ empty? added-material
                  collect! $ [] coord :add-material added-material
                if
                  not $ empty? removed-keys
                  collect! $ [] coord :remove-material removed-keys
                if
                  not $ empty? updated-material
                  collect! $ [] coord :update-material updated-material
        |diff-tree $ quote
          defn diff-tree (prev-tree tree coord collect!) (; js/console.log |Diffing: coord prev-tree tree)
            cond
                = nil prev-tree tree
                &let nil nil
              (and (comp? prev-tree) (comp? tree) (not= (:name prev-tree) (:name tree)))
                collect! $ [] coord :replace-element (purify-tree tree)
              (comp? prev-tree)
                recur (:tree prev-tree) tree coord collect!
              (comp? tree)
                recur prev-tree (:tree tree) coord collect!
              (and (some? tree) (nil? prev-tree))
                collect! $ [] coord :add-element tree
              (and (some? prev-tree) (nil? tree))
                collect! $ [] coord :remove-element
              (not= (:name prev-tree) (:name tree))
                collect! $ [] coord :replace-element (purify-tree tree)
              (and (= :text (:name tree) (:name prev-tree)) (not= (:params tree) (:params prev-tree)))
                collect! $ [] coord :replace-element (purify-tree tree)
              (and (= (:name tree) (:name prev-tree)) (not= (:params tree) (:params prev-tree)))
                collect! $ [] coord :replace-element (purify-tree tree)
              true $ do
                ; diff-params (:params prev-tree) (:params tree) coord collect!
                if
                  not= (:position prev-tree) (:position tree)
                  collect! $ [] coord :change-position (:position tree)
                if
                  not= (:rotation prev-tree) (:rotation tree)
                  collect! $ [] coord :change-rotation (:rotation tree)
                if
                  not= (:scale prev-tree) (:scale tree)
                  collect! $ [] coord :change-scale (:scale tree)
                diff-material (:material prev-tree) (:material tree) coord collect!
                diff-events (:event prev-tree) (:event tree) coord collect!
                diff-children (:children prev-tree) (:children tree) coord collect!
        |select-keys $ quote
          defn select-keys (m xs)
            foldl ({})
              fn (acc x)
                assoc acc x $ &get m x
      :proc $ quote ()
    |quatrefoil.app.comp.triflorum $ {}
      :ns $ quote
        ns quatrefoil.app.comp.triflorum $ :require
          quatrefoil.alias :refer $ group box sphere text line tube polyhedron
          quatrefoil.core :refer $ defcomp
          quatrefoil.math :refer $ v+ v-scale
      :defs $ {}
        |comp-triflorum $ quote
          defcomp comp-triflorum () $ group ({}) &
            -> (range 100)
              map $ fn (i)
                tube $ {} (:points-fn petal-fn) (:factor i) (:radius 0.06) (:tubularSegments 20) (:radialSegments 8)
                  :position $ [] 0 0 0
                  :material $ {} (:kind :mesh-standard) (:color 0x882222) (:opacity 1) (:transparent true)
            , &
              -> (range 100)
                map $ fn (i)
                  tube $ {} (:points-fn yarn-fn) (:factor i) (:radius 0.3) (:tubularSegments 20) (:radialSegments 8)
                    :position $ [] 0 0 0
                    :material $ {} (:kind :mesh-standard) (:color 0xffaaaa) (:opacity 0.27) (:transparent true)
              , &
                -> (range 12)
                  map $ fn (i)
                    let
                        theta $ * i &PI (sqrt 2) 0.15
                      polyhedron $ {}
                        :vertices $ let
                            r1 1
                            r2 1
                            r3 3
                            th1 $ + theta 1.5
                            th2 $ - theta 1.5
                            th3 $ - theta &PI
                          [][]
                              * r1 $ cos th1
                              , 0 $ * r1 (sin th1)
                            (* r1 (cos th2))
                              , 0 $ * r1 (sin th2)
                            (* r3 (cos theta))
                              , 0.5 $ * r3 (sin theta)
                            (* r2 (cos th3))
                              , -2 $ * r2 (sin th3)
                        :indices $ [][] (0 1 2) (0 1 3) (0 2 3) (1 2 3)
                        :radius 6
                        :detail 0
                        :position $ let
                            r 8
                          []
                            * r $ cos theta
                            , -0.3 $ * r (sin theta)
                        :material $ {} (:kind :mesh-lambert) (:opacity 0.9) (:transparent true) (:color 0x45cc33)
                tube $ {} (:points-fn main-branch-fn) (:radius 0.7) (:tubularSegments 20) (:radialSegments 8)
                  :position $ [] 0 0 0
                  :material $ {} (:kind :mesh-standard) (:color 0x336622) (:opacity 1) (:transparent true)
        |petal-fn $ quote
          defn petal-fn (ratio i)
            let
                theta0 $ * i
                  * &PI $ sqrt 2
                theta $ *
                  + i $ * ratio 0.4
                  * &PI $ sqrt 2
              v+
                let
                    radius $ +
                      * (- 1 ratio) 8
                      * 1.0 $ sqrt (+ 6 i)
                  v-scale
                    []
                      * radius $ cos theta
                      *
                        - 20 $ * i 0.1
                        , ratio
                      * radius $ sin theta
                    , ratio
                v-scale
                  let
                      radius $ * 0.8
                        sqrt $ + 6 i
                    []
                      * radius $ cos theta0
                      *
                        - 20 $ * i 0.1
                        , ratio
                      * radius $ sin theta0
                  - 1 ratio
        |yarn-fn $ quote
          defn yarn-fn (ratio i)
            let
                theta $ *
                  + i $ * ratio 4
                  * &PI $ sqrt 2
              []
                * 1.0
                  sqrt $ + 2 i
                  cos theta
                *
                  - 18 $ * i 0.1
                  , ratio
                * 1.0
                  sqrt $ + 2 i
                  sin theta
        |main-branch-fn $ quote
          defn main-branch-fn (ratio factor)
            [] 0 (* -20 ratio) 0
      :proc $ quote ()
      :configs $ {}
    |quatrefoil.app.comp.mirror $ {}
      :ns $ quote
        ns quatrefoil.app.comp.mirror $ :require
          quatrefoil.alias :refer $ group box sphere shape text line spline tube plane-reflector point-light
          quatrefoil.core :refer $ defcomp
          quatrefoil.math :refer $ v-scale rand-around
      :defs $ {}
        |comp-mirror $ quote
          defcomp comp-mirror (states)
            let
                cursor $ :cursor states
                state $ either (:data states)
                  {} $ :v 0
              group ({}) &
                -> (range 2)
                  map $ fn (i)
                    plane-reflector $ {} (:width 40) (:height 40) (:color 0xffaaaa)
                      :rotation $ [] (rand-around 0 1) (rand-around 0 1) (rand-around 0 1)
                      :position $ [] (rand-around 0 100) (rand-around 0 100) (rand-around 0 -20)
                , &
                  -> (range 200)
                    map $ fn (x)
                      shape $ {} (:path heart-path)
                        :scale $ v-scale ([] 1 1 1)
                          pow (rand 0.26) 1.4
                        :rotation $ [] (rand-around 0 1) (rand-around 0 1) (rand-around 0 1)
                        :position $ [] (rand-around 0 100) (rand-around 0 100) (rand-around 20 80)
                        :material $ {} (:kind :mesh-lambert) (:opacity 0.8) (:transparent true) (:color 0xff2225)
                  box $ {} (:width 4) (:height 4) (:depth 4)
                    :position $ [] 0 0 0
                    :material $ {} (:kind :mesh-lambert) (:color 0xcccc33) (:opacity 0.6)
                    :event $ {}
                      :click $ fn (e d!)
                        d! cursor $ assoc state :v (rand 1)
                  point-light $ {} (:color 0xff8888) (:intensity 1.4) (:distance 200)
                    :position $ [] -20 0 0
        |heart-path $ quote
          def heart-path $ [][] (:move-to 25 25) (:bezier-curve-to 25 25 20 50 0 50) (:bezier-curve-to -30 50 -30 15 -30 15) (:bezier-curve-to -30 -5 -10 -27 25 -45) (:bezier-curve-to 60 -22 80 -5 80 15) (:bezier-curve-to 80 15 80 50 50 50) (:bezier-curve-to 35 50 25 25 25 25)
      :proc $ quote ()
      :configs $ {}
    |quatrefoil.util.core $ {}
      :ns $ quote
        ns quatrefoil.util.core $ :require
          quatrefoil.schema :refer $ Component Shape comp? shape?
      :defs $ {}
        |scale-zero $ quote
          defn scale-zero (x)
            if (&= 0 x) 0.01 x
        |=component? $ quote
          defn =component? (prev-tree markup)
            let
                prev-args $ :args prev-tree
                prev-states $ :states prev-tree
              ; println
                =seq? (:args markup) prev-args
                identical? (:states markup) prev-states
              and
                =seq? (:args markup) prev-args
                identical? (:states markup) prev-states
        |reach-object3d $ quote
          defn reach-object3d (object3d coord)
            if (empty? coord) object3d $ let
                cursor $ first coord
              recur (.reachBy object3d cursor) (rest coord)
        |collect-children $ quote
          defn collect-children (element collect!)
            .forEach (.-children element)
              fn (child idx _) (; .log js/console |Child: child) (collect! child)
                if
                  some? $ .-children child
                  collect-children child collect!
        |purify-tree $ quote
          defn purify-tree (tree)
            cond
                nil? tree
                , nil
              (comp? tree)
                recur $ :tree tree
              true $ update tree :children
                fn (children)
                  -> children (to-pairs)
                    map $ fn (entry)
                      update entry 1 $ fn (child) (purify-tree child)
                    pairs-map
        |find-element $ quote
          defn find-element (tree coord) (; .log js/console |Find... tree coord)
            if (comp? tree)
              recur (:tree tree) coord
              if (empty? coord) tree $ let
                  cursor $ first coord
                if
                  contains? (:children tree) cursor
                  recur
                    get-in tree $ [] :children cursor
                    rest coord
                  , nil
        |=seq? $ quote
          defn =seq? (xs ys)
            let
                xs-empty? $ empty? xs
                ys-empty? $ empty? ys
              if xs-empty? ys-empty? $ if ys-empty? false
                if
                  identical? (first xs) (first ys)
                  recur (rest xs) (rest ys)
                  , false
      :proc $ quote ()
    |quatrefoil.schema $ {}
      :ns $ quote (ns quatrefoil.schema)
      :defs $ {}
        |Component $ quote (defrecord Component :name :tree)
        |Shape $ quote (defrecord Shape :name :params :position :scale :rotation :material :event :children)
        |comp? $ quote
          defn comp? (x)
            and (record? x) (.matches? Component x)
        |shape? $ quote
          defn shape? (x)
            and (record? x) (.matches? Shape x)
      :proc $ quote ()
    |quatrefoil.app.materials $ {}
      :ns $ quote (ns quatrefoil.app.materials)
      :defs $ {}
        |cover-line $ quote
          def cover-line $ {} (:kind :line-basic) (:color 0xaaaaff) (:opacity 0.9) (:transparent true)
      :proc $ quote ()
      :configs $ {}
    |quatrefoil.dsl.patch $ {}
      :ns $ quote
        ns quatrefoil.dsl.patch $ :require
          [] quatrefoil.dsl.object3d-dom :refer $ [] build-tree set-position! set-rotation! set-scale! create-material
          [] quatrefoil.util.core :refer $ [] reach-object3d scale-zero
          quatrefoil.globals :refer $ *global-scene
          "\"three" :as THREE
      :defs $ {}
        |update-material $ quote
          defn update-material (target coord op-data) (; println "|Update material" coord op-data)
            let
                material $ .-material target
              ; js/console.log target
              &doseq
                entry $ to-pairs op-data
                let[] (param new-value) entry $ case-default param (js/console.log "|Unknown param:" param)
                  :color $ .set (.-color material) (new THREE/Color new-value)
                  :opacity $ set! (.-opacity material) new-value
                  :transparent $ set! (.-transparent material) new-value
              set! (.-needsUpdate material) true
        |replace-element $ quote
          defn replace-element (target coord op-data)
            if (empty? coord) (.warn js/console "|Cannot replace with empty coord!")
              let
                  parent $ reach-object3d @*global-scene (butlast coord)
                .replaceBy parent (last coord) (build-tree coord op-data)
        |apply-changes $ quote
          defn apply-changes (changes)
            ; println "\"changes" (count changes) changes
            &doseq (change changes)
              let-sugar
                    [] coord op op-data
                    , change
                  target $ reach-object3d @*global-scene coord
                ; js/console.log |Change: op coord op-data
                case-default op (js/console.log "|Unknown op:" op)
                  :add-material $ update-material target coord op-data
                  :update-material $ update-material target coord op-data
                  :remove-material $ remove-material target coord op-data
                  :replace-material $ replace-material target coord op-data
                  :remove-children $ remove-children target coord op-data
                  :add-children $ add-children target coord op-data
                  :add-element $ add-element target coord op-data
                  :remove-element $ remove-element target coord
                  :replace-element $ replace-element target coord op-data
                  :change-position $ set-position! target
                    either op-data $ [] 0 0 0
                  :change-rotation $ set-rotation! target
                    either op-data $ [] 0 0 0
                  :change-scale $ set-scale! target
                    either op-data $ [] 0 0 0
        |remove-element $ quote
          defn remove-element (target coord)
            if (empty? coord) (js/console.warn "|Cannot remove by empty coord!")
              let
                  parent $ reach-object3d @*global-scene (butlast coord)
                .removeBy parent $ last coord
        |replace-material $ quote
          defn replace-material (target coord op-data)
            set! (.-material target) (create-material op-data)
        |remove-material $ quote
          defn remove-material (target coord op-data)
            let
                material $ .-material target
              &doseq (entry op-data)
                case-default entry (println "|Unknown material prop:" op-data)
                  :opacity $ set! (.-opacity material) 0.9
                  :transparent $ set! (.-transparent material) 1
        |remove-children $ quote
          defn remove-children (target coord op-data)
            &doseq (child-key op-data) (.removeBy target child-key)
        |add-element $ quote
          defn add-element (target coord op-data)
            if (empty? coord) (js/console.warn "|Cannot remove by empty coord!")
              let
                  parent $ reach-object3d @*global-scene (butlast coord)
                .addBy parent (last coord) (build-tree coord op-data)
        |add-children $ quote
          defn add-children (target coord op-data)
            &doseq (entry op-data)
              let-sugar
                    [] k tree
                    , entry
                .addBy target k $ build-tree (conj coord k) tree
      :proc $ quote ()
    |quatrefoil.app.updater $ {}
      :ns $ quote
        ns quatrefoil.app.updater $ :require
          quatrefoil.cursor :refer $ update-states
      :defs $ {}
        |updater $ quote
          defn updater (store op op-data)
            case-default op store
              :states $ update-states store op-data
              :add-task $ update store :tasks
                fn (tasks)
                  let
                      id $ js/Date.now
                    assoc tasks id $ {} (:id id) (:text op-data) (:done? false)
              :delete-task $ update store :tasks
                fn (tasks) (dissoc tasks op-data)
              :toggle-task $ update store :tasks
                fn (tasks)
                  update-in tasks ([] op-data :done?) not
              :edit-task $ update store :tasks
                fn (tasks)
                  assoc-in tasks
                    [] (first op-data) :text
                    last op-data
      :proc $ quote ()
    |quatrefoil.app.main $ {}
      :ns $ quote
        ns quatrefoil.app.main $ :require
          "\"./alter-object3d" :refer $ inject_bang
          quatrefoil.core :refer $ render-canvas! *global-tree clear-cache! init-renderer! handle-key-event handle-control-events
          quatrefoil.app.comp.container :refer $ comp-container
          quatrefoil.dsl.object3d-dom :refer $ on-canvas-click
          quatrefoil.app.updater :refer $ [] updater
          "\"three" :as THREE
          touch-control.core :refer $ render-control! control-states start-control-loop! clear-control-loop!
      :defs $ {}
        |dispatch! $ quote
          defn dispatch! (op op-data)
            if (list? op)
              recur :states $ [] op op-data
              let
                  store $ updater @*store op op-data
                ; js/console.log |Dispatch: op op-data store
                reset! *store store
        |main! $ quote
          defn main! () (load-console-formatter!) (inject_bang)
            let
                canvas-el $ js/document.querySelector |canvas
              init-renderer! canvas-el $ {} (:background 0x110022)
            render-app!
            add-watch *store :changes $ fn (store prev) (render-app!)
            set! js/window.onkeydown handle-key-event
            render-control!
            handle-control-events
            println "|App started!"
        |reload! $ quote
          defn reload! () (clear-cache!) (clear-control-loop!) (handle-control-events) (remove-watch *store :changes)
            add-watch *store :changes $ fn (store prev) (render-app!)
            render-app!
            set! js/window.onkeydown handle-key-event
            println "|Code updated."
        |*store $ quote
          defatom *store $ {}
            :tasks $ {}
              100 $ {} (:id 100) (:text "|Initial task") (:done? false)
            :states $ {}
              :cursor $ []
        |render-app! $ quote
          defn render-app! () (; println "|Render app:")
            render-canvas! (comp-container @*store) dispatch!
      :proc $ quote ()
    |quatrefoil.core $ {}
      :ns $ quote
        ns quatrefoil.core $ :require
          [] quatrefoil.dsl.diff :refer $ [] diff-tree
          [] quatrefoil.dsl.object3d-dom :refer $ [] build-tree on-canvas-click
          [] quatrefoil.util.core :refer $ [] purify-tree
          [] quatrefoil.dsl.patch :refer $ [] apply-changes
          quatrefoil.schema :refer $ Component
          "\"three" :as THREE
          quatrefoil.globals :refer $ *global-tree *global-camera *global-renderer *global-scene *proxied-dispatch *viewer-angle *viewer-y-shift
          "\"three/examples/jsm/lights/RectAreaLightUniformsLib" :refer $ RectAreaLightUniformsLib
          touch-control.core :refer $ render-control! control-states start-control-loop! clear-control-loop!
          quatrefoil.math :refer $ &c* &c+
      :defs $ {}
        |>> $ quote
          defn >> (states k)
            let
                parent-cursor $ either (:cursor states) ([])
                branch $ either (get states k) ({})
              assoc branch :cursor $ append parent-cursor k
        |*tmp-changes $ quote (defatom *tmp-changes nil)
        |new-lookat-point $ quote
          defn new-lookat-point () $ let-sugar
              camera @*global-camera
              position $ .-position camera
              x2 $ &+ (.-x position)
                &* 4 $ cos @*viewer-angle
              y2 $ &+ (.-y position) (&* 0.2 @*viewer-y-shift)
              z2 $ &+ (.-z position)
                &* -4 $ sin @*viewer-angle
            new THREE/Vector3 x2 y2 z2
        |render-canvas! $ quote
          defn render-canvas! (markup dispatch!) (; js/console.log "\"render" markup) (reset! *proxied-dispatch dispatch!)
            if (some? @*global-tree)
              let
                  collect! $ fn (x) (swap! *tmp-changes conj x)
                reset! *tmp-changes $ []
                diff-tree @*global-tree markup ([]) collect!
                apply-changes @*tmp-changes
              build-tree ([]) (purify-tree markup)
            reset! *global-tree markup
            .render @*global-renderer @*global-scene @*global-camera
        |tween-move-camera! $ quote
          defn tween-move-camera! (control)
            let
                camera @*global-camera
              key-match control
                  :shift shift
                  tween-call 20 5 $ fn (i)
                    do
                      swap! *viewer-y-shift &+ $ / shift 10
                      .!lookAt camera $ new-lookat-point
                      .!render @*global-renderer @*global-scene camera
                (:angle angle)
                  tween-call 20 5 $ fn (i)
                    swap! *viewer-angle &+ $ / angle 10
                    do
                      .!lookAt camera $ new-lookat-point
                      .!render @*global-renderer @*global-scene camera
                (:move dx dy dz)
                  tween-call 20 5 $ fn (i)
                    let-sugar
                        position $ .-position camera
                        x $ &+ (.-x position) (/ dx 10)
                        y $ &+ (.-y position) (/ dy 10)
                        z $ &+ (.-z position) (/ dz 10)
                      set! (.-x position) x
                      set! (.-y position) y
                      set! (.-z position) z
                      .!lookAt camera $ new-lookat-point
                      .!render @*global-renderer @*global-scene camera
                _ $ println "\"unknown camera control:" control
        |handle-control-events $ quote
          defn handle-control-events () $ start-control-loop! 10
            fn (elapsed states)
              let
                  l-move $ :left-move states
                  r-move $ :right-move states
                  camera @*global-camera
                  lifting? $ :left-a? states
                if
                  or
                    not= l-move $ [] 0 0
                    not= r-move $ [] 0 0
                  if
                    or
                      not= l-move $ [] 0 0
                      and lifting? $ not= 0 (last r-move)
                    let-sugar
                        position $ .-position camera
                        mx $ * elapsed (nth l-move 0)
                        mz $ * elapsed (nth l-move 1)
                        a $ &- @*viewer-angle
                          * 1 $ &/ &PI 2
                        ([] dx dz)
                          &c* ([] mx mz)
                            [] (cos a) (sin a)
                        x $ &+ (.-x position) dx
                        y $ if lifting?
                          &+ (.-y position)
                            * elapsed $ nth r-move 1
                          .-y position
                        z $ &+ (.-z position) (negate dz)
                      set! (.-x position) x
                      set! (.-y position) y
                      set! (.-z position) z
                      .!lookAt camera $ new-lookat-point
                      .!render @*global-renderer @*global-scene camera
                if
                  and
                    not $ :left-a? states
                    not= 0 $ nth r-move 0
                  do
                    swap! *viewer-angle &+ $ * -0.01 (nth r-move 0) elapsed
                    do
                      .!lookAt camera $ new-lookat-point
                      .!render @*global-renderer @*global-scene camera
                if
                  and
                    not $ :left-a? states
                    not= 0 $ nth r-move 1
                  do
                    swap! *viewer-y-shift &+ $ * 0.1 (nth r-move 1) elapsed
                    .!lookAt camera $ new-lookat-point
                    .!render @*global-renderer @*global-scene camera
        |handle-key-event $ quote
          defn handle-key-event (event)
            let
                angle @*viewer-angle
                key $ .-key event
                shift? $ .-shiftKey event
              case-default key nil
                "\"ArrowDown" $ if shift?
                  tween-move-camera! $ [] :shift -1
                  tween-move-camera! $ [] :move 0 -2 0
                "\"ArrowUp" $ if shift?
                  tween-move-camera! $ [] :shift 1
                  tween-move-camera! $ [] :move 0 2 0
                "\"ArrowLeft" $ tween-move-camera! ([] :angle 0.04)
                "\"ArrowRight" $ tween-move-camera! ([] :angle -0.04)
                "\"b" $ tween-move-camera!
                  [] :angle 1.653959 $ ; "\"manual value for turn back"
                "\"w" $ &let (a @*viewer-angle)
                  tween-move-camera! $ [] :move
                    &* 4 $ cos a
                    , 0
                      &* -4 $ sin a
                "\"s" $ &let (a @*viewer-angle)
                  tween-move-camera! $ [] :move
                    &* -2 $ cos a
                    , 0
                      &* 2 $ sin a
                "\"a" $ &let
                  a $ &+ @*viewer-angle (&/ &PI 2)
                  tween-move-camera! $ [] :move
                    &* 1 $ cos a
                    , 0
                      &* -1 $ sin a
                "\"d" $ &let
                  a $ &- @*viewer-angle (&/ &PI 2)
                  tween-move-camera! $ [] :move
                    &* 1 $ cos a
                    , 0
                      &* -1 $ sin a
        |tween-call $ quote
          defn tween-call (n d f)
            &doseq
              i $ range 1 n
              js/setTimeout
                fn () $ f i
                * d i
        |init-renderer! $ quote
          defn init-renderer! (canvas-el options) (.init RectAreaLightUniformsLib)
            reset! *global-renderer $ new THREE/WebGLRenderer
              &let
                options $ to-js-data
                  {} (:canvas nil) (:antialias true)
                set! (.-canvas options) canvas-el
                , options
            if
              some? $ :background options
              .setClearColor @*global-renderer (:background options) 1
            set! (.-gammaFactor @*global-renderer) 22
            .setPixelRatio @*global-renderer $ either js/window.devicePixelRatio 1
            .setSize @*global-renderer js/window.innerWidth js/window.innerHeight
            .addEventListener canvas-el |click $ fn (event) (on-canvas-click event)
            .addEventListener js/window |resize $ fn (event)
              set! (.-aspect @*global-camera) (/ js/window.innerWidth js/window.innerHeight)
              .updateProjectionMatrix @*global-camera
              .setSize @*global-renderer js/window.innerWidth js/window.innerHeight
              .render @*global-renderer @*global-scene @*global-camera
        |clear-cache! $ quote
          defn clear-cache! () $ ; "\"TODO memof..."
        |defcomp $ quote
          defmacro defcomp (comp-name params & body)
            ; assert "\"expected symbol of comp-name" $ symbol? comp-name
            ; assert "\"expected params in list" $ and (list? params) (every? params symbol?)
            if (&list:empty? body)
              quasiquote $ echo "\"[Warn] invalid component body for" (quote ~comp-name) (quote ~params)
              quasiquote $ defn ~comp-name (~ params)
                %{} Component
                  :name $ quote ~comp-name
                  :tree $ &let nil ~@body
      :proc $ quote ()
