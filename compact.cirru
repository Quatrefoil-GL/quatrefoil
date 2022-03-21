
{} (:package |quatrefoil)
  :configs $ {} (:init-fn |quatrefoil.app.main/main!) (:reload-fn |quatrefoil.app.main/reload!)
    :modules $ [] |touch-control/ |pointed-prompt/
    :version |0.0.18
  :entries $ {}
  :files $ {}
    |quatrefoil.app.comp.lines $ {}
      :ns $ quote
        ns quatrefoil.app.comp.lines $ :require
          quatrefoil.alias :refer $ group box sphere text line line-segments mesh-line spline tube point-light ambient-light
          quatrefoil.core :refer $ defcomp
          "\"@calcit/std" :refer $ rand-shift
          "\"three" :as THREE
      :defs $ {}
        |comp-fly-city $ quote
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
                  :position $ [] 30 120 40
                  :material $ {} (:kind :mesh-basic) (:color 0xffff55) (:opacity 0.8) (:transparent true)
                  :event $ {}
                    :click $ fn (e d!)
                      d! cursor $ assoc state :buildings (make-building-data 80)
                point-light $ {} (:color 0xffff55) (:intensity 2) (:distance 600)
                  :position $ [] 30 120 40
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
        |make-building-data $ quote
          defn make-building-data (n)
            -> (range n)
              map $ fn (i)
                [] (rand-shift 0 160) (rand-shift 0 160) (rand-shift 12 8) (rand-shift 8 6) (rand-shift 60 50)
        |forward-lines $ quote
          def forward-lines $ -> (range 20)
            map $ fn (idx)
              let
                  pos $ * 10 (- idx 10)
                line $ {}
                  :points $ [] ([] pos 0 -200) ([] pos 0 200)
                  :position $ [] 0 0 0
                  :material $ {} (:kind :line-dashed) (:color 0xccccff) (:opacity 0.3) (:transparent true) (:linewidth 2) (:gapSize 0.5) (:dashSize 0.5)
        |comp-lines $ quote
          defcomp comp-lines () $ group ({})
            text $ {} (:text |Lines) (:size 4) (:height 1)
              :position $ [] 0 0 4
              :material $ {} (:kind :mesh-lambert) (:color 0xffcccc) (:opacity 0.9) (:transparent true)
            line $ {}
              :points $ [] ([] 0 0 0) ([] 3 3 4) ([] 1 4 6) ([] -2 8 0) ([] 2 5 1)
              :position $ [] 0 -10 0
              :material $ {} (:kind :line-dashed) (:color 0xaaaaff) (:opacity 0.9) (:transparent true) (:linewidth 4) (:gapSize 0.5) (:dashSize 0.5)
            mesh-line $ {}
              :points $ [] ([] 0 0 0) ([] 3 3 4) ([] 1 4 6) ([] -2 8 0) ([] 2 5 1)
              :position $ [] 5 -10 0
              :material $ {} (:kind :mesh-line) (:color 0xaaaaff) (:transparent true) (:opacity 0.4) (:depthTest true) (:lineWidth 0.5)
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
        |horizontal-lines $ quote
          def horizontal-lines $ -> (range 20)
            map $ fn (idx)
              let
                  pos $ * 10 (- idx 10)
                line $ {}
                  :points $ [] ([] -200 0 pos) ([] 200 0 pos)
                  :position $ [] 0 0 0
                  :material $ {} (:kind :line-dashed) (:color 0xccccff) (:opacity 0.3) (:transparent true) (:linewidth 2) (:gapSize 0.5) (:dashSize 0.5)
        |cloud-fn $ quote
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
    |quatrefoil.app.materials $ {}
      :ns $ quote (ns quatrefoil.app.materials)
      :defs $ {}
        |cover-line $ quote
          def cover-line $ {} (:kind :line-basic) (:color 0xaaaaff) (:opacity 0.9) (:transparent true)
    |quatrefoil.globals $ {}
      :ns $ quote
        ns quatrefoil.globals $ :require ("\"three" :as THREE)
      :defs $ {}
        |*viewer-y-shift $ quote (defatom *viewer-y-shift 0)
        |*proxied-dispatch $ quote (defatom *proxied-dispatch nil)
        |*global-scene $ quote
          defatom *global-scene $ new THREE/Scene
        |*global-renderer $ quote (defatom *global-renderer nil)
        |*global-camera $ quote (defatom *global-camera nil)
        |*viewer-angle $ quote
          defatom *viewer-angle $ &/ &PI 2
        |*global-tree $ quote (defatom *global-tree nil)
    |quatrefoil.core $ {}
      :ns $ quote
        ns quatrefoil.core $ :require
          quatrefoil.dsl.diff :refer $ diff-tree
          quatrefoil.dsl.object3d-dom :refer $ build-tree on-canvas-click on-control-event
          quatrefoil.util.core :refer $ purify-tree
          quatrefoil.dsl.patch :refer $ apply-changes
          quatrefoil.schema :refer $ Component
          "\"three" :as THREE
          quatrefoil.globals :refer $ *global-tree *global-camera *global-renderer *global-scene *proxied-dispatch *viewer-angle *viewer-y-shift
          "\"three/examples/jsm/lights/RectAreaLightUniformsLib" :refer $ RectAreaLightUniformsLib
          touch-control.core :refer $ render-control! control-states start-control-loop! clear-control-loop!
          quatrefoil.math :refer $ &c* &c+ &v+
          "\"@quatrefoil/utils" :refer $ hcl-to-hex
      :defs $ {}
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
            .!render @*global-renderer @*global-scene @*global-camera
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
        |tween-call $ quote
          defn tween-call (n d f)
            &doseq
              i $ range 1 n
              js/setTimeout
                fn () $ f i
                * d i
        |hclx $ quote
          defn hclx (h c l) (hcl-to-hex h c l)
        |hslx $ quote
          defn hslx (h s l)
            let
                c $ new THREE/Color
              .!getHex $ .!setHSL c (/ h 360) (/ s 100) (/ l 100)
        |move-viewer-by! $ quote
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
              .!render @*global-renderer @*global-scene camera
        |rotate-viewer-by! $ quote
          defn rotate-viewer-by! (x)
            let
                camera @*global-camera
              swap! *viewer-angle &+ x
              .!lookAt camera $ new-lookat-point
              .!render @*global-renderer @*global-scene camera
        |init-renderer! $ quote
          defn init-renderer! (canvas-el options) (.!init RectAreaLightUniformsLib)
            reset! *global-renderer $ new THREE/WebGLRenderer
              &let
                options $ js-object (:canvas nil) (:antialias true)
                -> options .-canvas $ set! canvas-el
                , options
            if
              some? $ :background options
              .!setClearColor @*global-renderer (:background options) 1
            ; set! (.-physicallyCorrectLights @*global-renderer) true
            ; set! (.-gammaFactor @*global-renderer) 22
            .!setPixelRatio @*global-renderer $ either js/window.devicePixelRatio 1
            .!setSize @*global-renderer js/window.innerWidth js/window.innerHeight
            .!addEventListener canvas-el |click $ fn (event) (on-canvas-click event)
            .!addEventListener js/window |resize $ fn (event)
              set! (.-aspect @*global-camera) (/ js/window.innerWidth js/window.innerHeight)
              .!updateProjectionMatrix @*global-camera
              .!setSize @*global-renderer js/window.innerWidth js/window.innerHeight
              .!render @*global-renderer @*global-scene @*global-camera
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
        |refine-strength $ quote
          defn refine-strength (x)
            &* x $ sqrt
              js/Math.abs $ &* x 0.02
        |>> $ quote
          defn >> (states k)
            let
                parent-cursor $ either (:cursor states) ([])
                branch $ either (get states k) ({})
              assoc branch :cursor $ append parent-cursor k
        |to-viewer-axis $ quote
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
        |clear-cache! $ quote
          defn clear-cache! () $ ; "\"TODO memof..."
        |handle-control-events $ quote
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
        |half-pi $ quote
          def half-pi $ * 0.5 &PI
        |*tmp-changes $ quote (defatom *tmp-changes nil)
        |shift-viewer-by! $ quote
          defn shift-viewer-by! (x)
            let
                camera @*global-camera
              if (= x false) (reset! *viewer-y-shift 0)
                swap! *viewer-y-shift &+ $ * 2 x
              .!lookAt camera $ new-lookat-point
              .!render @*global-renderer @*global-scene camera
    |quatrefoil.math $ {}
      :ns $ quote
        ns quatrefoil.math $ :require ("\"three" :as THREE)
          "\"@calcit/std" :refer $ rand
      :defs $ {}
        |c-length2 $ quote
          defn c-length2 (v)
            let[] (x y) v $ + (js/Math.pow x 2) (js/Math.pow y 2)
        |&c* $ quote
          defn &c* (a b)
            let-sugar
                  [] x0 y0
                  , a
                ([] x1 y1) b
              []
                - (* x0 x1) (* y0 y1)
                + (* x0 y1) (* x1 y0)
        |&c+ $ quote
          defn &c+ (a b)
            let-sugar
                  [] x0 y0
                  , a
                ([] x1 y1) b
              [] (+ x0 x1) (+ y0 y1)
        |&c- $ quote
          defn &c- (a b)
            let-sugar
                  [] x0 y0
                  , a
                ([] x1 y1) b
              [] (- x0 x1) (- y0 y1)
        |&q* $ quote
          defn &q* (a b)
            &let
              v $ .!multiply
                new THREE/Quaternion (nth a 0) (nth a 1) (nth a 2) (nth a 3)
                new THREE/Quaternion (nth b 0) (nth b 1) (nth b 2) (nth b 3)
              [] (.-x v) (.-y v) (.-z v) (.-w v)
        |&q+ $ quote
          defn &q+ (a b)
            let-sugar
                  [] x y z w
                  , a
                ([] x1 y1 z1 w1) b
              [] (+ x x1) (+ y y1) (+ z z1) (+ w w1)
        |&q- $ quote
          defn &q- (a b)
            let-sugar
                  [] x y z w
                  , a
                ([] x1 y1 z1 w1) b
              [] (- x x1) (- y y1) (- z z1) (- w w1)
        |&v+ $ quote
          defn &v+ (a b)
            let[] (x y z) a $ let[] (x2 y2 z2) b
              [] (&+ x x2) (&+ y y2) (&+ z z2)
        |&v- $ quote
          defn &v- (a b)
            let[] (x y z) a $ let[] (x2 y2 z2) b
              [] (&- x x2) (&- y y2) (&- z z2)
        |q-length2 $ quote
          defn q-length2 (a)
            let[] (x y z w) a $ + (pow x 2) (pow y 2) (pow z 2) (pow w 2)
        |q-length $ quote
          defn q-length (a)
            let[] (x y z w) a $ sqrt
              + (pow x 2) (pow y 2) (pow z 2) (pow w 2)
        |q-scale $ quote
          defn q-scale (v n)
            let[] (x y z w) v $ [] (&* n x) (&* n y) (&* n z) (&* n w)
        |v-scale $ quote
          defn v-scale (v n)
            let[] (x y z w) v $ [] (&* n x) (&* n y) (&* n z)
              &* n $ either w 0
        |q+ $ quote
          defn q+ (& xs)
            foldl xs ([] 0 0 0 0)
              fn (acc x) (&q+ acc x)
        |q- $ quote
          defn q- (& xs)
            foldl (rest xs) (first xs)
              fn (acc x) (&q- acc x)
        |v+ $ quote
          defn v+ (& xs)
            foldl xs ([] 0 0 0)
              fn (acc x) (&v+ acc x)
        |v- $ quote
          defn v- (& xs)
            foldl (rest xs) (first xs)
              fn (acc x) (&v- acc x)
        |rand-around $ quote
          defn rand-around (base x)
            + base (rand x) (* -0.5 x)
        |c-length $ quote
          defn c-length (v)
            let[] (x y) v $ js/Math.sqrt
              + (js/Math.pow x 2) (js/Math.pow y 2)
        |q-inverse $ quote
          defn q-inverse (a)
            q-scale (q-conjugate a)
              &/ 1 $ q-length2 a
        |c-conjutate $ quote
          defn c-conjutate (a)
            let[] (x y) a $ [] (&- 0 x) w
        |q-conjugate $ quote
          defn q-conjugate (a)
            let[] (x y z w) a $ [] (&- 0 x) (&- 0 y) (&- 0 z) w
    |quatrefoil.app.main $ {}
      :ns $ quote
        ns quatrefoil.app.main $ :require
          "\"@quatrefoil/utils" :refer $ inject-tree-methods
          quatrefoil.core :refer $ render-canvas! *global-tree clear-cache! init-renderer! handle-key-event handle-control-events
          quatrefoil.app.comp.container :refer $ comp-container
          quatrefoil.dsl.object3d-dom :refer $ on-canvas-click
          quatrefoil.app.updater :refer $ [] updater
          "\"three" :as THREE
          touch-control.core :refer $ render-control! control-states start-control-loop! clear-control-loop!
          "\"mobile-detect" :default mobile-detect
          "\"bottom-tip" :default hud!
          "\"./calcit.build-errors" :default build-errors
      :defs $ {}
        |render-app! $ quote
          defn render-app! () (; println "|Render app:")
            render-canvas! (comp-container @*store) dispatch!
        |main! $ quote
          defn main! () (load-console-formatter!) (inject-tree-methods)
            let
                canvas-el $ js/document.querySelector |canvas
              init-renderer! canvas-el $ {} (:background 0x110022)
            render-app!
            add-watch *store :changes $ fn (store prev) (render-app!)
            set! js/window.onkeydown handle-key-event
            when mobile? (render-control!) (handle-control-events)
            println "|App started!"
        |*store $ quote
          defatom *store $ {}
            :tasks $ {}
              100 $ {} (:id 100) (:text "|Initial task") (:done? false)
            :states $ {}
              :cursor $ []
        |dispatch! $ quote
          defn dispatch! (op op-data)
            if (list? op)
              recur :states $ [] op op-data
              let
                  store $ updater @*store op op-data
                ; js/console.log |Dispatch: op op-data store
                reset! *store store
        |reload! $ quote
          defn reload! () $ if (some? build-errors) (hud! "\"error" build-errors)
            do (hud! "\"ok~" nil) (clear-cache!)
              when mobile? (clear-control-loop!) (handle-control-events)
              remove-watch *store :changes
              add-watch *store :changes $ fn (store prev) (render-app!)
              render-app!
              set! js/window.onkeydown handle-key-event
              println "|Code updated."
        |mobile? $ quote
          def mobile? $ .!mobile (new mobile-detect js/window.navigator.userAgent)
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
    |quatrefoil.app.comp.control $ {}
      :ns $ quote
        ns quatrefoil.app.comp.control $ :require
          quatrefoil.alias :refer $ group box sphere text line tube point-light
          quatrefoil.core :refer $ defcomp hslx
          quatrefoil.math :refer $ q* &q* v-scale q+
          quatrefoil.comp.control :refer $ comp-pin-point comp-value comp-value-2d
      :defs $ {}
        |comp-control-demo $ quote
          defcomp comp-control-demo (states)
            let
                cursor $ :cursor states
                state $ or (:data states)
                  {}
                    :p0 $ [] 0 0 0
                    :v0 0
                    :v1 $ [] 1 1
              group ({})
                comp-pin-point
                  {} (:speed 0.1) (:label "\"C") (:color 0xddaaff) (:radius 1) (:opacity 1)
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
                point-light $ {} (:color 0xffffff) (:intensity 1) (:distance 200)
                  :position $ [] 20 40 50
    |quatrefoil.alias $ {}
      :ns $ quote
        ns quatrefoil.alias $ :require
          quatrefoil.schema :refer $ Shape Component comp? shape?
      :defs $ {}
        |parametric $ quote
          defn parametric (props & children) (create-element :parametric props children)
        |line-segments $ quote
          defn line-segments (props & children) (create-element :line-segments props children)
        |mesh-line $ quote
          defn mesh-line (props & children) (create-element :mesh-line props children)
        |rect-area-light $ quote
          defn rect-area-light (props & children) (create-element :rect-area-light props children)
        |box $ quote
          defn box (props & children) (create-element :box props children)
        |line $ quote
          defn line (props & children) (create-element :line props children)
        |text $ quote
          defn text (props & children) (create-element :text props children)
        |tube $ quote
          defn tube (props & children) (create-element :tube props children)
        |flat-values $ quote
          defmacro flat-values (& points)
            &let
              chunk $ &list:concat & points
              quasiquote $ [] ~@chunk
        |create-element $ quote
          defn create-element (el-name props children)
            %{} Shape (:name el-name)
              :params $ -> props (dissoc :material) (dissoc :event) (dissoc :position) (dissoc :scale) (dissoc :rotation)
              :position $ :position props
              :scale $ :scale props
              :material $ :material props
              :rotation $ :rotation props
              :event $ or (:on props) (:event props)
              :children $ arrange-children children
        |point-light $ quote
          defn point-light (props & children) (create-element :point-light props children)
        |group $ quote
          defn group (props & children) (create-element :group props children)
        |scene $ quote
          defn scene (props & children) (create-element :scene props children)
        |shape $ quote
          defn shape (props & children) (create-element :shape props children)
        |torus $ quote
          defn torus (props & children) (create-element :torus props children)
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
        |directional-light $ quote
          defn directional-light (props & children) (create-element :directional-light props children)
        |spot-light $ quote
          defn spot-light (props & children) (create-element :spot-light props children)
        |ambient-light $ quote
          defn ambient-light (props & children) (create-element :ambient-light props children)
        |sphere $ quote
          defn sphere (props & children) (create-element :sphere props children)
        |spline $ quote
          defn spline (props & children) (create-element :spline props children)
        |buffer-object $ quote
          defn buffer-object (props & children) (create-element :buffer-object props children)
        |plane-reflector $ quote
          defn plane-reflector (props & children) (create-element :plane-reflector props children)
        |perspective-camera $ quote
          defn perspective-camera (props & children) (create-element :perspective-camera props children)
    |quatrefoil.app.comp.quat-tree $ {}
      :ns $ quote
        ns quatrefoil.app.comp.quat-tree $ :require
          quatrefoil.alias :refer $ group box sphere text line tube ambient-light point-light
          quatrefoil.core :refer $ defcomp
          quatrefoil.math :refer $ q* &q* v-scale q+ &q+ &q- q-length
          quatrefoil.app.materials :refer $ cover-line
      :defs $ {}
        |leaf-material $ quote
          def leaf-material $ {} (:kind :mesh-standard) (:color 0x66cc55) (:opacity 0.5) (:transparent true)
        |pick-color $ quote
          defn pick-color (name)
            case-default name 0xffffff (:a 0xbbaaff) (:b 0x88bbff) (:c 0x77ccaa)
        |generate-lines $ quote
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
        |transformers $ quote
          def transformers $ []
            {} (:name :a)
              :vector $ [] 0.3 0.1 0.1 0.7
            {} (:name :b)
              :vector $ [] 0.2 -0.3 -0.33 0.7
            {} (:name :c)
              :vector $ [] -0.44 0.12 0.33 0.6
        |tube-material $ quote
          def tube-material $ {} (:kind :mesh-standard) (:color 0xcccc77) (:opacity 1) (:transparent true)
        |straight-fn $ quote
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
        |comp-quat-tree $ quote
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
    |quatrefoil.dsl.object3d-dom $ {}
      :ns $ quote
        ns quatrefoil.dsl.object3d-dom $ :require
          quatrefoil.util.core :refer $ purify-tree collect-children find-element scale-zero
          "\"three" :as THREE
          "\"three/examples/jsm/geometries/TextGeometry" :refer $ TextGeometry
          quatrefoil.globals :refer $ *global-renderer *global-camera *global-scene *global-tree *proxied-dispatch
          "\"@quatrefoil/utils" :refer $ make-tube-curve
          "\"three/examples/jsm/helpers/RectAreaLightHelper" :refer $ RectAreaLightHelper
          "\"three/examples/jsm/objects/Reflector" :refer $ Reflector
          "\"three/examples/jsm/loaders/FontLoader" :refer $ Font
          "\"three/examples/jsm/geometries/ParametricGeometry" :refer $ ParametricGeometry
          "\"@quatrefoil/meshline" :refer $ MeshLine MeshLineMaterial MeshLineRaycast
      :defs $ {}
        |create-line-element $ quote
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
        |create-shape $ quote
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
                do (js/console.warn "|Unknown element" element) (new js/Object3D)
                :scene @*global-scene
                :group $ create-group-element params position rotation scale
                :box $ create-box-element params position rotation scale material event coord
                :sphere $ create-sphere-element params position rotation scale material event coord
                :point-light $ create-point-light params position
                :spot-light $ create-spot-light params position
                :directional-light $ create-directional-light params position
                :ambient-light $ create-ambient-light params position
                :rect-area-light $ create-rect-area-light params position rotation
                :perspective-camera $ create-perspective-camera params position
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
        |create-ambient-light $ quote
          defn create-ambient-light (params position)
            let
                color $ :color params
                intensity $ either (:intensity params) 1
                object3d $ new THREE/AmbientLight color intensity
              set-position! object3d position
              ; js/console.log |Light: object3d
              , object3d
        |create-spot-light $ quote
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
              set-position! object3d position
              js/console.log |Light: object3d
              , object3d
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
              set! (.-event object3d) event
              ; js/console.log |Sphere: object3d
              , object3d
        |create-text-element $ quote
          defn create-text-element (params position rotation scale material)
            let
                geometry $ new TextGeometry
                  or (:text params) |Quatrefoil
                  to-js-data $ assoc params :font font-resource
                object3d $ new THREE/Mesh geometry (create-material material)
              set-position! object3d position
              set-rotation! object3d rotation
              set-scale! object3d scale
              , object3d
        |create-group-element $ quote
          defn create-group-element (params position rotation scale)
            let
                object3d $ new THREE/Group
              set-position! object3d position
              set-rotation! object3d rotation
              set-scale! object3d scale
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
        |on-control-event $ quote
          defn on-control-event (move delta elapsed)
            if (some? @*focused-coord)
              let
                  coord @*focused-coord
                  element-tree @*global-tree
                  target-el $ find-element element-tree coord
                  maybe-handler $ -> target-el (get :event) (get :control)
                if (some? maybe-handler) (maybe-handler move delta elapsed @*proxied-dispatch) (;nil println "|Found no handler for" coord)
              println "\"no focused coord to control" @*focused-coord
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
                  let
                      coord $ -> maybe-target .-object .-coord
                      target-el $ find-element element-tree coord
                      maybe-handler $ -> target-el :event :click
                    if (some? coord)
                      do
                        if (some? maybe-handler) (maybe-handler event @*proxied-dispatch) (println "|no handler" coord)
                        reset! *focused-coord coord
                        ; println "\"focus to" coord
                      do (reset! *focused-coord nil) (println "\"lose focus")
                  do (reset! *focused-coord nil) (println "\"lose focus")
        |create-directional-light $ quote
          defn create-directional-light (params position)
            let
                color $ :color params
                intensity $ :intensity params
                object3d $ new THREE/DirectionalLight color intensity
              set! (.-castShadow object3d) true
              set-position! object3d position
              js/console.log "|directional light:" object3d
              , object3d
        |create-line-segments-element $ quote
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
        |set-scale! $ quote
          defn set-scale! (object scale)
            if (some? scale)
              let[] (x y z) scale $ .!set (.-scale object) (scale-zero x) (scale-zero y) (scale-zero z)
        |*focused-coord $ quote (defatom *focused-coord nil)
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
        |create-material $ quote
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
              set! (.-side m) THREE/DoubleSide
              , m
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
              set! (.-event object3d) event
              , object3d
        |set-position! $ quote
          defn set-position! (object position)
            if (some? position)
              let[] (x y z) position $ .!set (.-position object) x y z
        |font-resource $ quote
          def font-resource $ new Font
            js/JSON.parse $ load-file |assets/hind.json
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
        |create-parametric-element $ quote
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
        |create-mesh-line-element $ quote
          defn create-mesh-line-element (params position rotation scale material)
            let
                points $ &let
                  ps $ js-array
                  &doseq
                    p $ :points params
                    .!push ps $ new THREE/Vector3 & p
                  , ps
                geometry $ -> (new THREE/BufferGeometry) (.!setFromPoints points)
                line $ let
                    l $ new MeshLine
                  .!setGeometry l geometry
                  , l
                object3d $ new THREE/Mesh line (create-material material)
              set-position! object3d position
              set-rotation! object3d rotation
              set-scale! object3d scale
              set! (.-raycast object3d) MeshLineRaycast
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
        |create-spline-element $ quote
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
        |write-shape-path! $ quote
          defn write-shape-path! (s op)
            key-match op
                :move-to x y
                .!moveTo s x y
              (:line-to x y) (.!lineTo s x y)
              (:quadratic-curve-to x0 y0 x1 y1) (.!quadraticCurveTo s x0 y0 x1 y1)
              (:bezier-curve-to x0 y0 x1 y1 x2 y2) (.!bezierCurveTo s x0 y0 x1 y1 x2 y2)
              _ $ js/console.log "\"Unknown shape path" op
        |create-tube-element $ quote
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
        |build-tree $ quote
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
        |load-file $ quote
          defmacro load-file (filename) (read-file filename)
        |set-rotation! $ quote
          defn set-rotation! (object3d rotation)
            if (some? rotation)
              let[] (x y z) rotation $ .!set (.-rotation object3d) x y z
        |create-rect-area-light $ quote
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
    |quatrefoil.cursor $ {}
      :ns $ quote (ns quatrefoil.cursor)
      :defs $ {}
        |update-states $ quote
          defn update-states (store pair)
            let[] (cursor new-state) pair $ assoc-in store
              concat ([] :states) cursor $ [] :data
              , new-state
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
    |quatrefoil.comp.control $ {}
      :ns $ quote
        ns quatrefoil.comp.control $ :require
          quatrefoil.alias :refer $ group box sphere text line tube point-light
          quatrefoil.core :refer $ defcomp
          quatrefoil.math :refer $ q* &q* v-scale q+ &v+
          quatrefoil.app.materials :refer $ cover-line
          quatrefoil.core :refer $ to-viewer-axis
      :defs $ {}
        |comp-2d-control $ quote
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
        |comp-value-2d $ quote
          defcomp comp-value-2d (options on-change)
            let
                v $ :value options
                position $ :position options
                speed $ either (:speed options) 1
                color $ either (:color options) 0xaaaaff
                text-color $ either (:text-color options) color
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
                if (:show-text? options)
                  text $ {}
                    :position $ [] -2 2 0
                    :text $ let
                        prefix $ if (blank? label) "\"" (str label "\" ")
                      str prefix
                        .!toFixed (nth v 0) fract-len
                        , "\", " $ .!toFixed (nth v 1) fract-len
                    :material $ {} (:kind :mesh-lambert) (:color text-color) (:opacity 0.9) (:transparent true)
                    :size 2
                    :height 1
        |comp-value $ quote
          defcomp comp-value (options on-change)
            let
                value $ :value options
                speed $ or (:speed options) 1
                color $ either (:color options) 0xffffff
                text-color $ either (:text-color options) color
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
                if (:show-text? options)
                  text $ {}
                    :position $ [] -1.6 2 0
                    :text $ let
                        prefix $ if (blank? label) "\"" (str label "\" ")
                      str prefix $ .!toFixed value
                        either (:fract-length options) 2
                    :material $ {} (:kind :mesh-lambert) (:color text-color) (:opacity 0.9) (:transparent true)
                    :size 2
                    :height 0.5
        |comp-toggle $ quote
          defcomp comp-toggle (state cursor field position color)
            sphere $ {} (:radius 0.8) (:emissive 0xffffff) (:metalness 0.8) (:color 0x00ff00) (:emissiveIntensity 1) (:roughness 0) (:position position)
              :material $ {} (:kind :mesh-basic) (:color color) (:opacity 0.3) (:transparent true)
              :event $ {}
                :click $ fn (e d!)
                  d! cursor $ update state field not
        |comp-control $ quote
          defcomp comp-control (state cursor field position speed bound color)
            sphere $ {} (:radius 1) (:emissive 0xffffff) (:metalness 0.8) (:color 0x00ff00) (:emissiveIntensity 1) (:roughness 0) (:position position)
              :material $ {} (:kind :mesh-basic) (:color color) (:opacity 0.3) (:transparent true)
              :event $ {}
                :control $ fn (move delta elapse d!) (; println "\"delta" delta)
                  let
                      dx $ * speed elapse (nth delta 1)
                      w2 $ + dx (get state field)
                      up $ nth bound 1
                      low $ nth bound 0
                    d! cursor $ assoc state field
                      cond
                          > w2 up
                          , up
                        (< w2 low) low
                        true w2
        |comp-pin-point $ quote
          defcomp comp-pin-point (options on-change)
            let
                position $ or (:position options) ([] 0 0 0)
                speed $ or (:speed options) 1
                text-color $ either (:text-color options) 0xaaaaff
              group
                {} $ :position position
                sphere $ {} (:emissive 0xffffff) (:metalness 0.8) (:emissiveIntensity 1) (:roughness 0) (:position position)
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
                if-let
                  label $ :label options
                  text $ {}
                    :position $ [] -0.6 2 0
                    :text $ str label
                    :material $ {} (:kind :mesh-lambert) (:color text-color) (:opacity 0.9) (:transparent true)
                    :size 2
                    :height 0.5
    |quatrefoil.app.comp.container $ {}
      :ns $ quote
        ns quatrefoil.app.comp.container $ :require
          quatrefoil.alias :refer $ group box sphere point-light ambient-light perspective-camera scene text
          quatrefoil.core :refer $ defcomp >> hclx
          quatrefoil.app.comp.todolist :refer $ comp-todolist
          quatrefoil.app.comp.portal :refer $ comp-portal
          quatrefoil.app.comp.lines :refer $ comp-lines comp-fly-city
          quatrefoil.app.comp.shapes :refer $ comp-shapes comp-quilling
          quatrefoil.app.comp.triflorum :refer $ comp-triflorum
          quatrefoil.app.comp.mirror :refer $ comp-mirror
          quatrefoil.app.comp.quat-tree :refer $ comp-quat-tree
          quatrefoil.app.comp.control :refer $ comp-control-demo
      :defs $ {}
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
                  :far 1000
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
                  :mirror $ comp-mirror (>> states :mirror)
                  :fly $ comp-fly-city (>> states :fly)
                  :quat-tree $ comp-quat-tree
                  :quilling $ comp-quilling
                  :control $ comp-control-demo (>> states :control)
                if (not= tab :portal)
                  comp-back $ fn (d!)
                    d! cursor $ assoc state :tab :portal
                ambient-light $ {} (:color 0x666666)
                ; point-light $ {} (:color 0xffffff) (:intensity 1.4) (:distance 200)
                  :position $ [] 20 40 50
                ; point-light $ {} (:color 0xffffff) (:intensity 2) (:distance 200)
                  :position $ [] 0 60 0
        |comp-back $ quote
          defcomp comp-back (on-back)
            box
              {} (:width 16) (:height 4) (:depth 6)
                :position $ [] 60 30 0
                :material $ {} (:kind :mesh-lambert) (:color 0x808080) (:opacity 0.6)
                :on $ {}
                  :click $ fn (e d!) (on-back d!)
              text $ {} (:text |Back) (:size 4) (:height 2)
                :position $ [] 0 0 10
                :material $ {} (:kind :mesh-lambert) (:color 0xffcccc)
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
            sphere $ {} (:radius 8)
              :position $ [] 30 0 0
              :material $ {} (:kind :mesh-lambert) (:opacity 0.6)
                :color $ hclx 160 80 70
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
            ; point-light $ {} (:color 0xffff55) (:intensity 2) (:distance 200)
              :position $ [] -10 20 0
            point-light $ {} (:color 0xffffff) (:intensity 2) (:distance 200)
              :position $ [] -10 20 0
    |quatrefoil.schema $ {}
      :ns $ quote (ns quatrefoil.schema)
      :defs $ {}
        |Shape $ quote (defrecord Shape :name :params :position :scale :rotation :material :event :children)
        |comp? $ quote
          defn comp? (x)
            and (record? x) (.matches? Component x)
        |Component $ quote (defrecord Component :name :tree)
        |shape? $ quote
          defn shape? (x)
            and (record? x) (.matches? Shape x)
    |quatrefoil.app.comp.mirror $ {}
      :ns $ quote
        ns quatrefoil.app.comp.mirror $ :require
          quatrefoil.alias :refer $ group box sphere shape text line spline tube plane-reflector point-light
          quatrefoil.core :refer $ defcomp
          quatrefoil.math :refer $ v-scale rand-around
          "\"@calcit/std" :refer $ rand
      :defs $ {}
        |heart-path $ quote
          def heart-path $ [][] (:move-to 25 25) (:bezier-curve-to 25 25 20 50 0 50) (:bezier-curve-to -30 50 -30 15 -30 15) (:bezier-curve-to -30 -5 -10 -27 25 -45) (:bezier-curve-to 60 -22 80 -5 80 15) (:bezier-curve-to 80 15 80 50 50 50) (:bezier-curve-to 35 50 25 25 25 25)
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
    |quatrefoil.app.comp.portal $ {}
      :ns $ quote
        ns quatrefoil.app.comp.portal $ :require
          quatrefoil.alias :refer $ group box sphere text ambient-light point-light
          quatrefoil.core :refer $ defcomp hslx
      :defs $ {}
        |comp-tab $ quote
          defcomp comp-tab (k title position on-change)
            box
              {} (:width 16) (:height 4) (:depth 6) (:position position)
                :material $ {} (:kind :mesh-lambert)
                  :color $ hslx 60 43 65
                  :opacity 0.6
                  :transparent true
                :on $ {}
                  :click $ fn (e d!) (on-change k d!)
              text $ {} (:text title) (:size 4) (:height 1)
                :position $ [] 0 0 4
                :material $ {} (:kind :mesh-lambert) (:color 0xffcccc) (:opacity 0.9) (:transparent true)
        |comp-portal $ quote
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
              point-light $ {} (:color 0xffffff) (:intensity 1.4) (:distance 200)
                :position $ [] 20 40 50
    |quatrefoil.app.comp.shapes $ {}
      :ns $ quote
        ns quatrefoil.app.comp.shapes $ :require
          quatrefoil.alias :refer $ group box sphere point-light perspective-camera scene text torus shape rect-area-light polyhedron plane-reflector parametric buffer-object flat-values ambient-light directional-light spot-light
          quatrefoil.core :refer $ defcomp
          "\"three" :as THREE
      :defs $ {}
        |box-material $ quote
          def box-material $ {} (:kind :mesh-lambert) (:color 0x808080) (:opacity 0.6)
        |comp-quilling $ quote
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
        |paper-material $ quote
          def paper-material $ {} (:kind :mesh-standard) (:roughness 0.99) (; :emissive 0x6611ee) (:metalness 0.02) (:transparent false) (:color 0x6666ff)
        |bubble-material $ quote
          def bubble-material $ {} (:kind :mesh-basic) (:color 0xffffff) (:opacity 1) (:transparent true)
        |comp-bubble $ quote
          defn comp-bubble (position)
            group ({})
              sphere $ {} (:radius 1) (:emissive 0xffffff) (:metalness 0.8) (:color 0xffffff) (:emissiveIntensity 1) (:roughness 0) (:position position) (:material bubble-material)
              point-light $ {} (:color 0xffffff) (:intensity 2) (:distance 400) (:position position)
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
        |paper-fn $ quote
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
        |wave-fn $ quote
          defn wave-fn (u v data)
            [] (* 8 u)
              +
                * 1 $ sin
                  + (* 5 &PI v) (* 8 &PI u)
                * 1 $ cos
                  + (* 10 &PI v) (* 3 &PI u)
              * 8 v
    |quatrefoil.dsl.patch $ {}
      :ns $ quote
        ns quatrefoil.dsl.patch $ :require
          [] quatrefoil.dsl.object3d-dom :refer $ [] build-tree set-position! set-rotation! set-scale! create-material
          [] quatrefoil.util.core :refer $ [] reach-object3d scale-zero
          quatrefoil.globals :refer $ *global-scene
          "\"three" :as THREE
      :defs $ {}
        |add-element $ quote
          defn add-element (target coord op-data)
            if (empty? coord) (js/console.warn "|Cannot remove by empty coord!")
              let
                  parent $ reach-object3d @*global-scene (butlast coord)
                .!addBy parent (last coord) (build-tree coord op-data)
        |apply-changes $ quote
          defn apply-changes (changes)
            ; println "\"changes" (count changes) changes
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
                  :replace-camera $ replace-camera target coord op-data
                  :change-position $ set-position! target
                    either op-data $ [] 0 0 0
                  :change-rotation $ set-rotation! target
                    either op-data $ [] 0 0 0
                  :change-scale $ set-scale! target
                    either op-data $ [] 1 1 1
        |update-material $ quote
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
              set! (.-needsUpdate material) true
        |replace-element $ quote
          defn replace-element (target coord op-data)
            if (empty? coord) (js/console.warn "|Cannot replace with empty coord!")
              let
                  parent $ reach-object3d @*global-scene (butlast coord)
                .!replaceBy parent (last coord) (build-tree coord op-data)
        |remove-material $ quote
          defn remove-material (target coord op-data)
            let
                material $ .-material target
              &doseq (entry op-data)
                case-default entry (println "|Unknown material prop:" op-data)
                  :opacity $ set! (.-opacity material) 0.9
                  :transparent $ set! (.-transparent material) 1
        |replace-material $ quote
          defn replace-material (target coord op-data)
            set! (.-material target) (create-material op-data)
        |remove-element $ quote
          defn remove-element (target coord)
            if (empty? coord) (js/console.warn "|Cannot remove by empty coord!")
              let
                  parent $ reach-object3d @*global-scene (butlast coord)
                .!removeBy parent $ last coord
        |remove-children $ quote
          defn remove-children (target coord op-data)
            &doseq (child-key op-data) (.!removeBy target child-key)
        |replace-camera $ quote
          defn replace-camera (target coord op-data) (; "\"make sure that camera is stable")
            let
                params $ :params op-data
                fov $ :fov params
                aspect $ :aspect params
                near $ :near params
                far $ :far params
              if
                not= fov $ .-fov target
                set! (.-fov target) fov
              if
                not= near $ .-near target
                set! (.-near target) fov
              if
                not= aspect $ .-aspect target
                set! (.-aspect target) fov
              if
                not= far $ .-far target
                set! (.-far target) fov
        |add-children $ quote
          defn add-children (target coord op-data)
            &doseq (entry op-data)
              let-sugar
                    [] k tree
                    , entry
                .!addBy target k $ build-tree (conj coord k) tree
    |quatrefoil.util.core $ {}
      :ns $ quote
        ns quatrefoil.util.core $ :require
          quatrefoil.schema :refer $ Component Shape comp? shape?
      :defs $ {}
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
        |scale-zero $ quote
          defn scale-zero (x)
            if (&= 0 x) 0.01 x
        |reach-object3d $ quote
          defn reach-object3d (object3d coord)
            if (empty? coord) object3d $ let
                cursor $ first coord
              recur (.!reachBy object3d cursor) (rest coord)
        |purify-tree $ quote
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
        |find-element $ quote
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
        |collect-children $ quote
          defn collect-children (element collect!)
            .!forEach (.-children element)
              fn (child idx _) (; js/console.log |Child: child) (collect! child)
                if
                  some? $ .-children child
                  collect-children child collect!
    |quatrefoil.dsl.diff $ {}
      :ns $ quote
        ns quatrefoil.dsl.diff $ :require
          quatrefoil.util.core :refer $ purify-tree
          quatrefoil.schema :refer $ comp? shape?
      :defs $ {}
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
        |select-keys $ quote
          defn select-keys (m xs)
            foldl ({})
              fn (acc x)
                assoc acc x $ &get m x
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
                if
                  = (:name tree) :perspective-camera
                  collect! $ [] coord :replace-camera (purify-tree tree)
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
    |quatrefoil.app.comp.todolist $ {}
      :ns $ quote
        ns quatrefoil.app.comp.todolist $ :require
          quatrefoil.alias :refer $ group box sphere point-light perspective-camera scene text
          quatrefoil.core :refer $ defcomp
          pointed-prompt.core :refer $ prompt-at!
      :defs $ {}
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
                      [] (:id task)
                        prompt-at!
                          [] (.-pageX event) (.-pageY event)
                          {} $ :initial (:text task)
                          fn (text)
                            dispatch! :edit-task $ [] (:id task) text
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
        |comp-todolist $ quote
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
