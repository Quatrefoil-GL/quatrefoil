
{} (:about "|Machine-generated snapshot. Do not edit directly — changes will be overwritten. Use `calcit query` to inspect and `calcit edit`/`calcit tree` to modify. Run `calcit docs agents --full` first. Manual edits must follow format and schema conventions, then run `calcit edit format`.") (:package |quatrefoil)
  :entries $ {}
    :default $ {} (:description |) (:init-fn 'quatrefoil.app.main/main!) (:mode :native) (:reload-fn 'quatrefoil.app.main/reload!)
      :feature-policy $ {}
      :modules $ [] |touch-control/ |pointed-prompt/ |quaternion/
      :type-slots $ {}
  :files $ {}
    |quatrefoil.alias $ %{} 'FileEntry
      :defs $ {}
        |ambient-light $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn ambient-light (props & children) (create-element :ambient-light props children)
          :examples $ []
          :schema $ :: 'Dynamic
        |arrange-children $ %{} 'CodeEntry (:doc |)
          :code $ quote
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
          :examples $ []
          :schema $ :: 'Dynamic
        |box $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn box (props & children) (create-element :box props children)
          :examples $ []
          :schema $ :: 'Dynamic
        |buffer-object $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn buffer-object (props & children) (create-element :buffer-object props children)
          :examples $ []
          :schema $ :: 'Dynamic
        |create-element $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn create-element (el-name props children)
              %{} Shape (:name el-name)
                :params $ -> props (dissoc :material) (dissoc :event) (dissoc :position) (dissoc :scale) (dissoc :rotation) (dissoc :attributes) (dissoc :on) (dissoc :event)
                :position $ field props :position
                :scale $ field props :scale
                :material $ field props :material
                :rotation $ field props :rotation
                :attributes $ field props :attributes
                :event $ or (field props :on) (field props :event)
                :children $ arrange-children children
          :examples $ []
          :schema $ :: 'Dynamic
        |directional-light $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn directional-light (props & children) (create-element :directional-light props children)
          :examples $ []
          :schema $ :: 'Dynamic
        |field $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn field (value key)
              option:unwrap-or (get value key) nil
          :examples $ []
          :schema $ :: 'Dynamic
        |flat-values $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defmacro flat-values (& points)
              &let
                chunk $ &list:concat & points
                quasiquote $ [] ~@chunk
          :examples $ []
          :schema $ :: 'Dynamic
        |group $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn group (props & children) (create-element :group props children)
          :examples $ []
          :schema $ :: 'Dynamic
        |line $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn line (props & children) (create-element :line props children)
          :examples $ []
          :schema $ :: 'Dynamic
        |line-segments $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn line-segments (props & children) (create-element :line-segments props children)
          :examples $ []
          :schema $ :: 'Dynamic
        |mesh-line $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn mesh-line (props & children) (create-element :mesh-line props children)
          :examples $ []
          :schema $ :: 'Dynamic
        |parametric $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn parametric (props & children) (create-element :parametric props children)
          :examples $ []
          :schema $ :: 'Dynamic
        |plane-reflector $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn plane-reflector (props & children) (create-element :plane-reflector props children)
          :examples $ []
          :schema $ :: 'Dynamic
        |point-light $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn point-light (props & children) (create-element :point-light props children)
          :examples $ []
          :schema $ :: 'Dynamic
        |polyhedron $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn polyhedron (props & children) (create-element :polyhedron props children)
          :examples $ []
          :schema $ :: 'Dynamic
        |rect-area-light $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn rect-area-light (props & children) (create-element :rect-area-light props children)
          :examples $ []
          :schema $ :: 'Dynamic
        |scene $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn scene (props & children) (create-element :scene props children)
          :examples $ []
          :schema $ :: 'Dynamic
        |shader-mesh $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn shader-mesh (props & children) (create-element :shader-mesh props children)
          :examples $ []
          :schema $ :: 'Dynamic
        |shape $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn shape (props & children) (create-element :shape props children)
          :examples $ []
          :schema $ :: 'Dynamic
        |some-object $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn some-object (props)
              create-element :some-object props $ []
          :examples $ []
          :schema $ :: 'Dynamic
        |sphere $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn sphere (props & children) (create-element :sphere props children)
          :examples $ []
          :schema $ :: 'Dynamic
        |spline $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn spline (props & children) (create-element :spline props children)
          :examples $ []
          :schema $ :: 'Dynamic
        |spot-light $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn spot-light (props & children) (create-element :spot-light props children)
          :examples $ []
          :schema $ :: 'Dynamic
        |text $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn text (props & children) (create-element :text props children)
          :examples $ []
          :schema $ :: 'Dynamic
        |torus $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn torus (props & children) (create-element :torus props children)
          :examples $ []
          :schema $ :: 'Dynamic
        |tube $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn tube (props & children) (create-element :tube props children)
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote
          ns quatrefoil.alias $ :require
            quatrefoil.schema :refer $ Shape Component comp? shape?
    |quatrefoil.app.comp.container $ %{} 'FileEntry
      :defs $ {}
        |comp-back $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defcomp comp-back (on-back)
              box
                {} (:width 16) (:height 4) (:depth 6)
                  :position $ [] 60 30 0
                  :material $ {} (:kind :mesh-lambert) (:color 0x808080) (:opacity 0.6)
                  :on $ {}
                    :click $ fn (e d!) (on-back d!)
                text $ {} (:text |Back) (:size 4) (:depth 2)
                  :position $ [] 0 0 10
                  :material $ {} (:kind :mesh-lambert) (:color 0xffcccc)
          :examples $ []
          :schema $ :: 'Dynamic
        |comp-container $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defcomp comp-container (store)
              let
                  states $ field store :states
                  cursor $ field states :cursor
                  state $ either (field states :data)
                    {} $ :tab :portal
                  tab $ field state :tab
                scene ({})
                  group
                    {}
                      :scale $ [] 0.01 0.01 0.01
                      :position $ [] 0 1.2 -0.8
                    case-default tab
                      comp-portal $ fn (next d!)
                        d! cursor $ assoc state :tab next
                      :portal $ comp-portal
                        fn (next d!)
                          d! cursor $ assoc state :tab next
                      :todolist $ comp-todolist (field store :tasks)
                      :demo $ comp-demo
                      :lines $ comp-lines
                      :shapes $ comp-shapes
                      :triflorum $ comp-triflorum
                      :mirror $ comp-mirror (>> states :mirror)
                      :fly $ comp-fly-city (>> states :fly)
                      :quat-tree $ comp-quat-tree
                      :quilling $ comp-quilling
                      :control $ comp-control-demo (>> states :control)
                      :shader $ comp-shader
                      :gltf $ comp-gltf
                      :sphere-grid $ comp-sphere-grid
                    if (not= tab :portal)
                      comp-back $ fn (d!)
                        d! cursor $ assoc state :tab :portal
                    ambient-light $ {} (:color 0x666666) (:intensity 1)
                    ; point-light $ {} (:color 0xffffff) (:intensity 1.4) (:distance 200)
                      :position $ [] 20 40 50
                    ; point-light $ {} (:color 0xffffff) (:intensity 2) (:distance 200)
                      :position $ [] 0 60 0
          :examples $ []
          :schema $ :: 'Dynamic
        |comp-demo $ %{} 'CodeEntry (:doc |)
          :code $ quote
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
                  :gamepad $ fn (info elapsed d!) (js/console.log "|first pad event" info)
              sphere $ {} (:radius 8)
                :position $ [] 30 0 0
                :material $ {} (:kind :mesh-lambert) (:opacity 0.6)
                  :color $ hclx 160 80 70
                :event $ {}
                  :click $ fn (e d!) (d! :canvas nil)
                  :gamepad $ fn (info elapsed d!) (js/console.log "|second pad event" info)
              group ({})
                text $ {} (:text |Quatrefoil) (:size 4) (:depth 2)
                  :position $ [] -30 0 20
                  :material $ {} (:kind :mesh-lambert) (:color 0xffcccc)
              sphere $ {} (:radius 4) (:emissive 0xffffff) (:metalness 0.8) (:color 0x00ff00) (:emissiveIntensity 1) (:roughness 0)
                :position $ [] -10 20 0
                :material $ {} (:kind :mesh-basic) (:color 0xffff55) (:opacity 0.8) (:transparent true)
                :event $ {}
                  :click $ fn (e d!) (d! :canvas nil)
              ; point-light $ {} (:color 0xffff55) (:intensity 2) (:distance 200)
                :position $ [] -10 20 0
              point-light $ {} (:color 0xffffff) (:intensity 2) (:distance 200)
                :position $ [] 10 20 10
          :examples $ []
          :schema $ :: 'Dynamic
        |comp-gltf $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn comp-gltf () $ group ({})
              some-object $ {} (:key :sakura)
                :object-loaded? $ option:some? (get @*loaded-objects :sakura)
                :position $ [] 0 -100 -100
                :scale $ [] 200 200 200
              point-light $ {} (:color 0x555555) (:intensity 2.4) (:distance 800)
                :position $ [] 10 100 100
              ambient-light $ {} (:color 0xaaaaaa) (:intensity 1)
          :examples $ []
          :schema $ :: 'Dynamic
        |comp-sphere-grid $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn comp-sphere-grid () $ group ({})
              group ({}) & $ -> (range-3d 8)
                map $ fn (pair)
                  let
                      x $ nth pair 0
                      y $ nth pair 1
                      z $ nth pair 2
                      r 20
                    sphere $ {} (:radius 3)
                      :position $ [] (* r x) (* r y) (* r z)
                      :material $ {} (:kind :mesh-lambert) (:opacity 0.6)
                        :color $ hclx 160 80 70
                      :event $ {}
                        :click $ fn (e d!) (d! :canvas nil)
                        :gamepad $ fn (info elapsed d!) (js/console.log "|second pad event" info)
              point-light $ {} (:color 0xffffff) (:intensity 2) (:distance 200)
                :position $ [] 10 20 10
          :examples $ []
          :schema $ :: 'Dynamic
        |field $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn field (value key)
              option:unwrap-or (get value key) nil
          :examples $ []
          :schema $ :: 'Dynamic
        |range-2d $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn range-2d (n)
              -> (range-bothway n)
                mapcat $ fn (i)
                  -> (range-bothway n)
                    map $ fn (j) ([] i j)
          :examples $ []
          :schema $ :: 'Dynamic
        |range-3d $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn range-3d (n)
              -> (range-bothway n)
                mapcat $ fn (i)
                  -> (range-bothway n)
                    mapcat $ fn (j)
                      -> (range-bothway n)
                        map $ fn (k) ([] i j k)
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote
          ns quatrefoil.app.comp.container $ :require
            quatrefoil.alias :refer $ group box sphere point-light ambient-light scene text some-object
            quatrefoil.core :refer $ defcomp >> hclx
            quatrefoil.app.comp.todolist :refer $ comp-todolist
            quatrefoil.app.comp.portal :refer $ comp-portal
            quatrefoil.app.comp.lines :refer $ comp-lines comp-fly-city
            quatrefoil.app.comp.shapes :refer $ comp-shapes comp-quilling
            quatrefoil.app.comp.triflorum :refer $ comp-triflorum
            quatrefoil.app.comp.mirror :refer $ comp-mirror
            quatrefoil.app.comp.quat-tree :refer $ comp-quat-tree
            quatrefoil.app.comp.control :refer $ comp-control-demo
            quatrefoil.app.comp.shader :refer $ comp-shader
            quatrefoil.globals :refer $ *loaded-objects
    |quatrefoil.app.comp.control $ %{} 'FileEntry
      :defs $ {}
        |comp-control-demo $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defcomp comp-control-demo (states)
              let
                  cursor $ field states :cursor
                  state $ or (field states :data)
                    {}
                      :p0 $ v3 0 0 0
                      :v0 0
                      :v1 $ [] 1 1
                      :on? false
                group ({})
                  comp-pin-point
                    {} (:speed 8) (:label |C) (:color 0xddaaff) (:radius 1) (:opacity 1)
                      :position $ field state :p0
                    fn (next d!)
                      d! cursor $ assoc state :p0 next
                  comp-value
                    {} (:speed 0.2) (:show-text? true) (:label |A)
                      :value $ field state :v0
                      :position $ v3 10 0 0
                      :bound $ [] -2 20
                      :color $ hslx 10 90 80
                    fn (v d!)
                      d! cursor $ assoc state :v0 v
                  comp-value-2d
                    {} (:label |B)
                      :value $ field state :v1
                      :position $ v3 0 10 0
                      :speed 0.2
                      :color 0xccaaff
                      :show-text? true
                      :fract-length 3
                    fn (v d!)
                      d! cursor $ assoc state :v1 v
                  comp-switch
                    {} (:label |Status) (:color 0xaa88ff)
                      :value $ field state :on?
                      :position $ v3 20 0 0
                    fn (v d!)
                      d! cursor $ assoc state :on? v
                  point-light $ {} (:color 0xffffff) (:intensity 1) (:distance 200)
                    :position $ v3 20 40 50
          :examples $ []
          :schema $ :: 'Dynamic
        |field $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn field (value key)
              option:unwrap-or (get value key) nil
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote
          ns quatrefoil.app.comp.control $ :require
            quatrefoil.alias :refer $ group box sphere text line tube point-light
            quatrefoil.core :refer $ defcomp hslx
            quaternion.core :refer $ q* &q* v-scale q+
            quaternion.vector :refer $ v3
            quatrefoil.comp.control :refer $ comp-pin-point comp-value comp-value-2d comp-switch
    |quatrefoil.app.comp.lines $ %{} 'FileEntry
      :defs $ {}
        |cloud-fn $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn cloud-fn (ratio factor)
              let
                  f0 $ nth factor 0
                  f1 $ nth factor 1
                  f2 $ nth factor 2
                  deg $ * ratio 20 &PI
                  r $ * 160
                    js-number $ js/Math.sin deg
                  deg2 $ / (* 5 f0 deg) 13
                  deg3 $ * 0.02 f1 deg
                []
                  * r $ js-number (js/Math.cos deg2)
                  * 0.6 f2 r $ js-number (js/Math.sin deg3)
                  * r $ js-number (js/Math.sin deg2)
          :examples $ []
          :schema $ :: 'Dynamic
        |comp-fly-city $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defcomp comp-fly-city (states)
              let
                  cursor $ field states :cursor
                  state $ or (field states :data)
                    {}
                      :buildings $ make-building-data 80
                      :factor $ [] 1 1 1
                group ({}) & horizontal-lines & forward-lines &
                  -> (field state :buildings)
                    map $ fn (vec)
                      let[] (x y w d h) vec $ box
                        {} (:width w) (:height h) (:depth d)
                          :position $ [] x (* h 0.5) (+ y)
                          :material $ {} (:kind :mesh-lambert) (:color 0x808080) (:opacity 0.6)
                          :event $ {}
                            :click $ fn (e d!) (d! :demo nil)
                  sphere $ {} (:radius 4) (:emissive 0xffffff) (:metalness 0.8) (:color 0x00ff00) (:emissiveIntensity 1) (:roughness 0)
                    :position $ [] 30 30 40
                    :material $ {} (:kind :mesh-basic) (:color 0xffff55) (:opacity 0.8) (:transparent true)
                    :event $ {}
                      :click $ fn (e d!)
                        d! cursor $ assoc state :buildings (make-building-data 80)
                  point-light $ {} (:color 0xffff55) (:intensity 2) (:distance 600)
                    :position $ [] 30 20 40
                  tube $ {} (:points-fn cloud-fn) (:radius 0.6) (:tubular-segments 1600) (:radial-segments 4)
                    :factor $ field state :factor
                    :position $ [] 0 200 0
                    :material $ {} (:kind :mesh-standard) (:color 0xcccc77) (:opacity 1) (:transparent true)
                  sphere $ {} (:radius 4) (:emissive 0xffffff) (:metalness 0.8) (:color 0x00ff00) (:emissiveIntensity 1) (:roughness 0)
                    :position $ [] 0 240 0
                    :material $ {} (:kind :mesh-basic) (:color 0xffff55) (:opacity 0.2) (:transparent true)
                    :event $ {}
                      :click $ fn (e d!)
                        d! cursor $ assoc state :factor
                          [] (rand-shift 1 0.92) (rand-shift 1 0.92) (rand-shift 1 0.92)
                  ambient-light $ {} (:color 0x444422)
          :examples $ []
          :schema $ :: 'Dynamic
        |comp-lines $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defcomp comp-lines () $ group ({})
              text $ {} (:text |Lines) (:size 4) (:depth 1)
                :position $ [] 0 0 4
                :material $ {} (:kind :mesh-lambert) (:color 0xffcccc) (:opacity 0.9) (:transparent true)
              line $ {}
                :points $ [] ([] 0 0 0) ([] 3 3 4) ([] 1 4 6) ([] -2 8 0) ([] 2 5 1)
                :position $ [] 0 -10 0
                :material $ {} (:kind :line-dashed) (:color 0xaaaaff) (:opacity 0.9) (:transparent true) (:linewidth 4) (:gapSize 0.5) (:dashSize 0.5)
              mesh-line $ {}
                :points $ [] ([] 0 0 0) ([] 3 3 4) ([] 1 4 6) ([] -2 8 0) ([] 2 5 1)
                :position $ [] 5 -10 0
                :material $ {} (:kind :mesh-line) (:color 0xaaaaff) (:transparent true) (:opacity 0.4) (:depthTest true) (:lineWidth 0.01)
              line-segments $ {}
                :segments $ []
                  [] ([] 0 0 0) ([] 3 3 4)
                  [] ([] 1 4 6) ([] -2 8 0)
                :position $ [] 10 -10 0
                :material $ {} (:kind :line-dashed) (:color 0xaaaaff) (:opacity 0.9) (:transparent true) (:linewidth 4) (:gapSize 0.5) (:dashSize 0.5)
              line-segments $ {}
                :points $ [] ([] 0 0 0) ([] 3 3 4) ([] 1 4 6) ([] -2 8 0)
                :position $ [] 15 -10 0
                :material $ {} (:kind :line-dashed) (:color 0xaaaaff) (:opacity 0.9) (:transparent true) (:linewidth 4) (:gapSize 0.5) (:dashSize 0.5)
              spline $ {}
                :points $ [] ([] 10 10 0) ([] 8 0 0) ([] 18 0 0) ([] 19 6 4) ([] 15 6 4) ([] 13 8 0) ([] 12 5 1)
                :position $ [] 0 0 0
                :material $ {} (:kind :line-dashed) (:color 0xaaaaff) (:opacity 0.9) (:transparent true) (:linewidth 4) (:gapSize 1) (:dashSize 1)
              tube $ {} (:points-fn tube-fn) (:radius 0.8) (:tubular-segments 400) (:radial-segments 20)
                :position $ [] -10 0 0
                :material $ {} (:kind :mesh-standard) (:color 0xcccc77) (:opacity 1) (:transparent true)
              point-light $ {} (:color 0xffffff) (:intensity 1.4) (:distance 200)
                :position $ [] 20 40 50
          :examples $ []
          :schema $ :: 'Dynamic
        |ffi-object $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn ffi-object (value) (unsafe-coerce value JsObject)
          :examples $ []
          :schema $ :: 'Dynamic
        |field $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn field (value key)
              option:unwrap-or (get value key) nil
          :examples $ []
          :schema $ :: 'Dynamic
        |forward-lines $ %{} 'CodeEntry (:doc |)
          :code $ quote
            def forward-lines $ -> (range 20)
              map $ fn (idx)
                let
                    pos $ * 10 (- idx 10)
                  line $ {}
                    :points $ [] ([] pos 0 -200) ([] pos 0 200)
                    :position $ [] 0 0 0
                    :material $ {} (:kind :line-dashed) (:color 0xccccff) (:opacity 0.3) (:transparent true) (:linewidth 2) (:gapSize 0.5) (:dashSize 0.5)
          :examples $ []
          :schema $ :: 'Dynamic
        |horizontal-lines $ %{} 'CodeEntry (:doc |)
          :code $ quote
            def horizontal-lines $ -> (range 20)
              map $ fn (idx)
                let
                    pos $ * 10 (- idx 10)
                  line $ {}
                    :points $ [] ([] -200 0 pos) ([] 200 0 pos)
                    :position $ [] 0 0 0
                    :material $ {} (:kind :line-dashed) (:color 0xccccff) (:opacity 0.3) (:transparent true) (:linewidth 2) (:gapSize 0.5) (:dashSize 0.5)
          :examples $ []
          :schema $ :: 'Dynamic
        |js-number $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn js-number (value) (unsafe-coerce value Number)
          :examples $ []
          :schema $ :: 'Dynamic
        |make-building-data $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn make-building-data (n)
              -> (range n)
                map $ fn (i)
                  [] (rand-shift 0 160) (rand-shift 0 160) (rand-shift 12 8) (rand-shift 8 6) (rand-shift 60 50)
          :examples $ []
          :schema $ :: 'Dynamic
        |tube-fn $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn tube-fn (t factor)
              []
                *
                  + 2 $ * t 20
                  sin $ * 40 t
                * 30 t
                *
                  + 2 $ * t 20
                  cos $ * 40 t
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote
          ns quatrefoil.app.comp.lines $ :require
            quatrefoil.alias :refer $ group box sphere text line line-segments mesh-line spline tube point-light ambient-light
            quatrefoil.core :refer $ defcomp
            |@calcit/std :refer $ rand-shift
            |three :as THREE
    |quatrefoil.app.comp.mirror $ %{} 'FileEntry
      :defs $ {}
        |comp-mirror $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defcomp comp-mirror (states)
              let
                  cursor $ field states :cursor
                  state $ either (field states :data)
                    {} $ :v 0
                group ({})
                  group ({}) & $ -> (range 2)
                    map $ fn (i)
                      plane-reflector $ {} (:width 40) (:height 40) (:color 0xffaaaa)
                        :rotation $ [] (rand-around 0 1) (rand-around 0 1) (rand-around 0 1)
                        :position $ [] (rand-around 0 100) (rand-around 0 100) (rand-around 0 -20)
                  group ({}) & $ -> (range 60)
                    map $ fn (x)
                      shape $ {} (:path heart-path)
                        :scale $ v-scale ([] 1 1 1)
                          pow (rand 0.26) 1.4
                        :rotation $ [] (rand-around 0 1) (rand-around 0 1) (rand-around 0 1)
                        :position $ [] (rand-around 0 50) (rand-around 0 50) (rand-around 20 80)
                        :material $ {} (:kind :mesh-lambert) (:opacity 0.5) (:transparent true) (:color 0xff2225)
                  box $ {} (:width 4) (:height 4) (:depth 4)
                    :position $ [] 0 0 0
                    :material $ {} (:kind :mesh-lambert) (:color 0xcccc33) (:opacity 0.6)
                    :event $ {}
                      :click $ fn (e d!)
                        d! cursor $ assoc state :v (rand 1)
                  point-light $ {} (:color 0xff8888) (:intensity 2) (:distance 200)
                    :position $ [] 10 0 0
                  ambient-light $ {} (:color 0x666666) (:intencity 1)
          :examples $ []
          :schema $ :: 'Dynamic
        |field $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn field (value key)
              option:unwrap-or (get value key) nil
          :examples $ []
          :schema $ :: 'Dynamic
        |heart-path $ %{} 'CodeEntry (:doc |)
          :code $ quote
            def heart-path $ [] (:: :move-to 25 25) (:: :bezier-curve-to 25 25 20 50 0 50) (:: :bezier-curve-to -30 50 -30 15 -30 15) (:: :bezier-curve-to -30 -5 -10 -27 25 -45) (:: :bezier-curve-to 60 -22 80 -5 80 15) (:: :bezier-curve-to 80 15 80 50 50 50) (:: :bezier-curve-to 35 50 25 25 25 25)
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote
          ns quatrefoil.app.comp.mirror $ :require
            quatrefoil.alias :refer $ group box sphere shape text line spline tube plane-reflector point-light ambient-light
            quatrefoil.core :refer $ defcomp
            quatrefoil.math :refer $ rand-around
            quaternion.vector :refer $ v-scale
            |@calcit/std :refer $ rand
    |quatrefoil.app.comp.portal $ %{} 'FileEntry
      :defs $ {}
        |comp-portal $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defcomp comp-portal (on-change)
              group ({})
                comp-tab :todolist |Todolist ([] -40 30 0) on-change
                comp-tab :demo |Demo ([] 0 30 0) on-change
                comp-tab :lines |Lines ([] 0 20 0) on-change
                comp-tab :shapes |Shapes ([] -40 20 0) on-change
                comp-tab :control "|Control Demo" ([] -40 10 0) on-change
                comp-tab :triflorum |Triflorum ([] 0 10 0) on-change
                comp-tab :mirror "|Mirror.. <3" ([] -40 -0 0) on-change
                comp-tab :fly |Fly ([] 0 0 0) on-change
                comp-tab :quat-tree "|Quat... Tree" ([] -40 -10 0) on-change
                comp-tab :quilling |Quilling ([] -0 -10 0) on-change
                comp-tab :shader |Shader ([] -40 -20 0) on-change
                comp-tab :gltf |GLTF ([] 0 -20 0) on-change
                comp-tab :sphere-grid "|Sphere Grid" ([] -40 -30 0) on-change
                point-light $ {} (:color 0xffffff) (:intensity 1.4) (:distance 200)
                  :position $ [] 20 40 50
          :examples $ []
          :schema $ :: 'Dynamic
        |comp-tab $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defcomp comp-tab (k title position on-change)
              box
                {} (:width 16) (:height 4) (:depth 6) (:position position)
                  :material $ {} (:kind :mesh-lambert)
                    :color $ hslx 60 43 65
                    :opacity 0.6
                    :transparent true
                  :on $ {}
                    :click $ fn (e d!) (on-change k d!)
                text $ {} (:text title) (:size 4) (:depth 1)
                  :position $ [] 0 0 4
                  :material $ {} (:kind :mesh-lambert) (:opacity 0.9) (:transparent true)
                    :color $ hsluvx 0 30 96
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote
          ns quatrefoil.app.comp.portal $ :require
            quatrefoil.alias :refer $ group box sphere text ambient-light point-light
            quatrefoil.core :refer $ defcomp hslx hsluvx
    |quatrefoil.app.comp.quat-tree $ %{} 'FileEntry
      :defs $ {}
        |comp-quat-tree $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defcomp comp-quat-tree () $ let
                p0 $ quaternion 0 0 0 0
                l0 $ quaternion 0 0 30 0
                lines $ generate-lines p0 l0 5 :root
              group ({})
                ambient-light $ {} (:color 0x444422)
                point-light $ {} (:color 0xffffff) (:intensity 1.4) (:distance 200)
                  :position $ [] 20 40 50
                group ({}) & $ -> lines
                  mapcat $ fn (line)
                    let
                        from $ field line :from
                        to $ field line :to
                        v $ &q- to from
                        size $ q-length v
                        w $ nth to 1
                        hang $ {} (:from to)
                          :to $ quaternion w (nth to 2)
                            + (nth to 3)
                              nth (field line :line) 3
                            nth to 4
                      []
                        tube $ {} (:points-fn straight-fn)
                          :factor $ field line :factor
                          :radius $ * 0.04 size
                          :tubular-segments 4
                          :radial-segments 4
                          :position $ v3 -10 0 0
                          :material $ assoc tube-material :color
                            pick-color $ field line :name
                        ; tube $ {} (:points-fn straight-fn) (:factor hang) (:radius 0.1) (:tubular-segments 4) (:radial-segments 4)
                          :position $ v3 -10 0 0
                          :material leaf-material
          :examples $ []
          :schema $ :: 'Dynamic
        |field $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn field (value key)
              option:unwrap-or (get value key) nil
          :examples $ []
          :schema $ :: 'Dynamic
        |generate-lines $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn generate-lines (base l0 level name)
              let
                  line-to $ &q+ base l0
                concat
                  [] $ {} (:from base) (:to line-to) (:name name) (:line l0)
                  if (> level 0)
                    -> transformers $ mapcat
                      fn (info)
                        let
                            trans $ field info :vector
                            name $ field info :name
                          generate-lines line-to (&q* l0 trans) (dec level) name
                    []
          :examples $ []
          :schema $ :: 'Dynamic
        |leaf-material $ %{} 'CodeEntry (:doc |)
          :code $ quote
            def leaf-material $ {} (:kind :mesh-standard) (:color 0x66cc55) (:opacity 0.5) (:transparent true)
          :examples $ []
          :schema $ :: 'Dynamic
        |pick-color $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn pick-color (name)
              case-default name 0xffffff (:a 0xbbaaff) (:b 0x88bbff) (:c 0x77ccaa)
          :examples $ []
          :schema $ :: 'Dynamic
        |straight-fn $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn straight-fn (t factor)
              let-sugar
                    [] w1 x1 y1 z1
                    &enum:params $ &map:get factor :from
                  ([] w2 x2 y2 z2)
                    &enum:params $ &map:get factor :to
                []
                  &+ (&* x1 t)
                    &* x2 $ &- 1 t
                  &+ (&* y1 t)
                    &* y2 $ &- 1 t
                  &+ (&* z1 t)
                    &* z2 $ &- 1 t
          :examples $ []
          :schema $ :: 'Dynamic
        |transformers $ %{} 'CodeEntry (:doc |)
          :code $ quote
            def transformers $ []
              {} (:name :a)
                :vector $ quaternion 0.7 0.3 0.3 0.1
              {} (:name :b)
                :vector $ quaternion 0.7 0.2 -0.3 -0.43
              {} (:name :c)
                :vector $ quaternion 0.4 -0.44 0.12 0.33
          :examples $ []
          :schema $ :: 'Dynamic
        |tube-material $ %{} 'CodeEntry (:doc |)
          :code $ quote
            def tube-material $ {} (:kind :mesh-standard) (:color 0xcccc77) (:opacity 1) (:transparent true)
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote
          ns quatrefoil.app.comp.quat-tree $ :require
            quatrefoil.alias :refer $ group box sphere text line tube ambient-light point-light
            quatrefoil.core :refer $ defcomp
            quaternion.core :refer $ q* &q* q+ &q+ &q- q-length quaternion
            quaternion.vector :refer $ v-scale %v3 v3
            quatrefoil.app.materials :refer $ cover-line
    |quatrefoil.app.comp.shader $ %{} 'FileEntry
      :defs $ {}
        |comp-shader $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defcomp comp-shader () $ group ({})
              shader-mesh $ {}
                :attributes $ []
                  {} (:id :position) (:size 3) (:type :f32)
                    :buffer $ concat &
                      [] ([] -10 -20 0) ([] 50 0 0) ([] 13 30 0)
                  {} (:id :color) (:size 4) (:type :u8)
                    :buffer $ concat &
                      [] ([] 1 0 0 1) ([] 0 1 0 1) ([] 0 0 1 1)
                :material $ {} (:kind :raw-shader)
                  :uniforms $ {}
                  :vertexShader $ inline-shader |demo.vert
                  :fragmentShader $ inline-shader |demo.frag
                  :wireframe false
                  :transparent false
              point-light $ {} (:color 0xffffff) (:intensity 1.4) (:distance 200)
                :position $ [] 20 40 50
          :examples $ []
          :schema $ :: 'Dynamic
        |inline-shader $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defmacro inline-shader (name)
              read-file $ str |shaders/ name
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote
          ns quatrefoil.app.comp.shader $ :require
            quatrefoil.alias :refer $ group box sphere text line tube ambient-light point-light shader-mesh
            quatrefoil.core :refer $ defcomp
            quaternion.core :refer $ q* &q* v-scale q+ &q+ &q- q-length
            quatrefoil.app.materials :refer $ cover-line
    |quatrefoil.app.comp.shapes $ %{} 'FileEntry
      :defs $ {}
        |box-material $ %{} 'CodeEntry (:doc |)
          :code $ quote
            def box-material $ {} (:kind :mesh-lambert) (:color 0x808080) (:opacity 0.6)
          :examples $ []
          :schema $ :: 'Dynamic
        |bubble-material $ %{} 'CodeEntry (:doc |)
          :code $ quote
            def bubble-material $ {} (:kind :mesh-basic) (:color 0xffffff) (:opacity 1) (:transparent true)
          :examples $ []
          :schema $ :: 'Dynamic
        |comp-bubble $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn comp-bubble (position)
              group ({})
                sphere $ {} (:radius 1) (:emissive 0xffffff) (:metalness 0.8) (:color 0xffffff) (:emissiveIntensity 1) (:roughness 0) (:position position) (:material bubble-material)
                point-light $ {} (:color 0xffffff) (:intensity 2) (:distance 400) (:position position)
          :examples $ []
          :schema $ :: 'Dynamic
        |comp-quilling $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defcomp comp-quilling () $ group ({})
              ; comp-bubble $ [] 0 -80 0
              ; comp-bubble $ [] 0 80 0
              ; comp-bubble $ [] 60 40 0
              ; comp-bubble $ [] -80 40 0
              ; comp-bubble $ [] 0 40 80
              ; comp-bubble $ [] 0 40 -60
              ; ambient-light $ {} (:color 0x8888dd) (:intensity 0.8)
              spot-light $ {} (:color 0xffffff) (:intensity 1)
                :position $ [] 0 100 0
                :distance 400
              spot-light $ {} (:color 0xffffff) (:intensity 1)
                :position $ [] 100 0 0
                :distance 400
              spot-light $ {} (:color 0xffffff) (:intensity 1)
                :position $ [] 0 0 100
                :distance 400
              , &
                -> 12 (range)
                  map $ fn (idx)
                    parametric $ {} (:func paper-fn) (:data idx) (:slices 80) (:stacks 80)
                      :position $ [] 0 -40 0
                      :material paper-material
          :examples $ []
          :schema $ :: 'Dynamic
        |comp-shapes $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defcomp comp-shapes () $ group ({})
              box $ {} (:width 1) (:height 10) (:depth 10)
                :position $ [] 0 0 0
                :material $ {} (:kind :mesh-lambert) (:opacity 0.8) (:transparent true) (:color 0xffddaa)
              torus $ {} (:r1 10) (:r2 2) (:s1 20) (:s2 40)
                :arc $ * 2 &PI
                :position $ [] 0 0 0
                :material $ {} (:kind :mesh-standard) (:opacity 0.9) (:transparent true) (:roughness 0.5) (:metalness 0.9) (:color 0x9050c0)
              shape $ {}
                :path $ [] (:: :move-to 0 0) (:: :line-to 7 2) (:: :line-to 16 10) (:: :line-to 20 20) (:: :line-to 8 17) (:: :line-to 4 12) (:: :line-to 0 0)
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
              parametric $ {} (:func wave-fn) (:slices 40) (:stacks 40)
                :position $ [] 20 -10 10
                :material $ {} (:kind :mesh-lambert) (:opacity 0.6) (:transparent true) (:color 0xfefea5)
              buffer-object $ {}
                :vertices $ flat-values (0 0 0) (10 0 0) (5 0 8) (5 8 0)
                :indices $ flat-values (0 1 2) (0 2 3) (1 2 3)
                :position $ [] 30 -10 10
                :material $ {} (:kind :mesh-lambert) (:opacity 0.8) (:transparent true) (:color 0xfe2ec5)
              point-light $ {} (:color 0xffffff) (:intensity 1.4) (:distance 200)
                :position $ [] 20 40 50
          :examples $ []
          :schema $ :: 'Dynamic
        |paper-fn $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn paper-fn (u v idx)
              let
                  scale 10
                  t $ * u &PI 1.8
                  t2 $ * 6.7 t
                  t3 $ * 4.2 t
                  r $ + 2
                    * 0.6 (pow v 3) (pow idx 1.9)
                    * 0.8 scale $ pow v 3
                    * 6 $ * (sin t2)
                      sin $ * 0.5 idx
                  x $ * r (cos t)
                  y $ * r (sin t)
                  h $ +
                    * v scale (+ 1 u) 4 $ pow 0.9 (/ idx 4)
                    * 4 $ sin t3
                [] x h y
          :examples $ []
          :schema $ :: 'Dynamic
        |paper-material $ %{} 'CodeEntry (:doc |)
          :code $ quote
            def paper-material $ {} (:kind :mesh-standard) (:roughness 0.99) (; :emissive 0x6611ee) (:metalness 0.02) (:transparent false) (:color 0x6666ff)
          :examples $ []
          :schema $ :: 'Dynamic
        |wave-fn $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn wave-fn (u v data)
              [] (* 8 u)
                +
                  * 1 $ sin
                    + (* 5 &PI v) (* 8 &PI u)
                  * 1 $ cos
                    + (* 10 &PI v) (* 3 &PI u)
                * 8 v
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote
          ns quatrefoil.app.comp.shapes $ :require
            quatrefoil.alias :refer $ group box sphere point-light scene text torus shape rect-area-light polyhedron plane-reflector parametric buffer-object flat-values ambient-light directional-light spot-light
            quatrefoil.core :refer $ defcomp
            |three :as THREE
    |quatrefoil.app.comp.todolist $ %{} 'FileEntry
      :defs $ {}
        |comp-task $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defcomp comp-task (task idx)
              group
                {} $ :position
                  [] 0 (* idx -8) 0
                sphere $ {} (:radius 2)
                  :position $ [] -30 0 0
                  :material $ {} (:kind :mesh-lambert) (:opacity 0.8) (:transparent true)
                    :color $ if (field task :done?) 0x905055 0x9050ff
                  :event $ {}
                    :click $ fn (event dispatch!)
                      dispatch! :toggle-task $ field task :id
                box
                  {} (:width 40) (:height 4) (:depth 1)
                    :material $ {} (:kind :mesh-lambert) (:color 0xcccccc) (:opacity 0.6) (:transparent true)
                    :event $ {}
                      :click $ fn (event dispatch!)
                        [] (field task :id)
                          prompt-at!
                            []
                              unsafe-coerce
                                .-pageX $ unsafe-coerce event JsObject
                                , Number
                              unsafe-coerce
                                .-pageY $ unsafe-coerce event JsObject
                                , Number
                            {} $ :initial (field task :text)
                            fn (text)
                              dispatch! :edit-task $ [] (field task :id) text
                  text $ {}
                    :text $ field task :text
                    :size 3
                    :depth 1
                    :position $ [] -10 0 0
                    :material $ {} (:kind :mesh-lambert) (:color 0xffcccc) (:opacity 0.8) (:transparent true)
                sphere $ {} (:radius 2)
                  :position $ [] 30 0 0
                  :material $ {} (:kind :mesh-lambert) (:opacity 0.8) (:color 0xff5050) (:transparent true)
                  :event $ {}
                    :click $ fn (event dispatch!)
                      dispatch! :delete-task $ field task :id
          :examples $ []
          :schema $ :: 'Dynamic
        |comp-todolist $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defcomp comp-todolist (tasks)
              group ({})
                group
                  {} $ :position ([] 0 30 0)
                  box $ {} (:width 40) (:height 6) (:depth 1)
                    :material $ {} (:kind :mesh-lambert) (:color 0xffaaaa) (:opacity 0.9) (:transparent true)
                    :event $ {}
                      :click $ fn (e d!) (js/console.log |e e)
                        prompt-at!
                          [] (.-pageX e) (.-pageY e)
                          {} $ :initial |
                          fn (text) (d! :add-task text)
                group
                  {} $ :position ([] 0 20 0)
                  -> (vals tasks)
                    map-indexed $ fn (idx task)
                      [] (field task :id) (comp-task task idx)
                    pairs-map
                point-light $ {} (:color 0xffffff) (:intensity 1.4) (:distance 200)
                  :position $ [] 0 20 50
          :examples $ []
          :schema $ :: 'Dynamic
        |field $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn field (value key)
              option:unwrap-or (get value key) nil
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote
          ns quatrefoil.app.comp.todolist $ :require
            quatrefoil.alias :refer $ group box sphere point-light scene text
            quatrefoil.core :refer $ defcomp
            pointed-prompt.core :refer $ prompt-at!
    |quatrefoil.app.comp.triflorum $ %{} 'FileEntry
      :defs $ {}
        |comp-triflorum $ %{} 'CodeEntry (:doc |)
          :code $ quote
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
                  point-light $ {} (:color 0xffffff) (:intensity 1.4) (:distance 200)
                    :position $ [] 0 20 50
          :examples $ []
          :schema $ :: 'Dynamic
        |main-branch-fn $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn main-branch-fn (ratio factor)
              [] 0 (* -20 ratio) 0
          :examples $ []
          :schema $ :: 'Dynamic
        |petal-fn $ %{} 'CodeEntry (:doc |)
          :code $ quote
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
                      v3
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
                      v3
                        * radius $ cos theta0
                        *
                          - 20 $ * i 0.1
                          , ratio
                        * radius $ sin theta0
                    - 1 ratio
          :examples $ []
          :schema $ :: 'Dynamic
        |yarn-fn $ %{} 'CodeEntry (:doc |)
          :code $ quote
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
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote
          ns quatrefoil.app.comp.triflorum $ :require
            quatrefoil.alias :refer $ group box sphere text line tube polyhedron point-light
            quatrefoil.core :refer $ defcomp
            quaternion.vector :refer $ v+ v-scale %v3 v3
    |quatrefoil.app.main $ %{} 'FileEntry
      :defs $ {}
        |*store $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defatom *store $ {}
              :tasks $ {}
                100 $ {} (:id 100) (:text "|Initial task") (:done? false)
              :states $ {}
                :cursor $ []
          :examples $ []
          :schema $ :: 'Dynamic
        |dispatch! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn dispatch! (op op-data)
              if (list? op)
                recur :states $ [] op op-data
                let
                    store $ updater @*store op op-data
                  ; js/console.log |Dispatch: op op-data store
                  reset! *store store
          :examples $ []
          :schema $ :: 'Dynamic
        |ffi-object $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn ffi-object (value) (unsafe-coerce value JsObject)
          :examples $ []
          :schema $ :: 'Dynamic
        |js-number $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn js-number (value) (unsafe-coerce value Number)
          :examples $ []
          :schema $ :: 'Dynamic
        |main! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn main! () (load-console-formatter!) (inject-tree-methods) (start-loading-sakura!)
              set-perspective-camera! $ {} (:fov 50) (:near 0.1) (:far 10)
                :position $ v3 0 1.6 1
                :aspect $ /
                  js-number $ .-innerWidth (ffi-object js/window)
                  js-number $ .-innerHeight (ffi-object js/window)
              let
                  canvas-el $ js/document.querySelector |canvas
                init-renderer! canvas-el $ {} (:background 0x110022) (:shadow-map? true)
                  ; :composer-passes $ []
                    new UnrealBloomPass
                      new THREE/Vector2
                        js-number $ .-innerWidth (ffi-object js/window)
                        js-number $ .-innerHeight (ffi-object js/window)
                      , 1.5 0.4 0.85
              render-app!
              add-watch *store :changes $ fn (store prev) (render-app!)
              set! js/window.onkeydown handle-key-event
              render-control!
              handle-control-events
              init-controls!
              println "|App started!"
          :examples $ []
          :schema $ :: 'Dynamic
        |reload! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn reload! () $ if (some? build-errors) (hud! |error build-errors)
              do (hud! |ok~ nil) (clear-cache!) (clear-control-loop!) (handle-control-events) (remove-watch *store :changes)
                add-watch *store :changes $ fn (store prev) (render-app!)
                render-app!
                set! js/window.onkeydown handle-key-event
                println "|Code updated."
          :examples $ []
          :schema $ :: 'Dynamic
        |render-app! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn render-app! () (; println "|Render app:")
              render-canvas! (comp-container @*store) dispatch!
          :examples $ []
          :schema $ :: 'Dynamic
        |start-loading-sakura! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn start-loading-sakura! () $ let
                loader $ new GLTFLoader
                dracoLoader $ new DRACOLoader
              .!setDecoderPath dracoLoader |https://cdn.tiye.me/gltf/
              .!setDRACOLoader loader dracoLoader
              .!load loader |https://cdn.tiye.me/gltf/fantasy_sakura/scene.gltf
                fn (gltf)
                  swap! *loaded-objects assoc :sakura $ .-scene gltf
                  js/console.info "|gltf loaded"
                  render-app!
                fn $ xhr
                fn (err) (js/console.log err)
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote
          ns quatrefoil.app.main $ :require
            |@quatrefoil/utils :refer $ inject-tree-methods
            quatrefoil.core :refer $ render-canvas! *global-tree clear-cache! init-renderer! init-controls! handle-key-event handle-control-events
            quatrefoil.globals :refer $ *loaded-objects
            quatrefoil.app.comp.container :refer $ comp-container
            quatrefoil.dsl.object3d-dom :refer $ on-canvas-click
            quatrefoil.app.updater :refer $ [] updater
            quaternion.vector :refer $ v3
            |three :as THREE
            touch-control.core :refer $ render-control! control-states start-control-loop! clear-control-loop!
            |bottom-tip :default hud!
            |./calcit.build-errors :default build-errors
            quatrefoil.dsl.object3d-dom :refer $ set-perspective-camera!
            |three/examples/jsm/postprocessing/UnrealBloomPass :refer $ UnrealBloomPass
            |three/examples/jsm/loaders/GLTFLoader :refer $ GLTFLoader
            |three/examples/jsm/loaders/DRACOLoader :refer $ DRACOLoader
    |quatrefoil.app.materials $ %{} 'FileEntry
      :defs $ {}
        |cover-line $ %{} 'CodeEntry (:doc |)
          :code $ quote
            def cover-line $ {} (:kind :line-basic) (:color 0xaaaaff) (:opacity 0.9) (:transparent true)
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote (ns quatrefoil.app.materials)
    |quatrefoil.app.updater $ %{} 'FileEntry
      :defs $ {}
        |updater $ %{} 'CodeEntry (:doc |)
          :code $ quote
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
                      option:unwrap-or (last op-data) nil
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote
          ns quatrefoil.app.updater $ :require
            quatrefoil.cursor :refer $ update-states
    |quatrefoil.comp.control $ %{} 'FileEntry
      :defs $ {}
        |comp-2d-control $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defcomp comp-2d-control (state cursor field position speed color)
              sphere $ {} (:radius 1) (:emissive 0xffffff) (:metalness 0.8) (:color 0x00ff00) (:emissiveIntensity 1) (:roughness 0) (:position position)
                :material $ {} (:kind :mesh-basic) (:color color) (:opacity 0.3) (:transparent true)
                :event $ {}
                  :control $ fn (states delta elapse d!) (; println |delta delta)
                    let-sugar
                          [] x0 y0
                          get state field
                        dx $ * speed elapse (nth delta 0)
                        dy $ * speed elapse (nth delta 1)
                      d! cursor $ assoc state field
                        [] (+ x0 dx) (+ y0 dy)
          :examples $ []
          :schema $ :: 'Dynamic
        |comp-pin-point $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defcomp comp-pin-point (options on-change)
              let
                  position $ or (field options :position) (v3 0 0 0)
                  speed $ or (field options :speed) 1
                  text-color $ either (field options :text-color) 0xaaaaff
                group
                  {} $ :position position
                  sphere $ {} (:emissive 0xffffff) (:metalness 0.8) (:emissiveIntensity 1) (:roughness 0)
                    :position $ v3 0 0 0
                    :radius $ or (field options :radius) 1
                    :material $ {} (:kind :mesh-lambert) (:transparent true)
                      :color $ either (field options :color) 0xaaaaff
                      :opacity $ either (field options :opacity) 0.7
                    :event $ {}
                      :control $ fn (states delta elapse d!) (; println |delta delta)
                        let
                            next-pos $ &v+ position
                              to-viewer-axis
                                * speed $ nth delta 0
                                * speed $ nth delta 1
                                , 0
                          on-change next-pos d!
                      :gamepad $ fn (info elapsed d!) (js/console.log info)
                        let
                            speeding $ * speed
                              if (field info :b) 8 1
                            forward $ * speeding elapsed (field info :v2)
                              if (field info :a) -1 1
                            next-pos $ v+ position
                              v-scale (field info :rightward)
                                * speeding elapsed $ field info :dx
                              v-scale (field info :upward)
                                * -1 speeding elapsed $ field info :dy
                              v-scale (field info :forward) forward
                          on-change next-pos d!
                  if-let
                    label $ field options :label
                    text $ {}
                      :position $ v3 -0.6 2 0
                      :text $ str label
                      :material $ {} (:kind :mesh-lambert) (:color text-color) (:opacity 0.9) (:transparent true)
                      :size 2
                      :depth 0.5
          :examples $ []
          :schema $ :: 'Dynamic
        |comp-switch $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn comp-switch (options on-toggle)
              let
                  value $ field options :value
                  color $ either (field options :color) 0xffffff
                  text-color $ either (field options :text-color) color
                  label $ field options :label
                group
                  {} $ :position (field options :position)
                  sphere $ {} (:emissive 0xffffff) (:metalness 0.8) (:emissiveIntensity 1) (:roughness 0)
                    :radius $ &*
                      or (field options :radius) 1
                      if value 1 0.8
                    :material $ {} (:kind :mesh-lambert) (:color color) (:transparent true)
                      :opacity $ if value
                        either (field options :opacity) 0.8
                        , 0.3
                    :event $ {}
                      :click $ fn (e d!)
                        on-toggle (not value) d!
                  text $ {}
                    :position $ [] 1.6 -0.8 0
                    :text $ or label |On
                    :material $ {} (:kind :mesh-lambert) (:color text-color) (:opacity 0.9) (:transparent true)
                    :size 2
                    :depth 0.5
          :examples $ []
          :schema $ :: 'Dynamic
        |comp-value $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defcomp comp-value (options on-change)
              let
                  value $ field options :value
                  speed $ or (field options :speed) 1
                  color $ either (field options :color) 0xffffff
                  text-color $ either (field options :text-color) color
                  text-size $ either (field options :text-size) 1
                  bound $ or (field options :bound) ([] 0 1)
                  label $ field options :label
                group
                  {} $ :position (field options :position)
                  sphere $ {} (:emissive 0xffffff) (:metalness 0.8) (:emissiveIntensity 1) (:roughness 0)
                    :radius $ or (field options :radius) 1
                    :material $ {} (:kind :mesh-lambert) (:color color) (:transparent true)
                      :opacity $ either (field options :opacity) 0.6
                    :event $ {}
                      :control $ fn (move delta elapse d!) (; println |delta delta)
                        let
                            dx $ * speed elapse (nth delta 1)
                            w2 $ + dx value
                            up $ nth bound 1
                            low $ nth bound 0
                          on-change
                            cond
                                > w2 up
                                , up
                              (< w2 low) low
                              true w2
                            , d!
                      :gamepad $ fn (info elapsed d!)
                        let
                            speeding $ * speed
                              if (field info :b) 8 1
                          on-change
                            + value $ * elapsed speeding (field info :dx)
                            , d!
                  if (field options :show-text?)
                    text $ {}
                      :position $ [] -1.6 2 0
                      :text $ let
                          prefix $ if (blank? label) | (str label "| ")
                        str prefix $ .!toFixed value
                          either (field options :fract-length) 2
                      :material $ {} (:kind :mesh-lambert) (:color text-color) (:opacity 0.9) (:transparent true)
                      :size text-size
                      :depth 0.5
          :examples $ []
          :schema $ :: 'Dynamic
        |comp-value-2d $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defcomp comp-value-2d (options on-change)
              let
                  v $ field options :value
                  position $ field options :position
                  speed $ either (field options :speed) 1
                  color $ either (field options :color) 0xaaaaff
                  text-color $ either (field options :text-color) color
                  text-size $ either (field options :text-size) 1
                  fract-len $ either (field options :fract-length) 2
                  label $ field options :label
                group
                  {} $ :position (field options :position)
                  sphere $ {} (:radius 1) (:emissive 0xffffff) (:metalness 0.8) (:emissiveIntensity 1) (:roughness 0)
                    :material $ {} (:kind :mesh-lambert) (:color color) (:opacity 0.7) (:transparent true)
                    :event $ {}
                      :control $ fn (states delta elapse d!) (; println |delta delta)
                        let-sugar
                              [] x0 y0
                              , v
                            dx $ * speed elapse (nth delta 0)
                            dy $ * speed elapse (nth delta 1)
                          on-change
                            [] (+ x0 dx) (+ y0 dy)
                            , d!
                      :gamepad $ fn (info elapsed d!)
                        let
                            x0 $ nth v 0
                            y0 $ nth v 1
                            speeding $ * speed
                              if (field info :b) 8 1
                            dx $ * elapsed speeding (field info :dx)
                            dy $ * elapsed speeding (field info :dy)
                          on-change
                            [] (+ x0 dx) (- y0 dy)
                            , d!
                  if (field options :show-text?)
                    text $ {}
                      :position $ [] -2 2 0
                      :text $ let
                          prefix $ if (blank? label) | (str label "| ")
                        str prefix
                          .!toFixed (nth v 0) fract-len
                          , "|, " $ .!toFixed (nth v 1) fract-len
                      :material $ {} (:kind :mesh-lambert) (:color text-color) (:opacity 0.9) (:transparent true)
                      :size text-size
                      :depth 1
          :examples $ []
          :schema $ :: 'Dynamic
        |field $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn field (value key)
              option:unwrap-or (get value key) nil
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote
          ns quatrefoil.comp.control $ :require
            quatrefoil.alias :refer $ group box sphere text line tube point-light
            quatrefoil.core :refer $ defcomp
            quaternion.core :refer $ q* &q* q+
            quaternion.vector :refer $ v-scale &v+ v+ v3
            quatrefoil.app.materials :refer $ cover-line
            quatrefoil.core :refer $ to-viewer-axis
    |quatrefoil.core $ %{} 'FileEntry
      :defs $ {}
        |*tmp-changes $ %{} 'CodeEntry (:doc |)
          :code $ quote (defatom *tmp-changes nil)
          :examples $ []
          :schema $ :: 'Dynamic
        |>> $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn >> (states k)
              let
                  parent-cursor $ either (field states :cursor) ([])
                  branch $ either (get states k) ({})
                assoc branch :cursor $ append parent-cursor k
          :examples $ []
          :schema $ :: 'Dynamic
        |camera-direction-for $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn camera-direction-for (x y z)
              let
                  v $ new THREE/Vector3 x y z
                .!applyQuaternion v $ .-quaternion (ffi-object @*global-camera)
                :: :v3
                  js-number $ .-x (ffi-object v)
                  js-number $ .-y (ffi-object v)
                  js-number $ .-z (ffi-object v)
          :examples $ []
          :schema $ :: 'Dynamic
        |clear-cache! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn clear-cache! () $ ; "|TODO memof..."
          :examples $ []
          :schema $ :: 'Dynamic
        |data0 $ %{} 'CodeEntry (:doc |)
          :code $ quote
            def data0 $ {} (:v1 0) (:v2 0) (:a 0) (:b 0) (:dx 0) (:dy 0)
          :examples $ []
          :schema $ :: 'Dynamic
        |defcomp $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defmacro defcomp (comp-name params & body)
              ; assert "|expected symbol of comp-name" $ symbol? comp-name
              ; assert "|expected params in list" $ and (list? params) (every? params symbol?)
              if (&list:empty? body)
                quasiquote $ echo "|[Warn] invalid component body for" (quote ~comp-name) (quote ~params)
                quasiquote $ defn ~comp-name (~ params)
                  %{} Component
                    :name $ quote ~comp-name
                    :tree $ &let () ~@body
          :examples $ []
          :schema $ :: 'Dynamic
        |ffi-object $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn ffi-object (value) (unsafe-coerce value JsObject)
          :examples $ []
          :schema $ :: 'Dynamic
        |field $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn field (value key)
              option:unwrap-or (get value key) nil
          :examples $ []
          :schema $ :: 'Dynamic
        |half-pi $ %{} 'CodeEntry (:doc |)
          :code $ quote
            def half-pi $ * 0.5 &PI
          :examples $ []
          :schema $ :: 'Dynamic
        |handle-control-events $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn handle-control-events () $ start-control-loop! 10
              fn (elapsed states delta)
                let
                    l-move $ map (field states :left-move) refine-strength
                    r-move $ map (field states :right-move) refine-strength
                    r-delta $ field delta :right-move
                    l-delta $ field delta :left-move
                    camera @*global-camera
                    left-a? $ field states :left-a?
                    right-b? $ field states :right-b?
                    left-b? $ field states :left-b?
                  ; println |L l-move |R r-move
                  when
                    not= 0 $ nth l-move 1
                    move-viewer-by! 0 0 $ negate
                      * 0.6 elapsed $ nth l-move 1
                  when
                    not= 0 $ nth l-move 0
                    rotate-viewer-by! $ * -0.01 elapsed (nth l-move 0)
                  when
                    and (not left-a?) (not left-b?)
                      not= ([] 0 0) r-move
                    move-viewer-by!
                      * 0.4 elapsed $ nth r-move 0
                      * 0.4 elapsed $ nth r-move 1
                      , 0
                  when
                    and left-a? $ not= 0 (nth r-delta 1)
                    shift-viewer-by! $ * 1 (nth r-delta 1) elapsed
                  when
                    and left-a? $ not= 0 (nth r-delta 0)
                    rotate-viewer-by! $ * -0.1 (nth r-delta 0) elapsed
                  when (and left-b? right-b?)
                    let
                        shift @*viewer-y-shift
                      cond
                          < shift -0.06
                          shift-viewer-by! $ * 2 elapsed
                        (> shift 0.06)
                          shift-viewer-by! $ * -2 elapsed
                        (< (js-number (js/Math.abs shift)) 0.06)
                          shift-viewer-by! false
                        true nil
                  when
                    and left-b? $ or
                      not= r-move $ [] 0 0
                      not= r-delta $ [] 0 0
                    on-control-event r-move r-delta elapsed
          :examples $ []
          :schema $ :: 'Dynamic
        |handle-key-event $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn handle-key-event (event)
              let
                  angle @*viewer-angle
                  key $ unsafe-coerce
                    .-key $ ffi-object event
                    , String
                  shift? $ unsafe-coerce
                    .-shiftKey $ ffi-object event
                    , Bool
                case-default key nil
                  |ArrowDown $ if shift?
                    tween-move-camera! $ [] :shift -1
                    tween-move-camera! $ [] :move 0 -2 0
                  |ArrowUp $ if shift?
                    tween-move-camera! $ [] :shift 1
                    tween-move-camera! $ [] :move 0 2 0
                  |a $ tween-move-camera! ([] :angle 0.04)
                  |d $ tween-move-camera! ([] :angle -0.04)
                  |b $ tween-move-camera!
                    [] :angle 1.653959 $ ; "|manual value for turn back"
                  |w $ &let (a @*viewer-angle)
                    tween-move-camera! $ [] :move
                      &* 4 $ cos a
                      , 0
                        &* -4 $ sin a
                  |s $ &let (a @*viewer-angle)
                    tween-move-camera! $ [] :move
                      &* -2 $ cos a
                      , 0
                        &* 2 $ sin a
                  |ArrowLeft $ &let
                    a $ &+ @*viewer-angle (&/ &PI 2)
                    tween-move-camera! $ [] :move
                      &* 1 $ cos a
                      , 0
                        &* -1 $ sin a
                  |ArrowRight $ &let
                    a $ &- @*viewer-angle (&/ &PI 2)
                    tween-move-camera! $ [] :move
                      &* 1 $ cos a
                      , 0
                        &* -1 $ sin a
          :examples $ []
          :schema $ :: 'Dynamic
        |hclx $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn hclx (h c l) (hcl-to-hex h c l)
          :examples $ []
          :schema $ :: 'Dynamic
        |hsluvx $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn hsluvx (h c l)
              let
                  color $ new THREE/Color
                  conv $ new Hsluv
                set! (.-hsluv_h conv) h
                set! (.-hsluv_s conv) c
                set! (.-hsluv_l conv) l
                .!hsluvToRgb conv
                .!getHex $ ffi-object
                  .!setRGB (ffi-object color)
                    .-rgb_r $ ffi-object conv
                    .-rgb_g $ ffi-object conv
                    .-rgb_r $ ffi-object conv
          :examples $ []
          :schema $ :: 'Dynamic
        |hslx $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn hslx (h s l)
              let
                  c $ new THREE/Color
                .!getHex $ ffi-object
                  .!setHSL (ffi-object c) (/ h 360) (/ s 100) (/ l 100)
          :examples $ []
          :schema $ :: 'Dynamic
        |init-controls! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn init-controls! () $ let
                renderer $ ffi-object @*global-renderer
                scene $ ffi-object @*global-scene
                xr $ ffi-object (.-xr renderer)
                ctrl-0 $ ffi-object (.!getController xr 0)
                ctrl-1 $ ffi-object (.!getController xr 1)
                ctrl-grip-0 $ ffi-object (.!getControllerGrip xr 0)
                ctrl-grip-1 $ ffi-object (.!getControllerGrip xr 1)
                hand-0 $ ffi-object (.!getHand xr 0)
                hand-1 $ ffi-object (.!getHand xr 1)
                controllerModelFactory $ ffi-object (new XRControllerModelFactory)
                handModelFactory $ ffi-object (new XRHandModelFactory)
                line-geo $ ffi-object
                  -> (new THREE/BufferGeometry)
                    .!setFromPoints $ js-array (new THREE/Vector3 0 0 0) (new THREE/Vector3 0 0 -1)
                line $ ffi-object (new THREE/Line line-geo)
              .!appendChild (ffi-object js/document.body)
                .!createButton VRButton renderer $ js-object
                  :requiredFeatures $ js-array |hand-tracking
              .!add ctrl-grip-0 $ .!createControllerModel controllerModelFactory ctrl-grip-0
              .!add ctrl-grip-1 $ .!createControllerModel controllerModelFactory ctrl-grip-1
              .!add hand-0 $ .!createHandModel handModelFactory hand-0
              .!add hand-1 $ .!createHandModel handModelFactory hand-1
              .!add scene ctrl-0
              .!add scene ctrl-1
              .!add scene ctrl-grip-0
              .!add scene ctrl-grip-1
              .!add scene hand-0
              .!add scene hand-1
              set! (.-name line) |line
              ->
                ffi-object $ .-scale (ffi-object line)
                , .-z $ set! 5
              .!add ctrl-0 $ .!clone line
              .!add ctrl-1 $ .!clone line
              listen-on-controller! ctrl-0
              listen-on-controller! ctrl-1
          :examples $ []
          :schema $ :: 'Dynamic
        |init-renderer! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn init-renderer! (canvas-el options) (.!init RectAreaLightUniformsLib)
              reset! *global-renderer $ new THREE/WebGLRenderer
                js-object (:canvas canvas-el) (:antialias true)
              set!
                .-enabled $ ffi-object
                  .-xr $ ffi-object @*global-renderer
                , true
              ; if (:shadow-map? options)
                &let
                  m $ -> @*global-renderer .-shadowMap
                  -> m .-enabled $ set! true
                  -> m .-type $ set! THREE/VSMShadowMap
              ; reset! *global-composer $ new EffectComposer @*global-renderer
              ; let
                (render-scene (new RenderPass @*global-scene @*global-camera))
                .!addPass @*global-composer render-scene
              ; &doseq
                pass $ either (:composer-passes options) ([])
                .!addPass @*global-composer pass
              if
                some? $ field options :background
                .!setClearColor @*global-renderer (field options :background) 1
              ; set! (.-physicallyCorrectLights @*global-renderer) true
              ; set! (.-gammaFactor @*global-renderer) 22
              .!setPixelRatio @*global-renderer $ either
                js-number $ .-devicePixelRatio (ffi-object js/window)
                , 1
              .!setSize @*global-renderer
                js-number $ .-innerWidth (ffi-object js/window)
                js-number $ .-innerHeight (ffi-object js/window)
              .!setAnimationLoop @*global-renderer $ fn (t & aa)
                let
                    prev-t @*global-time
                  reset! *global-time t
                  if
                    js-present? $ .!getSession
                      ffi-object $ .-xr (ffi-object @*global-renderer)
                    let
                        session $ ffi-object
                          .!getSession $ ffi-object
                            .-xr $ ffi-object @*global-renderer
                        p0 $ -> session .-inputSources .?-0
                        p1 $ -> session .-inputSources .?-1
                      let
                          d $ ->
                            []
                              if (js-present? p0) (read-input p0)
                              if (js-present? p1) (read-input p1)
                            filter some?
                        if
                          not $ empty? d
                          on-gamepad-event
                            last $ option:unwrap-or (first d) ([])
                            * 0.001 $ - t prev-t
                .!updateProjectionMatrix @*global-camera
                .!render @*global-renderer @*global-scene @*global-camera
              ; .!setSize @*global-composer js/window.innerWidth js/window.innerHeight $ .!addEventListener (ffi-object canvas-el) |click
                fn (event) (on-canvas-click event)
              .!addEventListener (ffi-object js/window) |resize $ fn (event)
                js/console.log |resize
                  .-innerWidth $ ffi-object js/window
                  .-innerHeight $ ffi-object js/window
                set!
                  .-aspect $ ffi-object @*global-camera
                  /
                    js-number $ .-innerWidth (ffi-object js/window)
                    js-number $ .-innerHeight (ffi-object js/window)
                .!setSize @*global-renderer
                  js-number $ .-innerWidth (ffi-object js/window)
                  js-number $ .-innerHeight (ffi-object js/window)
                .!updateProjectionMatrix @*global-camera
                ; .!setSize @*global-composer js/window.innerWidth js/window.innerHeight
                ; .!render @*global-composer
                .!render @*global-renderer @*global-scene @*global-camera
          :examples $ []
          :schema $ :: 'Dynamic
        |js-number $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn js-number (value) (unsafe-coerce value Number)
          :examples $ []
          :schema $ :: 'Dynamic
        |listen-on-controller! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn listen-on-controller! (controller)
              let
                  temp-matrix $ ffi-object (new THREE/Matrix4)
                  raycaster $ ffi-object (new THREE/Raycaster)
                .!addEventListener (ffi-object controller) |selectstart $ fn (event) (.!identity temp-matrix)
                  .!extractRotation temp-matrix $ .-matrixWorld (ffi-object controller)
                  .!setFromMatrixPosition
                    ffi-object $ .-origin
                      ffi-object $ .-ray raycaster
                    .-matrixWorld $ ffi-object controller
                  .!set
                    ffi-object $ .-direction
                      ffi-object $ .-ray raycaster
                    , 0 0 -1
                  .!applyMatrix4
                    ffi-object $ .-direction
                      ffi-object $ .-ray raycaster
                    , temp-matrix
                  let
                      objects $ let
                          children $ js-array
                          collect! $ fn (x) (.!push children x)
                        collect-children @*global-scene collect!
                        , children
                      intersects $ ffi-object
                        ->
                          ffi-object $ .!intersectObjects raycaster objects
                          .!filter $ fn (target pos _xs)
                            js-present? $ .-event
                              ffi-object $ .-object (ffi-object target)
                    if
                      js-present? $ .-0 (ffi-object intersects)
                      call-event-on-target!
                        ffi-object $ .-0 (ffi-object intersects)
                        , event
          :examples $ []
          :schema $ :: 'Dynamic
        |move-viewer-by! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn move-viewer-by! (x0 y0 z0)
              let-sugar
                  camera @*global-camera
                  ([] dx dy dz) (to-viewer-axis x0 y0 z0)
                  position $ ffi-object
                    .-position $ ffi-object camera
                  x $ &+
                    js-number $ .-x position
                    , dx
                  y $ &+
                    js-number $ .-y position
                    , dy
                  z $ &+
                    js-number $ .-z position
                    , dz
                ; println ([] x0 y0 z0) |=> $ [] dx dy dz
                set! (.-x position) x
                set! (.-y position) y
                set! (.-z position) z
                .!lookAt camera $ new-lookat-point
                .!render @*global-renderer @*global-scene @*global-camera
          :examples $ []
          :schema $ :: 'Dynamic
        |new-lookat-point $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn new-lookat-point () $ let-sugar
                camera @*global-camera
                position $ ffi-object
                  .-position $ ffi-object camera
                x2 $ &+
                  js-number $ .-x position
                  &* 4 $ cos @*viewer-angle
                y2 $ &+
                  js-number $ .-y position
                  &* 0.2 @*viewer-y-shift
                z2 $ &+
                  js-number $ .-z position
                  &* -4 $ sin @*viewer-angle
              new THREE/Vector3 x2 y2 z2
          :examples $ []
          :schema $ :: 'Dynamic
        |read-input $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn read-input (p0)
              let
                  gamepad $ ffi-object
                    .-gamepad $ ffi-object p0
                  axes $ ffi-object (.-axes gamepad)
                  buttons $ ffi-object (.-buttons gamepad)
                if
                      >
                        js-number $ .-length (ffi-object buttons)
                        , 5
                  let
                      data $ {}
                        :v1 $ js-number
                          .-value $ ffi-object (.-0 buttons)
                        :v2 $ js-number
                          .-value $ ffi-object (.-1 buttons)
                        :a $ js-number
                          .-value $ ffi-object (.-4 buttons)
                        :b $ js-number
                          .-value $ ffi-object (.-5 buttons)
                        :dx $ js-number (.-2 axes)
                        :dy $ js-number (.-3 axes)
                      controller $ ffi-object
                        .!getController
                          ffi-object $ .-xr (ffi-object @*global-renderer)
                          , 0
                      grip $ ffi-object
                        .!getControllerGrip
                          ffi-object $ .-xr (ffi-object @*global-renderer)
                          , 0
                      rot $ ffi-object (.-rotation controller)
                      rotation $ :: :v3
                        js-number $ .-x rot
                        js-number $ .-y rot
                        js-number $ .-z rot
                    if (not= data data0)
                      []
                        turn-tag $ unsafe-coerce
                          .-handedness $ ffi-object p0
                          , String
                        {}
                          :v1 $ js-number
                            .-value $ ffi-object (.-0 buttons)
                          :v2 $ js-number
                            .-value $ ffi-object (.-1 buttons)
                          :a $ >
                            js-number $ .-value
                              ffi-object $ .-4 buttons
                            , 0.5
                          :b $ >
                            js-number $ .-value
                              ffi-object $ .-5 buttons
                            , 0.5
                          :dx $ js-number (.-2 axes)
                          :dy $ js-number (.-3 axes)
                          :rotation rotation
                          :forward $ camera-direction-for 0 0 -1
                          :upward $ camera-direction-for 0 1 0
                          :rightward $ camera-direction-for 1 0 0
                  , nil
          :examples $ []
          :schema $ :: 'Dynamic
        |refine-strength $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn refine-strength (x)
              &* x $ sqrt
                js-number $ js/Math.abs (&* x 0.02)
          :examples $ []
          :schema $ :: 'Dynamic
        |render-canvas! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn render-canvas! (markup dispatch!) (; js/console.log |render markup) (reset! *proxied-dispatch dispatch!)
              if (some? @*global-tree)
                let
                    collect! $ fn (x) (swap! *tmp-changes conj x)
                  reset! *tmp-changes $ []
                  diff-tree @*global-tree markup ([]) collect!
                  apply-changes @*tmp-changes
                build-tree ([]) (purify-tree markup)
              reset! *global-tree markup
              ; .!render @*global-renderer @*global-scene @*global-camera
          :examples $ []
          :schema $ :: 'Dynamic
        |rotate-viewer-by! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn rotate-viewer-by! (x)
              let
                  camera @*global-camera
                swap! *viewer-angle &+ x
                .!lookAt camera $ new-lookat-point
                .!render @*global-renderer @*global-scene @*global-camera
          :examples $ []
          :schema $ :: 'Dynamic
        |shift-viewer-by! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn shift-viewer-by! (x)
              let
                  camera @*global-camera
                if (= x false) (reset! *viewer-y-shift 0)
                  swap! *viewer-y-shift &+ $ * 2 x
                .!lookAt camera $ new-lookat-point
                .!render @*global-renderer @*global-scene @*global-camera
          :examples $ []
          :schema $ :: 'Dynamic
        |to-viewer-axis $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn to-viewer-axis (x y z)
              let
                  length $ sqrt
                    + (pow x 2) (pow y 2) (pow z 2)
                  angle @*viewer-angle
                  project-distance 20
                  shift @*viewer-y-shift
                  v-angle $ js-number
                    js/Math.atan $ / shift project-distance
                  from-y $ v3
                    -> y
                      * $ js-number
                        js/Math.cos $ + v-angle half-pi
                      * $ js-number (js/Math.cos angle)
                    -> y $ *
                      js-number $ js/Math.sin (+ v-angle half-pi)
                    -> y
                      * $ js-number
                        js/Math.cos $ + v-angle half-pi
                      * $ js-number (js/Math.sin angle)
                      negate
                  from-x $ wo-log
                    v3
                      -> x $ *
                        js-number $ js/Math.cos (- angle half-pi)
                      , 0 $ -> x
                        * $ js-number
                          js/Math.sin $ - angle half-pi
                        negate
                  from-z $ v3
                    -> z (negate)
                      * $ js-number (js/Math.cos v-angle)
                      * $ js-number (js/Math.cos angle)
                    -> z (negate)
                      * $ js-number (js/Math.sin v-angle)
                    -> z (negate)
                      * $ js-number (js/Math.cos v-angle)
                      * $ js-number (js/Math.sin angle)
                      negate
                -> from-x (&v+ from-y) (&v+ from-z)
          :examples $ []
          :schema $ :: 'Dynamic
        |tween-call $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn tween-call (n d f)
              &doseq
                i $ range 1 n
                js/setTimeout
                  fn () $ f i
                  * d i
          :examples $ []
          :schema $ :: 'Dynamic
        |tween-move-camera! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn tween-move-camera! (control)
              let
                  camera @*global-camera
                tag-match control
                  (:shift shift)
                    tween-call 20 5 $ fn (i)
                      do
                        swap! *viewer-y-shift &+ $ / shift 10
                        .!lookAt camera $ new-lookat-point
                        .!render @*global-renderer @*global-scene @*global-camera
                  (:angle angle)
                    tween-call 20 5 $ fn (i)
                      swap! *viewer-angle &+ $ / angle 10
                      do
                        .!lookAt camera $ new-lookat-point
                        .!render @*global-renderer @*global-scene @*global-camera
                  (:move dx dy dz)
                    tween-call 20 5 $ fn (i)
                      let-sugar
                          position $ ffi-object
                            .-position $ ffi-object camera
                          x $ &+
                            js-number $ .-x position
                            / dx 10
                          y $ &+
                            js-number $ .-y position
                            / dy 10
                          z $ &+
                            js-number $ .-z position
                            / dz 10
                        set! (.-x position) x
                        set! (.-y position) y
                        set! (.-z position) z
                        .!lookAt camera $ new-lookat-point
                        .!render @*global-renderer @*global-scene @*global-camera
                  _ $ println "|unknown camera control:" control
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote
          ns quatrefoil.core $ :require
            quatrefoil.dsl.diff :refer $ diff-tree
            quatrefoil.dsl.object3d-dom :refer $ build-tree on-canvas-click on-control-event call-event-on-target! on-gamepad-event
            quatrefoil.util.core :refer $ purify-tree collect-children
            quatrefoil.dsl.patch :refer $ apply-changes
            quatrefoil.schema :refer $ Component
            |three :as THREE
            quatrefoil.globals :refer $ *global-tree *global-camera *global-renderer *global-time *global-composer *global-scene *proxied-dispatch *viewer-angle *viewer-y-shift
            |three/examples/jsm/lights/RectAreaLightUniformsLib :refer $ RectAreaLightUniformsLib
            |three/examples/jsm/postprocessing/EffectComposer :refer $ EffectComposer
            |three/examples/jsm/postprocessing/RenderPass :refer $ RenderPass
            |three/addons/webxr/XRControllerModelFactory.js :refer $ XRControllerModelFactory
            |three/addons/webxr/XRHandModelFactory.js :refer $ XRHandModelFactory
            touch-control.core :refer $ render-control! control-states start-control-loop! clear-control-loop!
            quaternion.complex :refer $ &c* &c+
            quaternion.vector :refer $ &v+ v3
            |@quatrefoil/utils :refer $ hcl-to-hex
            |hsluv :refer $ Hsluv
            |three/addons/webxr/VRButton.js :refer $ VRButton
    |quatrefoil.cursor $ %{} 'FileEntry
      :defs $ {}
        |update-states $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn update-states (store pair)
              let[] (cursor new-state) pair $ assoc-in store
                concat ([] :states) cursor $ [] :data
                , new-state
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote (ns quatrefoil.cursor)
    |quatrefoil.dsl.diff $ %{} 'FileEntry
      :defs $ {}
        |diff-children $ %{} 'CodeEntry (:doc |)
          :code $ quote
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
          :examples $ []
          :schema $ :: 'Dynamic
        |diff-events $ %{} 'CodeEntry (:doc |)
          :code $ quote
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
          :examples $ []
          :schema $ :: 'Dynamic
        |diff-material $ %{} 'CodeEntry (:doc |)
          :code $ quote
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
          :examples $ []
          :schema $ :: 'Dynamic
        |diff-params $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn diff-params (prev-params params coord collect!) (; "|unused code, when params changed, geometry would be recreated, so not diffed")
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
          :examples $ []
          :schema $ :: 'Dynamic
        |diff-tree $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn diff-tree (prev-tree tree coord collect!) (; js/console.log |Diffing: coord prev-tree tree)
              cond
                  = nil prev-tree tree
                  &let () nil
                (and (comp? prev-tree) (comp? tree) (not= (field prev-tree :name) (field tree :name)))
                  collect! $ [] coord :replace-element (purify-tree tree)
                (comp? prev-tree)
                  recur (field prev-tree :tree) tree coord collect!
                (comp? tree)
                  recur prev-tree (field tree :tree) coord collect!
                (and (some? tree) (nil? prev-tree))
                  collect! $ [] coord :add-element tree
                (and (some? prev-tree) (nil? tree))
                  collect! $ [] coord :remove-element
                (not= (field prev-tree :name) (field tree :name))
                  collect! $ [] coord :replace-element (purify-tree tree)
                (and (= :text (field tree :name) (field prev-tree :name)) (not= (field tree :params) (field prev-tree :params)))
                  collect! $ [] coord :replace-element (purify-tree tree)
                (and (= (field tree :name) (field prev-tree :name)) (not= (field tree :params) (field prev-tree :params)))
                  collect! $ [] coord :replace-element (purify-tree tree)
                true $ do
                  ; diff-params (:params prev-tree) (:params tree) coord collect!
                  if
                    not= (field prev-tree :position) (field tree :position)
                    collect! $ [] coord :change-position (field tree :position)
                  if
                    not= (field prev-tree :rotation) (field tree :rotation)
                    collect! $ [] coord :change-rotation (field tree :rotation)
                  if
                    not= (field prev-tree :scale) (field tree :scale)
                    collect! $ [] coord :change-scale (field tree :scale)
                  if
                    not= (field prev-tree :attributes) (field tree :attributes)
                    collect! $ [] coord :change-attributes (field tree :attributes)
                  diff-material (field prev-tree :material) (field tree :material) coord collect!
                  diff-events (field prev-tree :event) (field tree :event) coord collect!
                  diff-children (field prev-tree :children) (field tree :children) coord collect!
          :examples $ []
          :schema $ :: 'Dynamic
        |field $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn field (value key)
              option:unwrap-or (get value key) nil
          :examples $ []
          :schema $ :: 'Dynamic
        |select-keys $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn select-keys (m xs)
              foldl ({})
                fn (acc x)
                  assoc acc x $ option:unwrap-or (get m x) nil
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote
          ns quatrefoil.dsl.diff $ :require
            quatrefoil.util.core :refer $ purify-tree
            quatrefoil.schema :refer $ comp? shape?
    |quatrefoil.dsl.object3d-dom $ %{} 'FileEntry
      :defs $ {}
        |*focused-coord $ %{} 'CodeEntry (:doc |)
          :code $ quote (defatom *focused-coord nil)
          :examples $ []
          :schema $ :: 'Dynamic
        |build-tree $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn build-tree (coord tree) (; js/console.log "|build tree:" coord tree)
              if (some? tree)
                let
                    object3d $ create-shape (assoc tree :children nil) coord
                    children $ -> (field tree :children) (.to-list)
                      map $ fn (entry)
                        update entry 1 $ fn (child)
                          build-tree
                            conj coord $ first entry
                            , child
                    virtual-element $ {} (:object3d object3d) (:children children)
                  ; js/console.log "|handle children" children $ :children tree
                  &doseq (entry children)
                    let
                        child $ last entry
                      ; js/console.log |Child: child entry
                      .!addBy object3d (first entry) child
                  , object3d
                new THREE/Object3D
          :examples $ []
          :schema $ :: 'Dynamic
        |call-event-on-target! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn call-event-on-target! (maybe-target event)
              let
                  element-tree @*global-tree
                  coord $ .-coord
                    ffi-object $ .-object (ffi-object maybe-target)
                  target-el $ find-element element-tree coord
                  maybe-handler $ field (field target-el :event) :click
                if (js-present? coord)
                  do
                    if (some? maybe-handler) (maybe-handler event @*proxied-dispatch) (println "|no handler" coord)
                    reset! *focused-coord coord
                    ; println "|focus to" coord
                  do (reset! *focused-coord nil) (eprintln "|lose focus")
          :examples $ []
          :schema $ :: 'Dynamic
        |create-ambient-light $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn create-ambient-light (params position)
              let
                  color $ field params :color
                  intensity $ either (field params :intensity) 1
                  object3d $ new THREE/AmbientLight color intensity
                set-position! object3d position
                ; js/console.log |Light: object3d
                , object3d
          :examples $ []
          :schema $ :: 'Dynamic
        |create-box-element $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn create-box-element (params position rotation scale material event coord)
              let
                  geometry $ new THREE/BoxGeometry (field params :width) (field params :height) (field params :depth)
                  object3d $ new THREE/Mesh geometry (create-material material)
                set-position! object3d position
                set-rotation! object3d rotation
                set-scale! object3d scale
                set!
                  .-castShadow $ ffi-object object3d
                  , true
                set!
                  .-receiveShadow $ ffi-object object3d
                  , true
                set!
                  .-coord $ ffi-object object3d
                  , coord
                set!
                  .-event $ ffi-object object3d
                  , event
                , object3d
          :examples $ []
          :schema $ :: 'Dynamic
        |create-buffer-object-element $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn create-buffer-object-element (params position rotation scale material)
              let
                  vertices $ new js/Float32Array
                    js-array & $ either (field params :vertices) ([])
                  indices $ js-array &
                    either (field params :indices) ([])
                  geometry $ new THREE/BufferGeometry
                  object3d $ do
                    .!setAttribute geometry |position $ new THREE/BufferAttribute vertices 3
                    if
                      >
                        js-number $ .-length (ffi-object indices)
                        , 0
                      .!setIndex geometry indices
                    .!computeVertexNormals geometry
                    new THREE/Mesh geometry $ create-material material
                set!
                  .-castShadow $ ffi-object object3d
                  , true
                set!
                  .-receiveShadow $ ffi-object object3d
                  , true
                set-position! object3d position
                set-rotation! object3d rotation
                set-scale! object3d scale
                , object3d
          :examples $ []
          :schema $ :: 'Dynamic
        |create-directional-light $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn create-directional-light (params position)
              let
                  color $ field params :color
                  intensity $ field params :intensity
                  object3d $ new THREE/DirectionalLight color intensity
                set!
                  .-castShadow $ ffi-object object3d
                  , true
                ->
                  ffi-object $ .-shadow (ffi-object object3d)
                  , .-bias $ set! -0.0005
                set-position! object3d position
                js/console.log "|directional light:" object3d
                , object3d
          :examples $ []
          :schema $ :: 'Dynamic
        |create-group-element $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn create-group-element (params position rotation scale)
              let
                  object3d $ new THREE/Group
                set-position! object3d position
                set-rotation! object3d rotation
                set-scale! object3d scale
                , object3d
          :examples $ []
          :schema $ :: 'Dynamic
        |create-line-element $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn create-line-element (params position rotation scale material)
              let
                  points $ &let
                    ps $ js-array
                    &doseq
                      p $ field params :points
                      .!push ps $ new THREE/Vector3 & p
                    , ps
                  geometry $ -> (new THREE/BufferGeometry) (.!setFromPoints points)
                  object3d $ new THREE/Line geometry (create-material material)
                set-position! object3d position
                set-rotation! object3d rotation
                set-scale! object3d scale
                , object3d
          :examples $ []
          :schema $ :: 'Dynamic
        |create-line-segments-element $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn create-line-segments-element (params position rotation scale material)
              let
                  points $ &let
                    ps $ js-array
                    if
                      some? $ field params :segments
                      &doseq
                        segment $ field params :segments
                        let
                            p0 $ nth segment 0
                            p1 $ nth segment 1
                          .!push ps (new THREE/Vector3 & p0) (new THREE/Vector3 & p1)
                      &doseq
                        p $ field params :points
                        .!push ps $ new THREE/Vector3 & p
                    , ps
                  geometry $ -> (new THREE/BufferGeometry) (.!setFromPoints points)
                  object3d $ new THREE/LineSegments geometry (create-material material)
                set-position! object3d position
                set-rotation! object3d rotation
                set-scale! object3d scale
                , object3d
          :examples $ []
          :schema $ :: 'Dynamic
        |create-material $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn create-material (material)
              &let
                m $ case-default (field material :kind)
                  do (js/console.warn "|Unknown material:" material)
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
                  :mesh-line $ new MeshLineMaterial
                    to-js-data $ dissoc material :kind
                  :raw-shader $ new THREE/RawShaderMaterial
                    let
                        options $ to-js-data (dissoc material :kind)
                      , options
                set!
                  .-side $ ffi-object m
                  , THREE/DoubleSide
                , m
          :examples $ []
          :schema $ :: 'Dynamic
        |create-mesh-line-element $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn create-mesh-line-element (params position rotation scale material)
              let
                  points $ &let
                    ps $ js-array
                    &doseq
                      p $ field params :points
                      .!push ps $ new THREE/Vector3 & p
                    , ps
                  geometry $ let
                      g $ new MeshLineGeometry
                    .!setPoints g points
                    , g
                  object3d $ new THREE/Mesh geometry (create-material material)
                set-position! object3d position
                set-rotation! object3d rotation
                set-scale! object3d scale
                set!
                  .-raycast $ ffi-object object3d
                  , raycast
                , object3d
          :examples $ []
          :schema $ :: 'Dynamic
        |create-parametric-element $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn create-parametric-element (params position rotation scale material)
              let
                  func $ either (field params :func)
                    fn (a b data) ([] a b 0)
                  data $ field params :data
                  slices $ either (field params :slices) 10
                  stacks $ either (field params :stacks) 10
                  geometry $ new ParametricGeometry
                    fn (u v target)
                      let[] (x y z) (func u v data) (.!set target x y z)
                    , slices stacks
                  object3d $ new THREE/Mesh geometry (create-material material)
                set!
                  .-castShadow $ ffi-object object3d
                  , true
                set!
                  .-receiveShadow $ ffi-object object3d
                  , true
                set-position! object3d position
                set-rotation! object3d rotation
                set-scale! object3d scale
                , object3d
          :examples $ []
          :schema $ :: 'Dynamic
        |create-plane-reflector $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn create-plane-reflector (params position rotation scale)
              let
                  geometry $ new THREE/PlaneGeometry
                    either (field params :width) 80
                    either (field params :height) 80
                  object3d $ new Reflector geometry
                    js-object
                      |clipBias $ either (field params :clip-bias) 0.003
                      |textureWidth $ *
                        js-number $ .-innerWidth (ffi-object js/window)
                        js-number $ .-devicePixelRatio (ffi-object js/window)
                      |textureHeight $ *
                        js-number $ .-innerHeight (ffi-object js/window)
                        js-number $ .-devicePixelRatio (ffi-object js/window)
                      |color $ either (field params :color) |0x7777ff
                set-position! object3d position
                set-rotation! object3d rotation
                set-scale! object3d scale
                , object3d
          :examples $ []
          :schema $ :: 'Dynamic
        |create-point-light $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn create-point-light (params position)
              let
                  color $ field params :color
                  intensity $ field params :intensity
                  distance $ field params :distance
                  object3d $ new THREE/PointLight color intensity distance
                set!
                  .-castShadow $ ffi-object object3d
                  , true
                set-position! object3d position
                ->
                  ffi-object $ .-shadow (ffi-object object3d)
                  , .-bias $ set! -0.005
                ; js/console.log |Light: object3d
                , object3d
          :examples $ []
          :schema $ :: 'Dynamic
        |create-polyhedron-element $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn create-polyhedron-element (params position rotation scale material)
              let
                  vertices $ js-array &
                    concat & $ field params :vertices
                  indices $ js-array &
                    concat & $ field params :indices
                  radius $ field params :radius
                  detail $ field params :detail
                  geometry $ new THREE/PolyhedronGeometry vertices indices radius detail
                  object3d $ new THREE/Mesh geometry (create-material material)
                set!
                  .-castShadow $ ffi-object object3d
                  , true
                set!
                  .-receiveShadow $ ffi-object object3d
                  , true
                set-position! object3d position
                set-rotation! object3d rotation
                set-scale! object3d scale
                , object3d
          :examples $ []
          :schema $ :: 'Dynamic
        |create-rect-area-light $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn create-rect-area-light (params position rotation)
              let
                  color $ field params :color
                  intensity $ field params :intensity
                  width $ field params :width
                  height $ field params :height
                  look-at $ field params :look-at
                  object3d $ new THREE/RectAreaLight color intensity width height
                .!lookAt object3d & look-at
                set!
                  .-castShadow $ ffi-object object3d
                  , true
                set-position! object3d position
                set-rotation! object3d rotation
                ; js/console.log "|Area Light:" object3d
                .!add object3d $ new RectAreaLightHelper object3d
                , object3d
          :examples $ []
          :schema $ :: 'Dynamic
        |create-shader-mesh $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn create-shader-mesh (attributes params position rotation scale material)
              let
                  vertices $ new js/Float32Array
                    js-array & $ either (field params :vertices) ([])
                  geometry $ let
                      g $ new THREE/BufferGeometry
                    set-geometry-attributes! g attributes
                    , g
                  object3d $ new THREE/Mesh geometry (create-material material)
                set!
                  .-castShadow $ ffi-object object3d
                  , true
                set!
                  .-receiveShadow $ ffi-object object3d
                  , true
                set-position! object3d position
                set-rotation! object3d rotation
                set-scale! object3d scale
                , object3d
          :examples $ []
          :schema $ :: 'Dynamic
        |create-shape $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn create-shape (element coord)
              ; js/console.log |Element: element $ :coord element
              let
                  params $ field element :params
                  position $ field element :position
                  scale $ field element :scale
                  rotation $ field element :rotation
                  material $ either (field element :material)
                    {} (:kind :mesh-basic) (:color 0xa0a0a0)
                  event $ field element :event
                case-default (field element :name)
                  do (js/console.warn "|Unknown element" element) (new THREE/Object3D)
                  :scene @*global-scene
                  :group $ create-group-element params position rotation scale
                  :box $ create-box-element params position rotation scale material event coord
                  :sphere $ create-sphere-element params position rotation scale material event coord
                  :point-light $ create-point-light params position
                  :spot-light $ create-spot-light params position
                  :directional-light $ create-directional-light params position
                  :ambient-light $ create-ambient-light params position
                  :rect-area-light $ create-rect-area-light params position rotation
                  :text $ create-text-element params position rotation scale material
                  :line $ create-line-element params position rotation scale material
                  :line-segments $ create-line-segments-element params position rotation scale material
                  :mesh-line $ create-mesh-line-element params position rotation scale material
                  :spline $ create-spline-element params position rotation scale material
                  :torus $ create-torus-element params position rotation scale material
                  :tube $ create-tube-element params position rotation scale material
                  :shape $ create-shape-element params position rotation scale material
                  :polyhedron $ create-polyhedron-element params position rotation scale material
                  :plane-reflector $ create-plane-reflector params position rotation scale
                  :parametric $ create-parametric-element params position rotation scale material
                  :buffer-object $ create-buffer-object-element params position rotation scale material
                  :shader-mesh $ create-shader-mesh (field element :attributes) params position rotation scale material
                  :some-object $ create-some-object params position rotation scale material
          :examples $ []
          :schema $ :: 'Dynamic
        |create-shape-element $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn create-shape-element (params position rotation scale material)
              let
                  shape-2d $ &let
                    s $ new THREE/Shape
                    &doseq
                      op $ field params :path
                      write-shape-path! s op
                    , s
                  geometry $ new THREE/ShapeGeometry shape-2d
                  object3d $ new THREE/Mesh geometry (create-material material)
                set!
                  .-castShadow $ ffi-object object3d
                  , true
                set!
                  .-receiveShadow $ ffi-object object3d
                  , true
                set-position! object3d position
                set-rotation! object3d rotation
                set-scale! object3d scale
                , object3d
          :examples $ []
          :schema $ :: 'Dynamic
        |create-some-object $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn create-some-object (params position rotation scale material)
              let
                  object3d $ new THREE/Object3D
                  obj $ get @*loaded-objects (field params :key)
                set-position! object3d position
                set-rotation! object3d rotation
                set-scale! object3d scale
                set!
                  .-castShadow $ ffi-object object3d
                  , true
                set!
                  .-receiveShadow $ ffi-object object3d
                  , true
                ; set! (.-coord object3d) coord
                ; set! (.-event object3d) event
                if (some? obj) (.!add object3d obj)
                  js/console.warn "|object not loaded for" $ field params :key
                , object3d
          :examples $ []
          :schema $ :: 'Dynamic
        |create-sphere-element $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn create-sphere-element (params position rotation scale material event coord)
              let
                  geometry $ new THREE/SphereGeometry
                    or (field params :radius) 8
                    or (field params :width-segments) 12
                    or (field params :height-segments) 12
                  object3d $ new THREE/Mesh geometry (create-material material)
                set-position! object3d position
                set-rotation! object3d rotation
                set-scale! object3d scale
                set!
                  .-coord $ ffi-object object3d
                  , coord
                set!
                  .-castShadow $ ffi-object object3d
                  , true
                set!
                  .-receiveShadow $ ffi-object object3d
                  , true
                set!
                  .-event $ ffi-object object3d
                  , event
                ; js/console.log |Sphere: object3d
                , object3d
          :examples $ []
          :schema $ :: 'Dynamic
        |create-spline-element $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn create-spline-element (params position rotation scale material)
              let
                  points0 $ field params :points
                  curve $ new THREE/CatmullRomCurve3
                    js-array & $ -> points0
                      map $ fn (p) (new THREE/Vector3 & p)
                  points $ .!getPoints curve
                    * 16 $ count points0
                  geometry $ -> (new THREE/BufferGeometry) (.!setFromPoints points)
                  object3d $ new THREE/Line geometry (create-material material)
                set!
                  .-castShadow $ ffi-object object3d
                  , true
                set!
                  .-receiveShadow $ ffi-object object3d
                  , true
                set-position! object3d position
                set-rotation! object3d rotation
                set-scale! object3d scale
                , object3d
          :examples $ []
          :schema $ :: 'Dynamic
        |create-spot-light $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn create-spot-light (params position)
              let
                  color $ field params :color
                  intensity $ field params :intensity
                  distance $ field params :distance
                  angle $ or (field params :angle) (* 0.5 &PI)
                  penumbra $ or (field params :penumbra) 0.5
                  decay $ or (field params :decay) 1.5
                  object3d $ new THREE/SpotLight color intensity distance angle penumbra decay
                set!
                  .-castShadow $ ffi-object object3d
                  , true
                ->
                  ffi-object $ .-shadow (ffi-object object3d)
                  , .-bias $ set! -0.0005
                set-position! object3d position
                js/console.log |Light: object3d
                , object3d
          :examples $ []
          :schema $ :: 'Dynamic
        |create-text-element $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn create-text-element (params position rotation scale material)
              let
                  geometry $ new TextGeometry
                    or (field params :text) |Quatrefoil
                    to-js-data $ assoc params :font font-resource
                  object3d $ new THREE/Mesh geometry (create-material material)
                set-position! object3d position
                set-rotation! object3d rotation
                set-scale! object3d scale
                set!
                  .-castShadow $ ffi-object object3d
                  , true
                set!
                  .-receiveShadow $ ffi-object object3d
                  , true
                , object3d
          :examples $ []
          :schema $ :: 'Dynamic
        |create-torus-element $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn create-torus-element (params position rotation scale material)
              let
                  geometry $ ->
                    new THREE/TorusGeometry (field params :r1) (field params :r2) (field params :s1) (field params :s2) (field params :arc)
                  object3d $ new THREE/Mesh geometry (create-material material)
                set!
                  .-castShadow $ ffi-object object3d
                  , true
                set!
                  .-receiveShadow $ ffi-object object3d
                  , true
                set-position! object3d position
                set-scale! object3d scale
                , object3d
          :examples $ []
          :schema $ :: 'Dynamic
        |create-tube-element $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn create-tube-element (params position rotation scale material)
              let
                  points-fn $ field params :points-fn
                  factor $ field params :factor
                  geometry $ ->
                    new THREE/TubeGeometry (make-tube-curve points-fn factor)
                      -> (field params :tubular-segments)
                        either $ field params :tubular
                        either 40
                      either (field params :radius) 2
                      -> (field params :radial-segments)
                        either $ field params :radial
                        either 8
                      either (field params :closed?) false
                  object3d $ new THREE/Mesh geometry (create-material material)
                set!
                  .-castShadow $ ffi-object object3d
                  , true
                set!
                  .-receiveShadow $ ffi-object object3d
                  , true
                set-position! object3d position
                set-rotation! object3d rotation
                set-scale! object3d scale
                , object3d
          :examples $ []
          :schema $ :: 'Dynamic
        |ffi-object $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn ffi-object (value) (unsafe-coerce value JsObject)
          :examples $ []
          :schema $ :: 'Dynamic
        |field $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn field (value key)
              option:unwrap-or (get value key) nil
          :examples $ []
          :schema $ :: 'Dynamic
        |font-resource $ %{} 'CodeEntry (:doc |)
          :code $ quote
            def font-resource $ new Font
              js/JSON.parse $ load-file |assets/hind.json
          :examples $ []
          :schema $ :: 'Dynamic
        |js-number $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn js-number (value) (unsafe-coerce value Number)
          :examples $ []
          :schema $ :: 'Dynamic
        |load-file $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defmacro load-file (filename) (read-file filename)
          :examples $ []
          :schema $ :: 'Dynamic
        |on-canvas-click $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn on-canvas-click (event)
              let
                  mouse $ new THREE/Vector2
                  raycaster $ new THREE/Raycaster
                set!
                  .-x $ ffi-object mouse
                  dec $ * 2
                    /
                      js-number $ .-clientX (ffi-object event)
                      js-number $ .-innerWidth (ffi-object js/window)
                set!
                  .-y $ ffi-object mouse
                  - 1 $ * 2
                    /
                      js-number $ .-clientY (ffi-object event)
                      js-number $ .-innerHeight (ffi-object js/window)
                .!setFromCamera raycaster mouse @*global-camera
                let
                    intersects $ ->
                      .!intersectObjects raycaster $ let
                          children $ js-array
                          collect! $ fn (x) (.!push children x)
                        collect-children @*global-scene collect!
                        , children
                      .!filter $ fn (target pos _xs)
                        js-present? $ .-event
                          ffi-object $ .-object (ffi-object target)
                  ; js/console.log intersects
                  if
                    js-present? $ .-0 (ffi-object intersects)
                    call-event-on-target!
                      ffi-object $ .-0 (ffi-object intersects)
                      , event
                    do (reset! *focused-coord nil) (println "|lose focus")
          :examples $ []
          :schema $ :: 'Dynamic
        |on-control-event $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn on-control-event (move delta elapsed)
              if (some? @*focused-coord)
                let
                    coord @*focused-coord
                    element-tree @*global-tree
                    target-el $ find-element element-tree coord
                    maybe-handler $ field (field target-el :event) :control
                  if (some? maybe-handler) (maybe-handler move delta elapsed @*proxied-dispatch) (;nil println "|Found no handler for" coord)
                println "|no focused coord to control" @*focused-coord
          :examples $ []
          :schema $ :: 'Dynamic
        |on-gamepad-event $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn on-gamepad-event (info elapsed)
              if (some? @*focused-coord)
                let
                    coord @*focused-coord
                    element-tree @*global-tree
                    target-el $ find-element element-tree coord
                    maybe-handler $ field (field target-el :event) :gamepad
                  if (some? maybe-handler) (maybe-handler info elapsed @*proxied-dispatch) (;nil println "|Found no handler for" coord)
                println "|no focused coord to control" @*focused-coord
          :examples $ []
          :schema $ :: 'Dynamic
        |set-geometry-attributes! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn set-geometry-attributes! (g attributes)
              &doseq (info attributes)
                let
                    name $ turn-string (field info :id)
                    buffer $ field info :buffer
                    size $ field info :size
                    type $ field info :type
                    attr $ case-default type
                      do (js/console.warn "|use f32 as default attribute type")
                        new THREE/Float32BufferAttribute (js-array & buffer) size
                      :f32 $ new THREE/Float32BufferAttribute (js-array & buffer) size
                      :u8 $ new THREE/Float32BufferAttribute (js-array & buffer) size
                  .!setAttribute g name attr
          :examples $ []
          :schema $ :: 'Dynamic
        |set-perspective-camera! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn set-perspective-camera! (params)
              let
                  fov $ field params :fov
                  aspect $ field params :aspect
                  near $ field params :near
                  far $ field params :far
                  object3d $ new THREE/PerspectiveCamera fov aspect near far
                set-position! object3d $ field params :position
                reset! *global-camera object3d
                , object3d
          :examples $ []
          :schema $ :: 'Dynamic
        |set-position! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn set-position! (object position)
              cond
                  enum? position
                  tag-match position
                    (:v3 x y z)
                      .!set
                        ffi-object $ .-position (ffi-object object)
                        , x y z
                    _ $ raise "|unknown position, expected vector"
                (list? position)
                  let[] (x y z) position $ .!set
                    ffi-object $ .-position (ffi-object object)
                    , x y z
                (nil? position) (;nil "|do nothing")
                true $ raise "|unknown position"
          :examples $ []
          :schema $ :: 'Dynamic
        |set-rotation! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn set-rotation! (object3d rotation)
              if (some? rotation)
                let[] (x y z) rotation $ .!set
                  ffi-object $ .-rotation (ffi-object object3d)
                  , x y z
          :examples $ []
          :schema $ :: 'Dynamic
        |set-scale! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn set-scale! (object scale)
              if (some? scale)
                let[] (x y z) scale $ .!set
                  ffi-object $ .-scale (ffi-object object)
                  scale-zero x
                  scale-zero y
                  scale-zero z
          :examples $ []
          :schema $ :: 'Dynamic
        |write-shape-path! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn write-shape-path! (s op)
              tag-match op
                (:move-to x y) (.!moveTo s x y)
                (:line-to x y) (.!lineTo s x y)
                (:quadratic-curve-to x0 y0 x1 y1) (.!quadraticCurveTo s x0 y0 x1 y1)
                (:bezier-curve-to x0 y0 x1 y1 x2 y2) (.!bezierCurveTo s x0 y0 x1 y1 x2 y2)
                _ $ js/console.log "|Unknown shape path" op
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote
          ns quatrefoil.dsl.object3d-dom $ :require
            quatrefoil.util.core :refer $ purify-tree collect-children find-element scale-zero
            quatrefoil.globals :refer $ *loaded-objects
            |three :as THREE
            |three/examples/jsm/geometries/TextGeometry :refer $ TextGeometry
            quatrefoil.globals :refer $ *global-renderer *global-camera *global-scene *global-tree *proxied-dispatch
            |@quatrefoil/utils :refer $ make-tube-curve
            |three/examples/jsm/helpers/RectAreaLightHelper :refer $ RectAreaLightHelper
            |three/examples/jsm/objects/Reflector :refer $ Reflector
            |three/examples/jsm/loaders/FontLoader :refer $ Font
            |three/examples/jsm/geometries/ParametricGeometry :refer $ ParametricGeometry
            |meshline :refer $ MeshLineGeometry MeshLineMaterial raycast
    |quatrefoil.dsl.patch $ %{} 'FileEntry
      :defs $ {}
        |add-children $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn add-children (target coord op-data)
              &doseq (entry op-data)
                let-sugar
                      [] k tree
                      , entry
                  .!addBy target k $ build-tree (conj coord k) tree
          :examples $ []
          :schema $ :: 'Dynamic
        |add-element $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn add-element (target coord op-data)
              if (empty? coord) (js/console.warn "|Cannot remove by empty coord!")
                let
                    parent $ reach-object3d @*global-scene (butlast coord)
                  .!addBy parent (last coord) (build-tree coord op-data)
          :examples $ []
          :schema $ :: 'Dynamic
        |apply-changes $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn apply-changes (changes)
              ; js/console.log |changes (count changes) changes
              &doseq (change changes)
                let-sugar
                      [] coord op op-data
                      , change
                    target $ reach-object3d @*global-scene coord
                  ; js/console.log |Change: op coord op-data
                  case-default op (js/console.warn "|Unknown op:" op)
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
                      either op-data $ [] 1 1 1
                    :change-attributes $ set-geometry-attributes!
                      .-geometry $ ffi-object target
                      , op-data
          :examples $ []
          :schema $ :: 'Dynamic
        |ffi-object $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn ffi-object (value) (unsafe-coerce value JsObject)
          :examples $ []
          :schema $ :: 'Dynamic
        |remove-children $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn remove-children (target coord op-data)
              &doseq (child-key op-data) (.!removeBy target child-key)
          :examples $ []
          :schema $ :: 'Dynamic
        |remove-element $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn remove-element (target coord)
              if (empty? coord) (js/console.warn "|Cannot remove by empty coord!")
                let
                    parent $ reach-object3d @*global-scene (butlast coord)
                  .!removeBy parent $ last coord
          :examples $ []
          :schema $ :: 'Dynamic
        |remove-material $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn remove-material (target coord op-data)
              let
                  material $ ffi-object
                    .-material $ ffi-object target
                &doseq (entry op-data)
                  case-default entry (println "|Unknown material prop:" op-data)
                    :opacity $ set!
                      .-opacity $ ffi-object material
                      , 0.9
                    :transparent $ set!
                      .-transparent $ ffi-object material
                      , 1
          :examples $ []
          :schema $ :: 'Dynamic
        |replace-element $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn replace-element (target coord op-data)
              if (empty? coord) (js/console.warn "|Cannot replace with empty coord!")
                let
                    parent $ reach-object3d @*global-scene (butlast coord)
                  .!replaceBy parent (last coord) (build-tree coord op-data)
          :examples $ []
          :schema $ :: 'Dynamic
        |replace-material $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn replace-material (target coord op-data)
              set!
                .-material $ ffi-object target
                create-material op-data
          :examples $ []
          :schema $ :: 'Dynamic
        |update-material $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn update-material (target coord op-data) (; println "|Update material" coord op-data)
              let
                  material $ ffi-object
                    .-material $ ffi-object target
                ; js/console.log target
                &doseq
                  entry $ .to-list op-data
                  let[] (param new-value) entry $ case-default param (js/console.log "|Unknown param:" param)
                    :color $ .!set
                      ffi-object $ .-color (ffi-object material)
                      new THREE/Color new-value
                    :opacity $ set!
                      .-opacity $ ffi-object material
                      , new-value
                    :transparent $ set!
                      .-transparent $ ffi-object material
                      , new-value
                    :lineWidth $ set!
                      .-lineWidth $ ffi-object material
                      , new-value
                    :uniforms $ set!
                      .-uniforms $ ffi-object material
                      to-js-data new-value
                    :fragmentShader $ set!
                      .-fragmentShader $ ffi-object material
                      , new-value
                    :vertexShader $ set!
                      .-vertexShader $ ffi-object material
                      , new-value
                    :wireframe $ set!
                      .-wireframe $ ffi-object material
                      , new-value
                set!
                  .-needsUpdate $ ffi-object material
                  , true
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote
          ns quatrefoil.dsl.patch $ :require
            quatrefoil.dsl.object3d-dom :refer $ [] build-tree set-position! set-rotation! set-scale! create-material
            [] quatrefoil.util.core :refer $ [] reach-object3d scale-zero
            quatrefoil.dsl.object3d-dom :refer $ set-geometry-attributes!
            quatrefoil.globals :refer $ *global-scene
            |three :as THREE
    |quatrefoil.globals $ %{} 'FileEntry
      :defs $ {}
        |*global-camera $ %{} 'CodeEntry (:doc |)
          :code $ quote (defatom *global-camera nil)
          :examples $ []
          :schema $ :: 'Dynamic
        |*global-composer $ %{} 'CodeEntry (:doc |)
          :code $ quote (defatom *global-composer nil)
          :examples $ []
          :schema $ :: 'Dynamic
        |*global-renderer $ %{} 'CodeEntry (:doc |)
          :code $ quote (defatom *global-renderer nil)
          :examples $ []
          :schema $ :: 'Dynamic
        |*global-scene $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defatom *global-scene $ new THREE/Scene
          :examples $ []
          :schema $ :: 'Dynamic
        |*global-time $ %{} 'CodeEntry (:doc |)
          :code $ quote (defatom *global-time 0)
          :examples $ []
          :schema $ :: 'Dynamic
        |*global-tree $ %{} 'CodeEntry (:doc |)
          :code $ quote (defatom *global-tree nil)
          :examples $ []
          :schema $ :: 'Dynamic
        |*loaded-objects $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defatom *loaded-objects $ {}
          :examples $ []
          :schema $ :: 'Dynamic
        |*proxied-dispatch $ %{} 'CodeEntry (:doc |)
          :code $ quote (defatom *proxied-dispatch nil)
          :examples $ []
          :schema $ :: 'Dynamic
        |*viewer-angle $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defatom *viewer-angle $ &/ &PI 2
          :examples $ []
          :schema $ :: 'Dynamic
        |*viewer-y-shift $ %{} 'CodeEntry (:doc |)
          :code $ quote (defatom *viewer-y-shift 0)
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote
          ns quatrefoil.globals $ :require (|three :as THREE)
    |quatrefoil.math $ %{} 'FileEntry
      :defs $ {}
        |rand-around $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn rand-around (base x)
              + base (rand x) (* -0.5 x)
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote
          ns quatrefoil.math $ :require (|three :as THREE)
            |@calcit/std :refer $ rand
    |quatrefoil.schema $ %{} 'FileEntry
      :defs $ {}
        |Component $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defstruct Component (:name 'Dynamic) (:tree 'Dynamic)
          :examples $ []
          :schema $ :: 'StructDef
        |Shape $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defstruct Shape (:name 'Dynamic) (:params 'Dynamic) (:position 'Dynamic) (:scale 'Dynamic) (:rotation 'Dynamic) (:material 'Dynamic) (:event 'Dynamic) (:attributes 'Dynamic) (:children 'Dynamic)
          :examples $ []
          :schema $ :: 'StructDef
        |comp? $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn comp? (x)
              and (struct? x) (&struct:matches? x Component)
          :examples $ []
          :schema $ :: 'Dynamic
        |shape? $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn shape? (x)
              and (struct? x) (&struct:matches? x Shape)
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote (ns quatrefoil.schema)
    |quatrefoil.util.core $ %{} 'FileEntry
      :defs $ {}
        |=component? $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn =component? (prev-tree markup)
              let
                  prev-args $ field prev-tree :args
                  prev-states $ field prev-tree :states
                ; println
                  =seq? (field markup :args) prev-args
                  identical? (field markup :states) prev-states
                and
                  =seq? (:args markup) prev-args
                  identical? (:states markup) prev-states
          :examples $ []
          :schema $ :: 'Dynamic
        |=seq? $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn =seq? (xs ys)
              let
                  xs-empty? $ empty? xs
                  ys-empty? $ empty? ys
                if xs-empty? ys-empty? $ if ys-empty? false
                  if
                    identical? (first xs) (first ys)
                    recur (rest xs) (rest ys)
                    , false
          :examples $ []
          :schema $ :: 'Dynamic
        |collect-children $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn collect-children (element collect!)
              .!forEach
                ffi-object $ .-children (ffi-object element)
                fn (child idx _) (; js/console.log |Child: child) (collect! child)
                  if
                    js-present? $ .-children (ffi-object child)
                    collect-children child collect!
          :examples $ []
          :schema $ :: 'Dynamic
        |ffi-object $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn ffi-object (value) (unsafe-coerce value JsObject)
          :examples $ []
          :schema $ :: 'Dynamic
        |field $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn field (value key)
              option:unwrap-or (get value key) nil
          :examples $ []
          :schema $ :: 'Dynamic
        |find-element $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn find-element (tree coord) (; js/console.log |Find... tree coord)
              if (comp? tree)
                recur (field tree :tree) coord
                if (empty? coord) tree $ let
                    cursor $ first coord
                  if
                    contains? (field tree :children) cursor
                    recur
                      get-in tree $ [] :children cursor
                      rest coord
                    , nil
          :examples $ []
          :schema $ :: 'Dynamic
        |purify-tree $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn purify-tree (tree)
              cond
                  nil? tree
                  , nil
                (comp? tree)
                  recur $ field tree :tree
                true $ update tree :children
                  fn (children)
                    -> children (.to-list)
                      map $ fn (entry)
                        update entry 1 $ fn (child) (purify-tree child)
                      pairs-map
          :examples $ []
          :schema $ :: 'Dynamic
        |reach-object3d $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn reach-object3d (object3d coord)
              if (empty? coord) object3d $ let
                  cursor $ first coord
                recur (.!reachBy object3d cursor) (rest coord)
          :examples $ []
          :schema $ :: 'Dynamic
        |scale-zero $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn scale-zero (x)
              if (&= 0 x) 0.01 x
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote
          ns quatrefoil.util.core $ :require
            quatrefoil.schema :refer $ Component Shape comp? shape?
