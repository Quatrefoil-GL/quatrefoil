
{} (:package |quatrefoil)
  :configs $ {} (:init-fn |quatrefoil.app.main/main!) (:reload-fn |quatrefoil.app.main/reload!) (:version |0.1.0-a6)
    :modules $ [] |touch-control/ |pointed-prompt/ |quaternion/
  :entries $ {}
  :files $ {}
    |quatrefoil.alias $ %{} :FileEntry
      :defs $ {}
        |ambient-light $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn ambient-light (props & children) (create-element :ambient-light props children)
        |arrange-children $ %{} :CodeEntry (:doc |)
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
        |box $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn box (props & children) (create-element :box props children)
        |buffer-object $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn buffer-object (props & children) (create-element :buffer-object props children)
        |create-element $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn create-element (el-name props children)
              %{} Shape (:name el-name)
                :params $ -> props (dissoc :material) (dissoc :event) (dissoc :position) (dissoc :scale) (dissoc :rotation) (dissoc :attributes) (dissoc :on) (dissoc :event)
                :position $ :position props
                :scale $ :scale props
                :material $ :material props
                :rotation $ :rotation props
                :attributes $ :attributes props
                :event $ or (:on props) (:event props)
                :children $ arrange-children children
        |directional-light $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn directional-light (props & children) (create-element :directional-light props children)
        |flat-values $ %{} :CodeEntry (:doc |)
          :code $ quote
            defmacro flat-values (& points)
              &let
                chunk $ &list:concat & points
                quasiquote $ [] ~@chunk
        |group $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn group (props & children) (create-element :group props children)
        |line $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn line (props & children) (create-element :line props children)
        |line-segments $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn line-segments (props & children) (create-element :line-segments props children)
        |mesh-line $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn mesh-line (props & children) (create-element :mesh-line props children)
        |parametric $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn parametric (props & children) (create-element :parametric props children)
        |plane-reflector $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn plane-reflector (props & children) (create-element :plane-reflector props children)
        |point-light $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn point-light (props & children) (create-element :point-light props children)
        |polyhedron $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn polyhedron (props & children) (create-element :polyhedron props children)
        |rect-area-light $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn rect-area-light (props & children) (create-element :rect-area-light props children)
        |scene $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn scene (props & children) (create-element :scene props children)
        |shader-mesh $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn shader-mesh (props & children) (create-element :shader-mesh props children)
        |shape $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn shape (props & children) (create-element :shape props children)
        |some-object $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn some-object (props)
              create-element :some-object props $ []
        |sphere $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn sphere (props & children) (create-element :sphere props children)
        |spline $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn spline (props & children) (create-element :spline props children)
        |spot-light $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn spot-light (props & children) (create-element :spot-light props children)
        |text $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn text (props & children) (create-element :text props children)
        |torus $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn torus (props & children) (create-element :torus props children)
        |tube $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn tube (props & children) (create-element :tube props children)
      :ns $ %{} :CodeEntry (:doc |)
        :code $ quote
          ns quatrefoil.alias $ :require
            quatrefoil.schema :refer $ Shape Component comp? shape?
    |quatrefoil.app.comp.container $ %{} :FileEntry
      :defs $ {}
        |comp-back $ %{} :CodeEntry (:doc |)
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
        |comp-container $ %{} :CodeEntry (:doc |)
          :code $ quote
            defcomp comp-container (store)
              let
                  states $ :states store
                  cursor $ :cursor states
                  state $ either (:data states)
                    {} $ :tab :portal
                  tab $ :tab state
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
                      :todolist $ comp-todolist (:tasks store)
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
                    if (not= tab :portal)
                      comp-back $ fn (d!)
                        d! cursor $ assoc state :tab :portal
                    ambient-light $ {} (:color 0x666666) (:intensity 1)
                    ; point-light $ {} (:color 0xffffff) (:intensity 1.4) (:distance 200)
                      :position $ [] 20 40 50
                    ; point-light $ {} (:color 0xffffff) (:intensity 2) (:distance 200)
                      :position $ [] 0 60 0
        |comp-demo $ %{} :CodeEntry (:doc |)
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
                  :gamepad $ fn (info elapsed d!) (js/console.log "\"first pad event" info)
              sphere $ {} (:radius 8)
                :position $ [] 30 0 0
                :material $ {} (:kind :mesh-lambert) (:opacity 0.6)
                  :color $ hclx 160 80 70
                :event $ {}
                  :click $ fn (e d!) (d! :canvas nil)
                  :gamepad $ fn (info elapsed d!) (js/console.log "\"second pad event" info)
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
        |comp-gltf $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn comp-gltf () $ group ({})
              some-object $ {} (:key :sakura)
                :object-loaded? $ some? (get @*loaded-objects :sakura)
                :position $ [] 0 -100 -100
                :scale $ [] 200 200 200
              point-light $ {} (:color 0x555555) (:intensity 2.4) (:distance 800)
                :position $ [] 10 100 100
              ambient-light $ {} (:color 0xaaaaaa) (:intensity 1)
      :ns $ %{} :CodeEntry (:doc |)
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
    |quatrefoil.app.comp.control $ %{} :FileEntry
      :defs $ {}
        |comp-control-demo $ %{} :CodeEntry (:doc |)
          :code $ quote
            defcomp comp-control-demo (states)
              let
                  cursor $ :cursor states
                  state $ or (:data states)
                    {}
                      :p0 $ [] 0 0 0
                      :v0 0
                      :v1 $ [] 1 1
                      :on? false
                group ({})
                  comp-pin-point
                    {} (:speed 8) (:label "\"C") (:color 0xddaaff) (:radius 1) (:opacity 1)
                      :position $ :p0 state
                    fn (next d!)
                      d! cursor $ assoc state :p0 next
                  comp-value
                    {} (:speed 0.2) (:show-text? true) (:label "\"A")
                      :value $ :v0 state
                      :position $ [] 10 0 0
                      :bound $ [] -2 20
                      :color $ hslx 10 90 80
                    fn (v1 d!)
                      d! cursor $ assoc state :v0 v1
                  comp-value-2d
                    {} (:label "\"B")
                      :value $ :v1 state
                      :position $ [] 0 10 0
                      :speed 0.2
                      :color 0xccaaff
                      :show-text? true
                      :fract-length 3
                    fn (v d!)
                      d! cursor $ assoc state :v1 v
                  comp-switch
                    {} (:label "\"Status") (:color 0xaa88ff)
                      :value $ :on? state
                      :position $ [] 20 0 0
                    fn (v d!)
                      d! cursor $ assoc state :on? v
                  point-light $ {} (:color 0xffffff) (:intensity 1) (:distance 200)
                    :position $ [] 20 40 50
      :ns $ %{} :CodeEntry (:doc |)
        :code $ quote
          ns quatrefoil.app.comp.control $ :require
            quatrefoil.alias :refer $ group box sphere text line tube point-light
            quatrefoil.core :refer $ defcomp hslx
            quaternion.core :refer $ q* &q* v-scale q+
            quatrefoil.comp.control :refer $ comp-pin-point comp-value comp-value-2d comp-switch
    |quatrefoil.app.comp.lines $ %{} :FileEntry
      :defs $ {}
        |cloud-fn $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn cloud-fn (ratio factor)
              let
                  f0 $ nth factor 0
                  f1 $ nth factor 1
                  f2 $ nth factor 2
                  deg $ * ratio 20 &PI
                  r $ * 160 (js/Math.sin deg)
                  deg2 $ / (* 5 f0 deg) 13
                  deg3 $ * 0.02 f1 deg
                []
                  * r $ js/Math.cos deg2
                  * 0.6 f2 r $ js/Math.sin deg3
                  * r $ js/Math.sin deg2
        |comp-fly-city $ %{} :CodeEntry (:doc |)
          :code $ quote
            defcomp comp-fly-city (states)
              let
                  cursor $ :cursor states
                  state $ or (:data states)
                    {}
                      :buildings $ make-building-data 80
                      :factor $ [] 1 1 1
                group ({}) & horizontal-lines & forward-lines &
                  -> (:buildings state)
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
                    :factor $ :factor state
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
        |comp-lines $ %{} :CodeEntry (:doc |)
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
        |forward-lines $ %{} :CodeEntry (:doc |)
          :code $ quote
            def forward-lines $ -> (range 20)
              map $ fn (idx)
                let
                    pos $ * 10 (- idx 10)
                  line $ {}
                    :points $ [] ([] pos 0 -200) ([] pos 0 200)
                    :position $ [] 0 0 0
                    :material $ {} (:kind :line-dashed) (:color 0xccccff) (:opacity 0.3) (:transparent true) (:linewidth 2) (:gapSize 0.5) (:dashSize 0.5)
        |horizontal-lines $ %{} :CodeEntry (:doc |)
          :code $ quote
            def horizontal-lines $ -> (range 20)
              map $ fn (idx)
                let
                    pos $ * 10 (- idx 10)
                  line $ {}
                    :points $ [] ([] -200 0 pos) ([] 200 0 pos)
                    :position $ [] 0 0 0
                    :material $ {} (:kind :line-dashed) (:color 0xccccff) (:opacity 0.3) (:transparent true) (:linewidth 2) (:gapSize 0.5) (:dashSize 0.5)
        |make-building-data $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn make-building-data (n)
              -> (range n)
                map $ fn (i)
                  [] (rand-shift 0 160) (rand-shift 0 160) (rand-shift 12 8) (rand-shift 8 6) (rand-shift 60 50)
        |tube-fn $ %{} :CodeEntry (:doc |)
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
      :ns $ %{} :CodeEntry (:doc |)
        :code $ quote
          ns quatrefoil.app.comp.lines $ :require
            quatrefoil.alias :refer $ group box sphere text line line-segments mesh-line spline tube point-light ambient-light
            quatrefoil.core :refer $ defcomp
            "\"@calcit/std" :refer $ rand-shift
            "\"three" :as THREE
    |quatrefoil.app.comp.mirror $ %{} :FileEntry
      :defs $ {}
        |comp-mirror $ %{} :CodeEntry (:doc |)
          :code $ quote
            defcomp comp-mirror (states)
              let
                  cursor $ :cursor states
                  state $ either (:data states)
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
        |heart-path $ %{} :CodeEntry (:doc |)
          :code $ quote
            def heart-path $ [] (:: :move-to 25 25) (:: :bezier-curve-to 25 25 20 50 0 50) (:: :bezier-curve-to -30 50 -30 15 -30 15) (:: :bezier-curve-to -30 -5 -10 -27 25 -45) (:: :bezier-curve-to 60 -22 80 -5 80 15) (:: :bezier-curve-to 80 15 80 50 50 50) (:: :bezier-curve-to 35 50 25 25 25 25)
      :ns $ %{} :CodeEntry (:doc |)
        :code $ quote
          ns quatrefoil.app.comp.mirror $ :require
            quatrefoil.alias :refer $ group box sphere shape text line spline tube plane-reflector point-light ambient-light
            quatrefoil.core :refer $ defcomp
            quatrefoil.math :refer $ rand-around
            quaternion.core :refer $ v-scale
            "\"@calcit/std" :refer $ rand
    |quatrefoil.app.comp.portal $ %{} :FileEntry
      :defs $ {}
        |comp-portal $ %{} :CodeEntry (:doc |)
          :code $ quote
            defcomp comp-portal (on-change)
              group ({})
                comp-tab :todolist |Todolist ([] -40 30 0) on-change
                comp-tab :demo |Demo ([] 0 30 0) on-change
                comp-tab :lines |Lines ([] 0 20 0) on-change
                comp-tab :shapes |Shapes ([] -40 20 0) on-change
                comp-tab :control "\"Control Demo" ([] -40 10 0) on-change
                comp-tab :triflorum |Triflorum ([] 0 10 0) on-change
                comp-tab :mirror "\"Mirror.. <3" ([] -40 -0 0) on-change
                comp-tab :fly "\"Fly" ([] 0 0 0) on-change
                comp-tab :quat-tree "\"Quat... Tree" ([] -40 -10 0) on-change
                comp-tab :quilling "\"Quilling" ([] -0 -10 0) on-change
                comp-tab :shader "\"Shader" ([] -40 -20 0) on-change
                comp-tab :gltf "\"GLTF" ([] 0 -20 0) on-change
                point-light $ {} (:color 0xffffff) (:intensity 1.4) (:distance 200)
                  :position $ [] 20 40 50
        |comp-tab $ %{} :CodeEntry (:doc |)
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
      :ns $ %{} :CodeEntry (:doc |)
        :code $ quote
          ns quatrefoil.app.comp.portal $ :require
            quatrefoil.alias :refer $ group box sphere text ambient-light point-light
            quatrefoil.core :refer $ defcomp hslx hsluvx
    |quatrefoil.app.comp.quat-tree $ %{} :FileEntry
      :defs $ {}
        |comp-quat-tree $ %{} :CodeEntry (:doc |)
          :code $ quote
            defcomp comp-quat-tree () $ let
                p0 $ [] 0 0 0 0
                l0 $ [] 0 40 20 30
                lines $ generate-lines p0 l0 6 :root
              group ({})
                ambient-light $ {} (:color 0x444422)
                point-light $ {} (:color 0xffffff) (:intensity 1.4) (:distance 200)
                  :position $ [] 20 40 50
                group ({}) & $ -> lines
                  mapcat $ fn (line)
                    let
                        from $ :from line
                        to $ :to line
                        v $ &q- to from
                        size $ q-length v
                        w $ nth to 3
                        hang $ {} (:from to)
                          :to $ [] (nth to 0)
                            + (nth to 1)
                              nth (:line line) 3
                            nth to 2
                      []
                        tube $ {} (:points-fn straight-fn) (:factor line)
                          :radius $ * 0.04 size
                          :tubular-segments 4
                          :radial-segments 4
                          :position $ [] -10 0 0
                          :material $ assoc tube-material :color
                            pick-color $ :name line
                        tube $ {} (:points-fn straight-fn) (:factor hang) (:radius 0.1) (:tubular-segments 4) (:radial-segments 4)
                          :position $ [] -10 0 0
                          :material leaf-material
        |generate-lines $ %{} :CodeEntry (:doc |)
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
                            trans $ :vector info
                            name $ :name info
                          generate-lines line-to (&q* l0 trans) (dec level) name
                    []
        |leaf-material $ %{} :CodeEntry (:doc |)
          :code $ quote
            def leaf-material $ {} (:kind :mesh-standard) (:color 0x66cc55) (:opacity 0.5) (:transparent true)
        |pick-color $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn pick-color (name)
              case-default name 0xffffff (:a 0xbbaaff) (:b 0x88bbff) (:c 0x77ccaa)
        |straight-fn $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn straight-fn (t factor)
              let-sugar
                    [] x1 y1 z1
                    &map:get factor :from
                  ([] x2 y2 z2) (&map:get factor :to)
                []
                  &+ (&* x1 t)
                    &* x2 $ &- 1 t
                  &+ (&* y1 t)
                    &* y2 $ &- 1 t
                  &+ (&* z1 t)
                    &* z2 $ &- 1 t
        |transformers $ %{} :CodeEntry (:doc |)
          :code $ quote
            def transformers $ []
              {} (:name :a)
                :vector $ [] 0.3 0.1 0.1 0.7
              {} (:name :b)
                :vector $ [] 0.2 -0.3 -0.33 0.7
              {} (:name :c)
                :vector $ [] -0.44 0.12 0.33 0.6
        |tube-material $ %{} :CodeEntry (:doc |)
          :code $ quote
            def tube-material $ {} (:kind :mesh-standard) (:color 0xcccc77) (:opacity 1) (:transparent true)
      :ns $ %{} :CodeEntry (:doc |)
        :code $ quote
          ns quatrefoil.app.comp.quat-tree $ :require
            quatrefoil.alias :refer $ group box sphere text line tube ambient-light point-light
            quatrefoil.core :refer $ defcomp
            quaternion.core :refer $ q* &q* v-scale q+ &q+ &q- q-length
            quatrefoil.app.materials :refer $ cover-line
    |quatrefoil.app.comp.shader $ %{} :FileEntry
      :defs $ {}
        |comp-shader $ %{} :CodeEntry (:doc |)
          :code $ quote
            defcomp comp-shader () $ group ({})
              shader-mesh $ {}
                :attributes $ []
                  {} (:id :position) (:size 3) (:type :f32)
                    :buffer $ concat &
                      [] ([] -10 -20 0) ([] 50 0 0) ([] 13 30 0)
                  {} (:id :color) (:size 4) (:type :u8)
                    :buffer $ concat &
                      [] ([] 1 0 0 1) ([] 0 1 0 1) ([] 0 0 1 1 )
                :material $ {} (:kind :raw-shader)
                  :uniforms $ {}
                  :vertexShader $ inline-shader "\"demo.vert"
                  :fragmentShader $ inline-shader "\"demo.frag"
                  :wireframe false
                  :transparent false
              point-light $ {} (:color 0xffffff) (:intensity 1.4) (:distance 200)
                :position $ [] 20 40 50
        |inline-shader $ %{} :CodeEntry (:doc |)
          :code $ quote
            defmacro inline-shader (name)
              read-file $ str "\"shaders/" name
      :ns $ %{} :CodeEntry (:doc |)
        :code $ quote
          ns quatrefoil.app.comp.shader $ :require
            quatrefoil.alias :refer $ group box sphere text line tube ambient-light point-light shader-mesh
            quatrefoil.core :refer $ defcomp
            quaternion.core :refer $ q* &q* v-scale q+ &q+ &q- q-length
            quatrefoil.app.materials :refer $ cover-line
    |quatrefoil.app.comp.shapes $ %{} :FileEntry
      :defs $ {}
        |box-material $ %{} :CodeEntry (:doc |)
          :code $ quote
            def box-material $ {} (:kind :mesh-lambert) (:color 0x808080) (:opacity 0.6)
        |bubble-material $ %{} :CodeEntry (:doc |)
          :code $ quote
            def bubble-material $ {} (:kind :mesh-basic) (:color 0xffffff) (:opacity 1) (:transparent true)
        |comp-bubble $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn comp-bubble (position)
              group ({})
                sphere $ {} (:radius 1) (:emissive 0xffffff) (:metalness 0.8) (:color 0xffffff) (:emissiveIntensity 1) (:roughness 0) (:position position) (:material bubble-material)
                point-light $ {} (:color 0xffffff) (:intensity 2) (:distance 400) (:position position)
        |comp-quilling $ %{} :CodeEntry (:doc |)
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
        |comp-shapes $ %{} :CodeEntry (:doc |)
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
        |paper-fn $ %{} :CodeEntry (:doc |)
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
        |paper-material $ %{} :CodeEntry (:doc |)
          :code $ quote
            def paper-material $ {} (:kind :mesh-standard) (:roughness 0.99) (; :emissive 0x6611ee) (:metalness 0.02) (:transparent false) (:color 0x6666ff)
        |wave-fn $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn wave-fn (u v data)
              [] (* 8 u)
                +
                  * 1 $ sin
                    + (* 5 &PI v) (* 8 &PI u)
                  * 1 $ cos
                    + (* 10 &PI v) (* 3 &PI u)
                * 8 v
      :ns $ %{} :CodeEntry (:doc |)
        :code $ quote
          ns quatrefoil.app.comp.shapes $ :require
            quatrefoil.alias :refer $ group box sphere point-light scene text torus shape rect-area-light polyhedron plane-reflector parametric buffer-object flat-values ambient-light directional-light spot-light
            quatrefoil.core :refer $ defcomp
            "\"three" :as THREE
    |quatrefoil.app.comp.todolist $ %{} :FileEntry
      :defs $ {}
        |comp-task $ %{} :CodeEntry (:doc |)
          :code $ quote
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
                        [] (:id task)
                          prompt-at!
                            [] (.-pageX event) (.-pageY event)
                            {} $ :initial (:text task)
                            fn (text)
                              dispatch! :edit-task $ [] (:id task) text
                  text $ {}
                    :text $ :text task
                    :size 3
                    :depth 1
                    :position $ [] -10 0 0
                    :material $ {} (:kind :mesh-lambert) (:color 0xffcccc) (:opacity 0.8) (:transparent true)
                sphere $ {} (:radius 2)
                  :position $ [] 30 0 0
                  :material $ {} (:kind :mesh-lambert) (:opacity 0.8) (:color 0xff5050) (:transparent true)
                  :event $ {}
                    :click $ fn (event dispatch!)
                      dispatch! :delete-task $ :id task
        |comp-todolist $ %{} :CodeEntry (:doc |)
          :code $ quote
            defcomp comp-todolist (tasks)
              group ({})
                group
                  {} $ :position ([] 0 30 0)
                  box $ {} (:width 40) (:height 6) (:depth 1)
                    :material $ {} (:kind :mesh-lambert) (:color 0xffaaaa) (:opacity 0.9) (:transparent true)
                    :event $ {}
                      :click $ fn (e d!) (js/console.log "\"e" e)
                        prompt-at!
                          [] (.-pageX e) (.-pageY e)
                          {} $ :initial "\""
                          fn (text) (d! :add-task text)
                group
                  {} $ :position ([] 0 20 0)
                  -> (vals tasks)
                    map-indexed $ fn (idx task)
                      [] (:id task) (comp-task task idx)
                    pairs-map
                point-light $ {} (:color 0xffffff) (:intensity 1.4) (:distance 200)
                  :position $ [] 0 20 50
      :ns $ %{} :CodeEntry (:doc |)
        :code $ quote
          ns quatrefoil.app.comp.todolist $ :require
            quatrefoil.alias :refer $ group box sphere point-light scene text
            quatrefoil.core :refer $ defcomp
            pointed-prompt.core :refer $ prompt-at!
    |quatrefoil.app.comp.triflorum $ %{} :FileEntry
      :defs $ {}
        |comp-triflorum $ %{} :CodeEntry (:doc |)
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
        |main-branch-fn $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn main-branch-fn (ratio factor)
              [] 0 (* -20 ratio) 0
        |petal-fn $ %{} :CodeEntry (:doc |)
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
        |yarn-fn $ %{} :CodeEntry (:doc |)
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
      :ns $ %{} :CodeEntry (:doc |)
        :code $ quote
          ns quatrefoil.app.comp.triflorum $ :require
            quatrefoil.alias :refer $ group box sphere text line tube polyhedron point-light
            quatrefoil.core :refer $ defcomp
            quaternion.core :refer $ v+ v-scale
    |quatrefoil.app.main $ %{} :FileEntry
      :defs $ {}
        |*store $ %{} :CodeEntry (:doc |)
          :code $ quote
            defatom *store $ {}
              :tasks $ {}
                100 $ {} (:id 100) (:text "|Initial task") (:done? false)
              :states $ {}
                :cursor $ []
        |dispatch! $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn dispatch! (op op-data)
              if (list? op)
                recur :states $ [] op op-data
                let
                    store $ updater @*store op op-data
                  ; js/console.log |Dispatch: op op-data store
                  reset! *store store
        |main! $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn main! () (load-console-formatter!) (inject-tree-methods) (start-loading-sakura!)
              set-perspective-camera! $ {} (:fov 40) (:near 0.1) (:far 100)
                :position $ [] 0 0 8
                :aspect $ / js/window.innerWidth js/window.innerHeight
              let
                  canvas-el $ js/document.querySelector |canvas
                init-renderer! canvas-el $ {} (:background 0x110022) (:shadow-map? true)
                  ; :composer-passes $ []
                    new UnrealBloomPass (new THREE/Vector2 js/window.innerWidth js/window.innerHeight) 1.5 0.4 0.85
              render-app!
              add-watch *store :changes $ fn (store prev) (render-app!)
              set! js/window.onkeydown handle-key-event
              render-control!
              handle-control-events
              init-controls!
              println "|App started!"
        |reload! $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn reload! () $ if (some? build-errors) (hud! "\"error" build-errors)
              do (hud! "\"ok~" nil) (clear-cache!) (clear-control-loop!) (handle-control-events) (remove-watch *store :changes)
                add-watch *store :changes $ fn (store prev) (render-app!)
                render-app!
                set! js/window.onkeydown handle-key-event
                println "|Code updated."
        |render-app! $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn render-app! () (; println "|Render app:")
              render-canvas! (comp-container @*store) dispatch!
        |start-loading-sakura! $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn start-loading-sakura! () $ let
                loader $ new GLTFLoader
                dracoLoader $ new DRACOLoader
              .!setDecoderPath dracoLoader "\"https://cdn.tiye.me/gltf/"
              .!setDRACOLoader loader dracoLoader
              .!load loader "\"https://cdn.tiye.me/gltf/fantasy_sakura/scene.gltf"
                fn (gltf)
                  set!
                    .-cachedHash $ .-scene gltf
                    , "\"sakura"
                  swap! *loaded-objects assoc :sakura $ .-scene gltf
                  js/console.info "\"gltf loaded"
                  render-app!
                fn $ xhr
                fn (err) (js/console.log err)
      :ns $ %{} :CodeEntry (:doc |)
        :code $ quote
          ns quatrefoil.app.main $ :require
            "\"@quatrefoil/utils" :refer $ inject-tree-methods
            quatrefoil.core :refer $ render-canvas! *global-tree clear-cache! init-renderer! init-controls! handle-key-event handle-control-events
            quatrefoil.globals :refer $ *loaded-objects
            quatrefoil.app.comp.container :refer $ comp-container
            quatrefoil.dsl.object3d-dom :refer $ on-canvas-click
            quatrefoil.app.updater :refer $ [] updater
            "\"three" :as THREE
            touch-control.core :refer $ render-control! control-states start-control-loop! clear-control-loop!
            "\"bottom-tip" :default hud!
            "\"./calcit.build-errors" :default build-errors
            quatrefoil.dsl.object3d-dom :refer $ set-perspective-camera!
            "\"three/examples/jsm/postprocessing/UnrealBloomPass" :refer $ UnrealBloomPass
            "\"three/examples/jsm/loaders/GLTFLoader" :refer $ GLTFLoader
            "\"three/examples/jsm/loaders/DRACOLoader" :refer $ DRACOLoader
    |quatrefoil.app.materials $ %{} :FileEntry
      :defs $ {}
        |cover-line $ %{} :CodeEntry (:doc |)
          :code $ quote
            def cover-line $ {} (:kind :line-basic) (:color 0xaaaaff) (:opacity 0.9) (:transparent true)
      :ns $ %{} :CodeEntry (:doc |)
        :code $ quote (ns quatrefoil.app.materials)
    |quatrefoil.app.updater $ %{} :FileEntry
      :defs $ {}
        |updater $ %{} :CodeEntry (:doc |)
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
                      last op-data
      :ns $ %{} :CodeEntry (:doc |)
        :code $ quote
          ns quatrefoil.app.updater $ :require
            quatrefoil.cursor :refer $ update-states
    |quatrefoil.comp.control $ %{} :FileEntry
      :defs $ {}
        |comp-2d-control $ %{} :CodeEntry (:doc |)
          :code $ quote
            defcomp comp-2d-control (state cursor field position speed color)
              sphere $ {} (:radius 1) (:emissive 0xffffff) (:metalness 0.8) (:color 0x00ff00) (:emissiveIntensity 1) (:roughness 0) (:position position)
                :material $ {} (:kind :mesh-basic) (:color color) (:opacity 0.3) (:transparent true)
                :event $ {}
                  :control $ fn (states delta elapse d!) (; println "\"delta" delta)
                    let-sugar
                          [] x0 y0
                          get state field
                        dx $ * speed elapse (nth delta 0)
                        dy $ * speed elapse (nth delta 1)
                      d! cursor $ assoc state field
                        [] (+ x0 dx) (+ y0 dy)
        |comp-pin-point $ %{} :CodeEntry (:doc |)
          :code $ quote
            defcomp comp-pin-point (options on-change)
              let
                  position $ or (:position options) ([] 0 0 0)
                  speed $ or (:speed options) 1
                  text-color $ either (:text-color options) 0xaaaaff
                group
                  {} $ :position position
                  sphere $ {} (:emissive 0xffffff) (:metalness 0.8) (:emissiveIntensity 1) (:roughness 0)
                    :position $ [] 0 0 0
                    :radius $ or (:radius options) 1
                    :material $ {} (:kind :mesh-lambert) (:transparent true)
                      :color $ either (:color options) 0xaaaaff
                      :opacity $ either (:opacity options) 0.7
                    :event $ {}
                      :control $ fn (states delta elapse d!) (; println "\"delta" delta)
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
                              if (:b info) 8 1
                            forward $ * speeding elapsed (:v2 info)
                              if (:a info) -1 1
                            next-pos $ v+ position
                              v-scale
                                &tuple:params $ :rightward info
                                * speeding elapsed $ :dx info
                              v-scale
                                &tuple:params $ :upward info
                                * -1 speeding elapsed $ :dy info
                              v-scale
                                &tuple:params $ :forward info
                                , forward
                          on-change next-pos d!
                  if-let
                    label $ :label options
                    text $ {}
                      :position $ [] -0.6 2 0
                      :text $ str label
                      :material $ {} (:kind :mesh-lambert) (:color text-color) (:opacity 0.9) (:transparent true)
                      :size 2
                      :depth 0.5
        |comp-switch $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn comp-switch (options on-toggle)
              let
                  value $ :value options
                  color $ either (:color options) 0xffffff
                  text-color $ either (:text-color options) color
                  label $ :label options
                group
                  {} $ :position (:position options)
                  sphere $ {} (:emissive 0xffffff) (:metalness 0.8) (:emissiveIntensity 1) (:roughness 0)
                    :radius $ &*
                      or (:radius options) 1
                      if value 1 0.8
                    :material $ {} (:kind :mesh-lambert) (:color color) (:transparent true)
                      :opacity $ if value
                        either (:opacity options) 0.8
                        , 0.3
                    :event $ {}
                      :click $ fn (e d!)
                        on-toggle (not value) d!
                  text $ {}
                    :position $ [] 1.6 -0.8 0
                    :text $ or label "\"On"
                    :material $ {} (:kind :mesh-lambert) (:color text-color) (:opacity 0.9) (:transparent true)
                    :size 2
                    :depth 0.5
        |comp-value $ %{} :CodeEntry (:doc |)
          :code $ quote
            defcomp comp-value (options on-change)
              let
                  value $ :value options
                  speed $ or (:speed options) 1
                  color $ either (:color options) 0xffffff
                  text-color $ either (:text-color options) color
                  text-size $ either (:text-size options) 1
                  bound $ or (:bound options) ([] 0 1)
                  label $ :label options
                group
                  {} $ :position (:position options)
                  sphere $ {} (:emissive 0xffffff) (:metalness 0.8) (:emissiveIntensity 1) (:roughness 0)
                    :radius $ or (:radius options) 1
                    :material $ {} (:kind :mesh-lambert) (:color color) (:transparent true)
                      :opacity $ either (:opacity options) 0.6
                    :event $ {}
                      :control $ fn (move delta elapse d!) (; println "\"delta" delta)
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
                              if (:b info) 8 1
                          on-change
                            + value $ * elapsed speeding (:dx info)
                            , d!
                  if (:show-text? options)
                    text $ {}
                      :position $ [] -1.6 2 0
                      :text $ let
                          prefix $ if (blank? label) "\"" (str label "\" ")
                        str prefix $ .!toFixed value
                          either (:fract-length options) 2
                      :material $ {} (:kind :mesh-lambert) (:color text-color) (:opacity 0.9) (:transparent true)
                      :size text-size
                      :depth 0.5
        |comp-value-2d $ %{} :CodeEntry (:doc |)
          :code $ quote
            defcomp comp-value-2d (options on-change)
              let
                  v $ :value options
                  position $ :position options
                  speed $ either (:speed options) 1
                  color $ either (:color options) 0xaaaaff
                  text-color $ either (:text-color options) color
                  text-size $ either (:text-size options) 1
                  fract-len $ either (:fract-length options) 2
                  label $ :label options
                group
                  {} $ :position (:position options)
                  sphere $ {} (:radius 1) (:emissive 0xffffff) (:metalness 0.8) (:emissiveIntensity 1) (:roughness 0)
                    :material $ {} (:kind :mesh-lambert) (:color color) (:opacity 0.7) (:transparent true)
                    :event $ {}
                      :control $ fn (states delta elapse d!) (; println "\"delta" delta)
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
                              if (:b info) 8 1
                            dx $ * elapsed speeding (:dx info)
                            dy $ * elapsed speeding (:dy info)
                          on-change
                            [] (+ x0 dx) (- y0 dy)
                            , d!
                  if (:show-text? options)
                    text $ {}
                      :position $ [] -2 2 0
                      :text $ let
                          prefix $ if (blank? label) "\"" (str label "\" ")
                        str prefix
                          .!toFixed (nth v 0) fract-len
                          , "\", " $ .!toFixed (nth v 1) fract-len
                      :material $ {} (:kind :mesh-lambert) (:color text-color) (:opacity 0.9) (:transparent true)
                      :size text-size
                      :depth 1
      :ns $ %{} :CodeEntry (:doc |)
        :code $ quote
          ns quatrefoil.comp.control $ :require
            quatrefoil.alias :refer $ group box sphere text line tube point-light
            quatrefoil.core :refer $ defcomp
            quaternion.core :refer $ q* &q* v-scale q+ &v+ v+
            quatrefoil.app.materials :refer $ cover-line
            quatrefoil.core :refer $ to-viewer-axis
    |quatrefoil.core $ %{} :FileEntry
      :defs $ {}
        |*tmp-changes $ %{} :CodeEntry (:doc |)
          :code $ quote (defatom *tmp-changes nil)
        |>> $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn >> (states k)
              let
                  parent-cursor $ either (:cursor states) ([])
                  branch $ either (get states k) ({})
                assoc branch :cursor $ append parent-cursor k
        |camera-direction-for $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn camera-direction-for (x y z)
              let
                  v $ new THREE/Vector3 x y z
                .!applyQuaternion v $ .-quaternion @*global-camera
                :: :v3 (.-x v) (.-y v) (.-z v)
        |clear-cache! $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn clear-cache! () $ ; "\"TODO memof..."
        |data0 $ %{} :CodeEntry (:doc |)
          :code $ quote
            def data0 $ {} (:v1 0) (:v2 0) (:a 0) (:b 0) (:dx 0) (:dy 0)
        |defcomp $ %{} :CodeEntry (:doc |)
          :code $ quote
            defmacro defcomp (comp-name params & body)
              ; assert "\"expected symbol of comp-name" $ symbol? comp-name
              ; assert "\"expected params in list" $ and (list? params) (every? params symbol?)
              if (&list:empty? body)
                quasiquote $ echo "\"[Warn] invalid component body for" (quote ~comp-name) (quote ~params)
                quasiquote $ defn ~comp-name (~ params)
                  %{} Component
                    :name $ quote ~comp-name
                    :tree $ &let () ~@body
        |half-pi $ %{} :CodeEntry (:doc |)
          :code $ quote
            def half-pi $ * 0.5 &PI
        |handle-control-events $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn handle-control-events () $ start-control-loop! 10
              fn (elapsed states delta)
                let
                    l-move $ map (:left-move states) refine-strength
                    r-move $ map (:right-move states) refine-strength
                    r-delta $ :right-move delta
                    l-delta $ :left-move delta
                    camera @*global-camera
                    left-a? $ :left-a? states
                    right-b? $ :right-b? states
                    left-b? $ :left-b? states
                  ; println "\"L" l-move "\"R" r-move
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
                        (< (js/Math.abs shift) 0.06)
                          shift-viewer-by! false
                        true nil
                  when
                    and left-b? $ or
                      not= r-move $ [] 0 0
                      not= r-delta $ [] 0 0
                    on-control-event r-move r-delta elapsed
        |handle-key-event $ %{} :CodeEntry (:doc |)
          :code $ quote
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
                  "\"a" $ tween-move-camera! ([] :angle 0.04)
                  "\"d" $ tween-move-camera! ([] :angle -0.04)
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
                  "\"ArrowLeft" $ &let
                    a $ &+ @*viewer-angle (&/ &PI 2)
                    tween-move-camera! $ [] :move
                      &* 1 $ cos a
                      , 0
                        &* -1 $ sin a
                  "\"ArrowRight" $ &let
                    a $ &- @*viewer-angle (&/ &PI 2)
                    tween-move-camera! $ [] :move
                      &* 1 $ cos a
                      , 0
                        &* -1 $ sin a
        |hclx $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn hclx (h c l) (hcl-to-hex h c l)
        |hsluvx $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn hsluvx (h c l)
              let
                  color $ new THREE/Color
                  conv $ new Hsluv
                set! (.-hsluv_h conv) h
                set! (.-hsluv_s conv) c
                set! (.-hsluv_l conv) l
                .!hsluvToRgb conv 
                .!getHex $ .!setRGB color (.-rgb_r conv) (.-rgb_g conv) (.-rgb_r conv)
        |hslx $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn hslx (h s l)
              let
                  c $ new THREE/Color
                .!getHex $ .!setHSL c (/ h 360) (/ s 100) (/ l 100)
        |init-controls! $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn init-controls! () $ let
                renderer @*global-renderer
                scene @*global-scene
                ctrl-0 $ -> renderer .-xr (.!getController 0)
                ctrl-1 $ -> renderer .-xr (.!getController 1)
                ctrl-grip-0 $ -> renderer .-xr (.!getControllerGrip 0)
                ctrl-grip-1 $ -> renderer .-xr (.!getControllerGrip 1)
                hand-0 $ -> renderer .-xr (.!getHand 0)
                hand-1 $ -> renderer .-xr (.!getHand 1)
                controllerModelFactory $ new XRControllerModelFactory
                handModelFactory $ new XRHandModelFactory
                line-geo $ -> (new THREE/BufferGeometry)
                  .!setFromPoints $ js-array (new THREE/Vector3 0 0 0) (new THREE/Vector3 0 0 -1)
                line $ new THREE/Line line-geo
              js/document.body.appendChild $ .!createButton VRButton renderer
                js-object $ :requiredFeatures (js-array "\"hand-tracking")
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
              set! (.-name line) "\"line"
              -> line .-scale .-z $ set! 5
              .!add ctrl-0 $ .!clone line
              .!add ctrl-1 $ .!clone line
              listen-on-controller! ctrl-0
              listen-on-controller! ctrl-1
        |init-renderer! $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn init-renderer! (canvas-el options) (.!init RectAreaLightUniformsLib)
              reset! *global-renderer $ new THREE/WebGLRenderer
                js-object (:canvas canvas-el) (:antialias true)
              -> @*global-renderer .-xr .-enabled $ set! true
              ; if (:shadow-map? options)
                &let
                  m $ -> @*global-renderer .-shadowMap
                  -> m .-enabled $ set! true
                  -> m .-type $ set! THREE/VSMShadowMap
              ; reset! *global-composer $ new EffectComposer @*global-renderer
              ; let
                  render-scene $ new RenderPass @*global-scene @*global-camera
                .!addPass @*global-composer render-scene
              ; &doseq
                pass $ either (:composer-passes options) ([])
                .!addPass @*global-composer pass
              if
                some? $ :background options
                .!setClearColor @*global-renderer (:background options) 1
              ; set! (.-physicallyCorrectLights @*global-renderer) true
              ; set! (.-gammaFactor @*global-renderer) 22
              .!setPixelRatio @*global-renderer $ either js/window.devicePixelRatio 1
              .!setSize @*global-renderer js/window.innerWidth js/window.innerHeight
              .!setAnimationLoop @*global-renderer $ fn (t & aa)
                let
                    prev-t @*global-time
                  reset! *global-time t
                  if-let
                    session $ -> @*global-renderer .-xr (.!getSession)
                    let
                        p0 $ -> session .-inputSources .?-0
                        p1 $ -> session .-inputSources .?-1
                      let
                          d $ ->
                            []
                              if (some? p0) (read-input p0)
                              if (some? p1) (read-input p1)
                            filter some?
                        if
                          not $ empty? d
                          on-gamepad-event
                            last $ first d
                            * 0.001 $ - t prev-t
                .!updateProjectionMatrix @*global-camera
                .!render @*global-renderer @*global-scene @*global-camera
              ; .!setSize @*global-composer js/window.innerWidth js/window.innerHeight
              .!addEventListener canvas-el |click $ fn (event) (on-canvas-click event)
              .!addEventListener js/window |resize $ fn (event) (js/console.log "\"resize" js/window.innerWidth js/window.innerHeight)
                set! (.-aspect @*global-camera) (/ js/window.innerWidth js/window.innerHeight)
                .!setSize @*global-renderer js/window.innerWidth js/window.innerHeight
                .!updateProjectionMatrix @*global-camera
                ; .!setSize @*global-composer js/window.innerWidth js/window.innerHeight
                ; .!render @*global-composer
                .!render @*global-renderer @*global-scene @*global-camera
        |listen-on-controller! $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn listen-on-controller! (controller)
              let
                  temp-matrix $ new THREE/Matrix4
                  raycaster $ new THREE/Raycaster
                .!addEventListener controller "\"selectstart" $ fn (event)
                  -> temp-matrix (.!identity)
                    .!extractRotation $ .-matrixWorld controller
                  -> raycaster .-ray .-origin $ .!setFromMatrixPosition (.-matrixWorld controller)
                  -> raycaster .-ray .-direction (.!set 0 0 -1) (.!applyMatrix4 temp-matrix)
                  let
                      objects $ let
                          children $ js-array
                          collect! $ fn (x) (.!push children x)
                        collect-children @*global-scene collect!
                        , children
                      intersects $ -> (.!intersectObjects raycaster objects)
                        .!filter $ fn (target pos _xs) (-> target .-object .-event some?)
                    if-let
                      maybe-target $ .-0 intersects
                      call-event-on-target! maybe-target event
        |move-viewer-by! $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn move-viewer-by! (x0 y0 z0)
              let-sugar
                  camera @*global-camera
                  ([] dx dy dz) (to-viewer-axis x0 y0 z0)
                  position $ .-position camera
                  x $ &+ (.-x position) dx
                  y $ &+ (.-y position) dy
                  z $ &+ (.-z position) dz
                ; println ([] x0 y0 z0) |=> $ [] dx dy dz
                set! (.-x position) x
                set! (.-y position) y
                set! (.-z position) z
                .!lookAt camera $ new-lookat-point
                .!render @*global-renderer @*global-scene @*global-camera
        |new-lookat-point $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn new-lookat-point () $ let-sugar
                camera @*global-camera
                position $ .-position camera
                x2 $ &+ (.-x position)
                  &* 4 $ cos @*viewer-angle
                y2 $ &+ (.-y position) (&* 0.2 @*viewer-y-shift)
                z2 $ &+ (.-z position)
                  &* -4 $ sin @*viewer-angle
              new THREE/Vector3 x2 y2 z2
        |read-input $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn read-input (p0)
              let
                  gamepad $ -> p0 .-gamepad
                  axes $ .-axes gamepad
                  buttons $ .-buttons gamepad
                if
                  > (.-length buttons) 5
                  let
                      data $ {}
                        :v1 $ -> buttons .-0 .-value
                        :v2 $ -> buttons .-1 .-value
                        :a $ -> buttons .-4 .-value
                        :b $ -> buttons .-5 .-value
                        :dx $ -> axes .-2
                        :dy $ -> axes .-3
                      controller $ -> @*global-renderer .-xr (.!getController 0)
                      grip $ -> @*global-renderer .-xr (.!getControllerGrip 0)
                      rot $ .-rotation controller
                      rotation $ :: :v3 (.-x rot) (.-y rot) (.-z rot)
                    if (not= data data0)
                      []
                        turn-tag $ -> p0 .-handedness
                        {}
                          :v1 $ -> buttons .-0 .-value
                          :v2 $ -> buttons .-1 .-value
                          :a $ > (-> buttons .-4 .-value)  0.5
                          :b $ > (-> buttons .-5 .-value) 0.5
                          :dx $ -> axes .-2
                          :dy $ -> axes .-3
                          :rotation rotation
                          :forward $ camera-direction-for 0 0 -1
                          :upward $ camera-direction-for 0 1 0
                          :rightward $ camera-direction-for 1 0 0
                  , nil
        |refine-strength $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn refine-strength (x)
              &* x $ sqrt
                js/Math.abs $ &* x 0.02
        |render-canvas! $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn render-canvas! (markup dispatch!) (; js/console.log "\"render" markup) (reset! *proxied-dispatch dispatch!)
              if (some? @*global-tree)
                let
                    collect! $ fn (x) (swap! *tmp-changes conj x)
                  reset! *tmp-changes $ []
                  diff-tree @*global-tree markup ([]) collect!
                  apply-changes @*tmp-changes
                build-tree ([]) (purify-tree markup)
              reset! *global-tree markup
              ; .!render @*global-renderer @*global-scene @*global-camera
        |rotate-viewer-by! $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn rotate-viewer-by! (x)
              let
                  camera @*global-camera
                swap! *viewer-angle &+ x
                .!lookAt camera $ new-lookat-point
                .!render @*global-renderer @*global-scene @*global-camera
        |shift-viewer-by! $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn shift-viewer-by! (x)
              let
                  camera @*global-camera
                if (= x false) (reset! *viewer-y-shift 0)
                  swap! *viewer-y-shift &+ $ * 2 x
                .!lookAt camera $ new-lookat-point
                .!render @*global-renderer @*global-scene @*global-camera
        |to-viewer-axis $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn to-viewer-axis (x y z)
              let
                  length $ sqrt
                    + (pow x 2) (pow y 2) (pow z 2)
                  angle @*viewer-angle
                  project-distance 20
                  shift @*viewer-y-shift
                  v-angle $ js/Math.atan (/ shift project-distance)
                  from-y $ []
                    -> y
                      * $ js/Math.cos (+ v-angle half-pi)
                      * $ js/Math.cos angle
                    -> y $ *
                      js/Math.sin $ + v-angle half-pi
                    -> y
                      * $ js/Math.cos (+ v-angle half-pi)
                      * $ js/Math.sin angle
                      negate
                  from-x $ wo-log
                    []
                      -> x $ *
                        js/Math.cos $ - angle half-pi
                      , 0 $ -> x
                        * $ js/Math.sin (- angle half-pi)
                        negate
                  from-z $ []
                    -> z (negate)
                      * $ js/Math.cos v-angle
                      * $ js/Math.cos angle
                    -> z (negate)
                      * $ js/Math.sin v-angle
                    -> z (negate)
                      * $ js/Math.cos v-angle
                      * $ js/Math.sin angle
                      negate
                -> from-x (&v+ from-y) (&v+ from-z)
        |tween-call $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn tween-call (n d f)
              &doseq
                i $ range 1 n
                js/setTimeout
                  fn () $ f i
                  * d i
        |tween-move-camera! $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn tween-move-camera! (control)
              let
                  camera @*global-camera
                tag-match control
                    :shift shift
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
                          position $ .-position camera
                          x $ &+ (.-x position) (/ dx 10)
                          y $ &+ (.-y position) (/ dy 10)
                          z $ &+ (.-z position) (/ dz 10)
                        set! (.-x position) x
                        set! (.-y position) y
                        set! (.-z position) z
                        .!lookAt camera $ new-lookat-point
                        .!render @*global-renderer @*global-scene @*global-camera
                  _ $ println "\"unknown camera control:" control
      :ns $ %{} :CodeEntry (:doc |)
        :code $ quote
          ns quatrefoil.core $ :require
            quatrefoil.dsl.diff :refer $ diff-tree
            quatrefoil.dsl.object3d-dom :refer $ build-tree on-canvas-click on-control-event call-event-on-target! on-gamepad-event
            quatrefoil.util.core :refer $ purify-tree collect-children
            quatrefoil.dsl.patch :refer $ apply-changes
            quatrefoil.schema :refer $ Component
            "\"three" :as THREE
            quatrefoil.globals :refer $ *global-tree *global-camera *global-renderer *global-time *global-composer *global-scene *proxied-dispatch *viewer-angle *viewer-y-shift
            "\"three/examples/jsm/lights/RectAreaLightUniformsLib" :refer $ RectAreaLightUniformsLib
            "\"three/examples/jsm/postprocessing/EffectComposer" :refer $ EffectComposer
            "\"three/examples/jsm/postprocessing/RenderPass" :refer $ RenderPass
            "\"three/addons/webxr/XRControllerModelFactory.js" :refer $ XRControllerModelFactory
            "\"three/addons/webxr/XRHandModelFactory.js" :refer $ XRHandModelFactory
            touch-control.core :refer $ render-control! control-states start-control-loop! clear-control-loop!
            quaternion.core :refer $ &c* &c+ &v+
            "\"@quatrefoil/utils" :refer $ hcl-to-hex
            "\"hsluv" :refer $ Hsluv
            "\"three/addons/webxr/VRButton.js" :refer $ VRButton
    |quatrefoil.cursor $ %{} :FileEntry
      :defs $ {}
        |update-states $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn update-states (store pair)
              let[] (cursor new-state) pair $ assoc-in store
                concat ([] :states) cursor $ [] :data
                , new-state
      :ns $ %{} :CodeEntry (:doc |)
        :code $ quote (ns quatrefoil.cursor)
    |quatrefoil.dsl.diff $ %{} :FileEntry
      :defs $ {}
        |diff-children $ %{} :CodeEntry (:doc |)
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
        |diff-events $ %{} :CodeEntry (:doc |)
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
        |diff-material $ %{} :CodeEntry (:doc |)
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
        |diff-params $ %{} :CodeEntry (:doc |)
          :code $ quote
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
        |diff-tree $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn diff-tree (prev-tree tree coord collect!) (; js/console.log |Diffing: coord prev-tree tree)
              cond
                  = nil prev-tree tree
                  &let () nil
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
                  if
                    not= (:attributes prev-tree) (:attributes tree)
                    collect! $ [] coord :change-attributes (:attributes tree)
                  diff-material (:material prev-tree) (:material tree) coord collect!
                  diff-events (:event prev-tree) (:event tree) coord collect!
                  diff-children (:children prev-tree) (:children tree) coord collect!
        |select-keys $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn select-keys (m xs)
              foldl ({})
                fn (acc x)
                  assoc acc x $ &get m x
      :ns $ %{} :CodeEntry (:doc |)
        :code $ quote
          ns quatrefoil.dsl.diff $ :require
            quatrefoil.util.core :refer $ purify-tree
            quatrefoil.schema :refer $ comp? shape?
    |quatrefoil.dsl.object3d-dom $ %{} :FileEntry
      :defs $ {}
        |*focused-coord $ %{} :CodeEntry (:doc |)
          :code $ quote (defatom *focused-coord nil)
        |build-tree $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn build-tree (coord tree) (; js/console.log "\"build tree:" coord tree)
              if (some? tree)
                let
                    object3d $ create-shape (assoc tree :children nil) coord
                    children $ -> (:children tree) (.to-list)
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
                      .!addBy object3d (first entry) child
                  , object3d
                new THREE/Object3D
        |call-event-on-target! $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn call-event-on-target! (maybe-target event)
              let
                  element-tree @*global-tree
                  coord $ -> maybe-target .-object .-coord
                  target-el $ find-element element-tree coord
                  maybe-handler $ -> target-el :event :click
                if (some? coord)
                  do
                    if (some? maybe-handler) (maybe-handler event @*proxied-dispatch) (println "|no handler" coord)
                    reset! *focused-coord coord
                    ; println "\"focus to" coord
                  do (reset! *focused-coord nil) (eprintln "\"lose focus")
        |create-ambient-light $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn create-ambient-light (params position)
              let
                  color $ :color params
                  intensity $ either (:intensity params) 1
                  object3d $ new THREE/AmbientLight color intensity
                set-position! object3d position
                ; js/console.log |Light: object3d
                , object3d
        |create-box-element $ %{} :CodeEntry (:doc |)
          :code $ quote
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
                set! (.-event object3d) event
                , object3d
        |create-buffer-object-element $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn create-buffer-object-element (params position rotation scale material)
              let
                  vertices $ new js/Float32Array
                    js-array & $ either (:vertices params) ([])
                  indices $ js-array &
                    either (:indices params) ([])
                  geometry $ new THREE/BufferGeometry
                  object3d $ do
                    .!setAttribute geometry "\"position" $ new THREE/BufferAttribute vertices 3
                    if
                      > (.-length indices) 0
                      .!setIndex geometry indices
                    .!computeVertexNormals geometry
                    new THREE/Mesh geometry $ create-material material
                set! (.-castShadow object3d) true
                set! (.-receiveShadow object3d) true
                set-position! object3d position
                set-rotation! object3d rotation
                set-scale! object3d scale
                , object3d
        |create-directional-light $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn create-directional-light (params position)
              let
                  color $ :color params
                  intensity $ :intensity params
                  object3d $ new THREE/DirectionalLight color intensity
                set! (.-castShadow object3d) true
                -> object3d .-shadow .-bias $ set! -0.0005
                set-position! object3d position
                js/console.log "|directional light:" object3d
                , object3d
        |create-group-element $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn create-group-element (params position rotation scale)
              let
                  object3d $ new THREE/Group
                set-position! object3d position
                set-rotation! object3d rotation
                set-scale! object3d scale
                , object3d
        |create-line-element $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn create-line-element (params position rotation scale material)
              let
                  points $ &let
                    ps $ js-array
                    &doseq
                      p $ :points params
                      .!push ps $ new THREE/Vector3 & p
                    , ps
                  geometry $ -> (new THREE/BufferGeometry) (.!setFromPoints points)
                  object3d $ new THREE/Line geometry (create-material material)
                set-position! object3d position
                set-rotation! object3d rotation
                set-scale! object3d scale
                , object3d
        |create-line-segments-element $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn create-line-segments-element (params position rotation scale material)
              let
                  points $ &let
                    ps $ js-array
                    if
                      some? $ :segments params
                      &doseq
                        segment $ :segments params
                        let
                            p0 $ nth segment 0
                            p1 $ nth segment 1
                          .!push ps (new THREE/Vector3 & p0) (new THREE/Vector3 & p1)
                      &doseq
                        p $ :points params
                        .!push ps $ new THREE/Vector3 & p
                    , ps
                  geometry $ -> (new THREE/BufferGeometry) (.!setFromPoints points)
                  object3d $ new THREE/LineSegments geometry (create-material material)
                set-position! object3d position
                set-rotation! object3d rotation
                set-scale! object3d scale
                , object3d
        |create-material $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn create-material (material)
              &let
                m $ case-default (:kind material)
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
                      set! (.-side options) THREE/DoubleSide
                      , options
                set! (.-side m) THREE/DoubleSide
                , m
        |create-mesh-line-element $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn create-mesh-line-element (params position rotation scale material)
              let
                  points $ &let
                    ps $ js-array
                    &doseq
                      p $ :points params
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
                set! (.-raycast object3d) raycast
                , object3d
        |create-parametric-element $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn create-parametric-element (params position rotation scale material)
              let
                  func $ either (:func params)
                    fn (a b data) ([] a b 0)
                  data $ :data params
                  slices $ either (:slices params) 10
                  stacks $ either (:stacks params) 10
                  geometry $ new ParametricGeometry
                    fn (u v target)
                      let[] (x y z) (func u v data) (.!set target x y z)
                    , slices stacks
                  object3d $ new THREE/Mesh geometry (create-material material)
                set! (.-castShadow object3d) true
                set! (.-receiveShadow object3d) true
                set-position! object3d position
                set-rotation! object3d rotation
                set-scale! object3d scale
                , object3d
        |create-plane-reflector $ %{} :CodeEntry (:doc |)
          :code $ quote
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
        |create-point-light $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn create-point-light (params position)
              let
                  color $ :color params
                  intensity $ :intensity params
                  distance $ :distance params
                  object3d $ new THREE/PointLight color intensity distance
                set! (.-castShadow object3d) true
                set-position! object3d position
                -> object3d .-shadow .-bias $ set! -0.005
                ; js/console.log |Light: object3d
                , object3d
        |create-polyhedron-element $ %{} :CodeEntry (:doc |)
          :code $ quote
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
        |create-rect-area-light $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn create-rect-area-light (params position rotation)
              let
                  color $ :color params
                  intensity $ :intensity params
                  width $ :width params
                  height $ :height params
                  look-at $ :look-at params
                  object3d $ new THREE/RectAreaLight color intensity width height
                .!lookAt object3d & look-at
                set! (.-castShadow object3d) true
                set-position! object3d position
                set-rotation! object3d rotation
                ; js/console.log "|Area Light:" object3d
                .!add object3d $ new RectAreaLightHelper object3d
                , object3d
        |create-shader-mesh $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn create-shader-mesh (attributes params position rotation scale material)
              let
                  vertices $ new js/Float32Array
                    js-array & $ either (:vertices params) ([])
                  geometry $ let
                      g $ new THREE/BufferGeometry
                    set-geometry-attributes! g attributes
                    , g
                  object3d $ new THREE/Mesh geometry (create-material material)
                set! (.-castShadow object3d) true
                set! (.-receiveShadow object3d) true
                set-position! object3d position
                set-rotation! object3d rotation
                set-scale! object3d scale
                , object3d
        |create-shape $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn create-shape (element coord)
              ; js/console.log |Element: element $ :coord element
              let
                  params $ &record:get element :params
                  position $ &record:get element :position
                  scale $ &record:get element :scale
                  rotation $ &record:get element :rotation
                  material $ either (&record:get element :material)
                    {} (:kind :mesh-basic) (:color 0xa0a0a0)
                  event $ &record:get element :event
                case-default (&record:get element :name)
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
                  :shader-mesh $ create-shader-mesh (&record:get element :attributes) params position rotation scale material
                  :some-object $ create-some-object params position rotation scale material
        |create-shape-element $ %{} :CodeEntry (:doc |)
          :code $ quote
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
        |create-some-object $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn create-some-object (params position rotation scale material)
              let
                  object3d $ new THREE/Object3D 
                  obj $ get @*loaded-objects (:key params)
                set-position! object3d position
                set-rotation! object3d rotation
                set-scale! object3d scale
                set! (.-castShadow object3d) true
                set! (.-receiveShadow object3d) true
                ; set! (.-coord object3d) coord
                ; set! (.-event object3d) event
                if (some? obj) (.!add object3d obj)
                  js/console.warn "\"object not loaded for" $ :key params
                , object3d
        |create-sphere-element $ %{} :CodeEntry (:doc |)
          :code $ quote
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
                set! (.-event object3d) event
                ; js/console.log |Sphere: object3d
                , object3d
        |create-spline-element $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn create-spline-element (params position rotation scale material)
              let
                  points0 $ :points params
                  curve $ new THREE/CatmullRomCurve3
                    js-array & $ -> points0
                      map $ fn (p) (new THREE/Vector3 & p)
                  points $ .!getPoints curve
                    * 16 $ count points0
                  geometry $ -> (new THREE/BufferGeometry) (.!setFromPoints points)
                  object3d $ new THREE/Line geometry (create-material material)
                set! (.-castShadow object3d) true
                set! (.-receiveShadow object3d) true
                set-position! object3d position
                set-rotation! object3d rotation
                set-scale! object3d scale
                , object3d
        |create-spot-light $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn create-spot-light (params position)
              let
                  color $ :color params
                  intensity $ :intensity params
                  distance $ :distance params
                  angle $ or (:angle params) (* 0.5 &PI)
                  penumbra $ or (:penumbra params) 0.5
                  decay $ or (:decay params) 1.5
                  object3d $ new THREE/SpotLight color intensity distance angle penumbra decay
                set! (.-castShadow object3d) true
                -> object3d .-shadow .-bias $ set! -0.0005
                set-position! object3d position
                js/console.log |Light: object3d
                , object3d
        |create-text-element $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn create-text-element (params position rotation scale material)
              let
                  geometry $ new TextGeometry
                    or (:text params) |Quatrefoil
                    to-js-data $ assoc params :font font-resource
                  object3d $ new THREE/Mesh geometry (create-material material)
                set-position! object3d position
                set-rotation! object3d rotation
                set-scale! object3d scale
                set! (.-castShadow object3d) true
                set! (.-receiveShadow object3d) true
                , object3d
        |create-torus-element $ %{} :CodeEntry (:doc |)
          :code $ quote
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
        |create-tube-element $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn create-tube-element (params position rotation scale material)
              let
                  points-fn $ :points-fn params
                  factor $ :factor params
                  geometry $ ->
                    new THREE/TubeGeometry (make-tube-curve points-fn factor)
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
        |font-resource $ %{} :CodeEntry (:doc |)
          :code $ quote
            def font-resource $ new Font
              js/JSON.parse $ load-file |assets/hind.json
        |load-file $ %{} :CodeEntry (:doc |)
          :code $ quote
            defmacro load-file (filename) (read-file filename)
        |on-canvas-click $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn on-canvas-click (event)
              let
                  mouse $ new THREE/Vector2
                  raycaster $ new THREE/Raycaster
                set! (.-x mouse)
                  dec $ * 2
                    / (.-clientX event) js/window.innerWidth
                set! (.-y mouse)
                  - 1 $ * 2
                    / (.-clientY event) js/window.innerHeight
                .!setFromCamera raycaster mouse @*global-camera
                let
                    intersects $ ->
                      .!intersectObjects raycaster $ let
                          children $ js-array
                          collect! $ fn (x) (.!push children x)
                        collect-children @*global-scene collect!
                        , children
                      .!filter $ fn (target pos _xs) (-> target .-object .-event some?)
                  ; js/console.log intersects
                  if-let
                    maybe-target $ .-0 intersects
                    call-event-on-target! maybe-target event
                    do (reset! *focused-coord nil) (println "\"lose focus")
        |on-control-event $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn on-control-event (move delta elapsed)
              if (some? @*focused-coord)
                let
                    coord @*focused-coord
                    element-tree @*global-tree
                    target-el $ find-element element-tree coord
                    maybe-handler $ -> target-el (get :event) (get :control)
                  if (some? maybe-handler) (maybe-handler move delta elapsed @*proxied-dispatch) (;nil println "|Found no handler for" coord)
                println "\"no focused coord to control" @*focused-coord
        |on-gamepad-event $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn on-gamepad-event (info elapsed)
              if (some? @*focused-coord)
                let
                    coord @*focused-coord
                    element-tree @*global-tree
                    target-el $ find-element element-tree coord
                    maybe-handler $ -> target-el (get :event) (get :gamepad)
                  if (some? maybe-handler) (maybe-handler info elapsed @*proxied-dispatch) (;nil println "|Found no handler for" coord)
                println "\"no focused coord to control" @*focused-coord
        |set-geometry-attributes! $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn set-geometry-attributes! (g attributes)
              &doseq (info attributes)
                let
                    name $ turn-string (:id info)
                    buffer $ :buffer info
                    size $ :size info
                    type $ :type info
                    attr $ case-default type
                      do (js/console.warn "\"use f32 as default attribute type")
                        new THREE/Float32BufferAttribute (js-array & buffer) size
                      :f32 $ new THREE/Float32BufferAttribute (js-array & buffer) size
                      :u8 $ new THREE/Float32BufferAttribute (js-array & buffer) size
                  .!setAttribute g name attr
        |set-perspective-camera! $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn set-perspective-camera! (params)
              let
                  fov $ :fov params
                  aspect $ :aspect params
                  near $ :near params
                  far $ :far params
                  object3d $ new THREE/PerspectiveCamera fov aspect near far
                set-position! object3d $ :position params
                reset! *global-camera object3d
                , object3d
        |set-position! $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn set-position! (object position)
              if (some? position)
                let[] (x y z) position $ .!set (.-position object) x y z
        |set-rotation! $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn set-rotation! (object3d rotation)
              if (some? rotation)
                let[] (x y z) rotation $ .!set (.-rotation object3d) x y z
        |set-scale! $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn set-scale! (object scale)
              if (some? scale)
                let[] (x y z) scale $ .!set (.-scale object) (scale-zero x) (scale-zero y) (scale-zero z)
        |write-shape-path! $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn write-shape-path! (s op)
              tag-match op
                  :move-to x y
                  .!moveTo s x y
                (:line-to x y) (.!lineTo s x y)
                (:quadratic-curve-to x0 y0 x1 y1) (.!quadraticCurveTo s x0 y0 x1 y1)
                (:bezier-curve-to x0 y0 x1 y1 x2 y2) (.!bezierCurveTo s x0 y0 x1 y1 x2 y2)
                _ $ js/console.log "\"Unknown shape path" op
      :ns $ %{} :CodeEntry (:doc |)
        :code $ quote
          ns quatrefoil.dsl.object3d-dom $ :require
            quatrefoil.util.core :refer $ purify-tree collect-children find-element scale-zero
            quatrefoil.globals :refer $ *loaded-objects
            "\"three" :as THREE
            "\"three/examples/jsm/geometries/TextGeometry" :refer $ TextGeometry
            quatrefoil.globals :refer $ *global-renderer *global-camera *global-scene *global-tree *proxied-dispatch
            "\"@quatrefoil/utils" :refer $ make-tube-curve
            "\"three/examples/jsm/helpers/RectAreaLightHelper" :refer $ RectAreaLightHelper
            "\"three/examples/jsm/objects/Reflector" :refer $ Reflector
            "\"three/examples/jsm/loaders/FontLoader" :refer $ Font
            "\"three/examples/jsm/geometries/ParametricGeometry" :refer $ ParametricGeometry
            "\"meshline" :refer $ MeshLineGeometry MeshLineMaterial raycast
    |quatrefoil.dsl.patch $ %{} :FileEntry
      :defs $ {}
        |add-children $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn add-children (target coord op-data)
              &doseq (entry op-data)
                let-sugar
                      [] k tree
                      , entry
                  .!addBy target k $ build-tree (conj coord k) tree
        |add-element $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn add-element (target coord op-data)
              if (empty? coord) (js/console.warn "|Cannot remove by empty coord!")
                let
                    parent $ reach-object3d @*global-scene (butlast coord)
                  .!addBy parent (last coord) (build-tree coord op-data)
        |apply-changes $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn apply-changes (changes)
              ; js/console.log "\"changes" (count changes) changes
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
                    :change-attributes $ set-geometry-attributes! (.-geometry target) op-data
        |remove-children $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn remove-children (target coord op-data)
              &doseq (child-key op-data) (.!removeBy target child-key)
        |remove-element $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn remove-element (target coord)
              if (empty? coord) (js/console.warn "|Cannot remove by empty coord!")
                let
                    parent $ reach-object3d @*global-scene (butlast coord)
                  .!removeBy parent $ last coord
        |remove-material $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn remove-material (target coord op-data)
              let
                  material $ .-material target
                &doseq (entry op-data)
                  case-default entry (println "|Unknown material prop:" op-data)
                    :opacity $ set! (.-opacity material) 0.9
                    :transparent $ set! (.-transparent material) 1
        |replace-element $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn replace-element (target coord op-data)
              if (empty? coord) (js/console.warn "|Cannot replace with empty coord!")
                let
                    parent $ reach-object3d @*global-scene (butlast coord)
                  .!replaceBy parent (last coord) (build-tree coord op-data)
        |replace-material $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn replace-material (target coord op-data)
              set! (.-material target) (create-material op-data)
        |update-material $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn update-material (target coord op-data) (; println "|Update material" coord op-data)
              let
                  material $ .-material target
                ; js/console.log target
                &doseq
                  entry $ .to-list op-data
                  let[] (param new-value) entry $ case-default param (js/console.log "|Unknown param:" param)
                    :color $ .!set (.-color material) (new THREE/Color new-value)
                    :opacity $ set! (.-opacity material) new-value
                    :transparent $ set! (.-transparent material) new-value
                    :lineWidth $ set! (.-lineWidth material) new-value
                    :uniforms $ set! (.-uniforms material) (to-js-data new-value)
                    :fragmentShader $ set! (.-fragmentShader material) new-value
                    :vertexShader $ set! (.-vertexShader material) new-value
                    :wireframe $ set! (.-wireframe material) new-value
                set! (.-needsUpdate material) true
      :ns $ %{} :CodeEntry (:doc |)
        :code $ quote
          ns quatrefoil.dsl.patch $ :require
            quatrefoil.dsl.object3d-dom :refer $ [] build-tree set-position! set-rotation! set-scale! create-material
            [] quatrefoil.util.core :refer $ [] reach-object3d scale-zero
            quatrefoil.dsl.object3d-dom :refer $ set-geometry-attributes!
            quatrefoil.globals :refer $ *global-scene
            "\"three" :as THREE
    |quatrefoil.globals $ %{} :FileEntry
      :defs $ {}
        |*global-camera $ %{} :CodeEntry (:doc |)
          :code $ quote (defatom *global-camera nil)
        |*global-composer $ %{} :CodeEntry (:doc |)
          :code $ quote (defatom *global-composer nil)
        |*global-renderer $ %{} :CodeEntry (:doc |)
          :code $ quote (defatom *global-renderer nil)
        |*global-scene $ %{} :CodeEntry (:doc |)
          :code $ quote
            defatom *global-scene $ new THREE/Scene
        |*global-time $ %{} :CodeEntry (:doc |)
          :code $ quote (defatom *global-time 0)
        |*global-tree $ %{} :CodeEntry (:doc |)
          :code $ quote (defatom *global-tree nil)
        |*loaded-objects $ %{} :CodeEntry (:doc |)
          :code $ quote
            defatom *loaded-objects $ {}
        |*proxied-dispatch $ %{} :CodeEntry (:doc |)
          :code $ quote (defatom *proxied-dispatch nil)
        |*viewer-angle $ %{} :CodeEntry (:doc |)
          :code $ quote
            defatom *viewer-angle $ &/ &PI 2
        |*viewer-y-shift $ %{} :CodeEntry (:doc |)
          :code $ quote (defatom *viewer-y-shift 0)
      :ns $ %{} :CodeEntry (:doc |)
        :code $ quote
          ns quatrefoil.globals $ :require ("\"three" :as THREE)
    |quatrefoil.math $ %{} :FileEntry
      :defs $ {}
        |rand-around $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn rand-around (base x)
              + base (rand x) (* -0.5 x)
      :ns $ %{} :CodeEntry (:doc |)
        :code $ quote
          ns quatrefoil.math $ :require ("\"three" :as THREE)
            "\"@calcit/std" :refer $ rand
    |quatrefoil.schema $ %{} :FileEntry
      :defs $ {}
        |Component $ %{} :CodeEntry (:doc |)
          :code $ quote (defrecord Component :name :tree)
        |Shape $ %{} :CodeEntry (:doc |)
          :code $ quote (defrecord Shape :name :params :position :scale :rotation :material :event :attributes :children)
        |comp? $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn comp? (x)
              and (record? x) (&record:matches? Component x)
        |shape? $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn shape? (x)
              and (record? x) (&record:matches? Shape x)
      :ns $ %{} :CodeEntry (:doc |)
        :code $ quote (ns quatrefoil.schema)
    |quatrefoil.util.core $ %{} :FileEntry
      :defs $ {}
        |=component? $ %{} :CodeEntry (:doc |)
          :code $ quote
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
        |=seq? $ %{} :CodeEntry (:doc |)
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
        |collect-children $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn collect-children (element collect!)
              .!forEach (.-children element)
                fn (child idx _) (; js/console.log |Child: child) (collect! child)
                  if
                    some? $ .-children child
                    collect-children child collect!
        |find-element $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn find-element (tree coord) (; js/console.log |Find... tree coord)
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
        |purify-tree $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn purify-tree (tree)
              cond
                  nil? tree
                  , nil
                (comp? tree)
                  recur $ :tree tree
                true $ update tree :children
                  fn (children)
                    -> children (.to-list)
                      map $ fn (entry)
                        update entry 1 $ fn (child) (purify-tree child)
                      pairs-map
        |reach-object3d $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn reach-object3d (object3d coord)
              if (empty? coord) object3d $ let
                  cursor $ first coord
                recur (.!reachBy object3d cursor) (rest coord)
        |scale-zero $ %{} :CodeEntry (:doc |)
          :code $ quote
            defn scale-zero (x)
              if (&= 0 x) 0.01 x
      :ns $ %{} :CodeEntry (:doc |)
        :code $ quote
          ns quatrefoil.util.core $ :require
            quatrefoil.schema :refer $ Component Shape comp? shape?
