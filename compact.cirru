
{} (:package |quatrefoil)
  :configs $ {} (:init-fn |quatrefoil.main/main!) (:reload-fn |quatrefoil.main/reload!) (:modules nil) (:version nil)
  :files $ {}
    |quatrefoil.main $ {}
      :ns $ quote
        ns quatrefoil.main $ :require
          [] "\"./alter-object3d" :refer $ inject_bang
          [] quatrefoil.core :refer $ [] render-canvas! tree-ref clear-cache! instant-variation-ref write-instants!
          [] quatrefoil.comp.canvas :refer $ [] comp-canvas
          [] quatrefoil.dsl.object3d-dom :refer $ [] camera-ref global-scene on-canvas-click ref-dirty-call!
          [] quatrefoil.updater.core :refer $ [] updater
          [] "\"three" :as THREE
      :defs $ {}
        |dispatch! $ quote
          defn dispatch! (op op-data)
            let
                store $ updater @store-ref op op-data
              .log js/console |Dispatch: op op-data store
              reset! store-ref store
        |main! $ quote
          defn main! () (load-console-formatter!) (inject_bang)
            let
                canvas-el $ js/document.querySelector |canvas
              reset! renderer-ref $ new THREE/WebGLRenderer
                &let
                  options $ to-js-data
                    {} (:canvas nil) (:antialias true)
                  set! (.-canvas options) canvas-el
                  , options
              .setPixelRatio @renderer-ref $ either js/window.devicePixelRatio 1
              .addEventListener canvas-el |click $ fn (event) (on-canvas-click event dispatch! tree-ref)
            .setSize @renderer-ref js/window.innerWidth js/window.innerHeight
            render-canvas-app!
            add-watch store-ref :changes $ fn (store prev) (render-canvas-app!)
            add-watch states-ref :changes $ fn (store prev) (render-canvas-app!)
            println "|App started!"
        |instants-ref $ quote
          defatom instants-ref $ {}
        |renderer-ref $ quote (defatom renderer-ref nil)
        |render-canvas-app! $ quote
          defn render-canvas-app! ()
            if (some? @ref-task)
              do (js/clearTimeout @ref-task) (reset! ref-task nil)
            ; println "|Render app:" $ pr-str @instants-ref
            render-canvas! (comp-canvas @store-ref) states-ref @instants-ref global-scene
            .render @renderer-ref global-scene @camera-ref
            js/console.log "\"app:" global-scene
        |store-ref $ quote
          defatom store-ref $ {}
            :tasks $ {}
              100 $ {} (:id 100) (:text "|Initial task") (:done? false)
        |reload! $ quote
          defn reload! () (clear-cache!) (render-canvas-app!) (println "|Code updated.")
        |states-ref $ quote
          defatom states-ref $ {}
        |ref-task $ quote (defatom ref-task nil)
      :proc $ quote ()
    |quatrefoil.comp.fade-in-out $ {}
      :ns $ quote
        ns quatrefoil.comp.fade-in-out $ :require
          [] quatrefoil.dsl.alias :refer $ [] create-comp group box sphere text
      :defs $ {}
        |on-update $ quote
          defn on-update (instant old-args args old-state state) instant
        |on-unmount $ quote
          defn on-unmount (instant)
            {} (:presence 1000) (:presence-v -1)
        |on-tick $ quote
          defn on-tick (instant elapsed)
            let
                next-presence $ + (:presence instant)
                  * elapsed $ :presence-v instant
              .log js/console "|Next presence:" next-presence elapsed $ :presence-v instant
              if (<= next-presence 0)
                {} (:presence 0) (:presence-v 0)
                if (>= next-presence 1000)
                  {} (:presence 1000) (:presence-v 0)
                  assoc instant :presence next-presence
        |remove? $ quote
          defn remove? (instant)
            <= (:presence instant) 0
        |comp-fade-in-out $ quote
          def comp-fade-in-out $ create-comp :fade-in-out
            {} (:init-instant init-instant) (:on-update on-update) (:on-unmount on-unmount) (:on-tick on-tick) (:remove? remove?)
            fn (inside)
              fn (state mutate! instant) (println |Fading: instant)
                let
                    ratio $ either
                      / (get instant :presence) 1000
                      , 1
                  group
                    {} $ :params
                      {} (:scale-x ratio) (:scale-y ratio) (:scale-z ratio)
                    , inside
        |init-instant $ quote
          defn init-instant (args state at-place?)
            {} (:presence 0) (:presence-v 1)
      :proc $ quote ()
    |quatrefoil.comp.portal $ {}
      :ns $ quote
        ns quatrefoil.comp.portal $ :require
          [] quatrefoil.dsl.alias :refer $ [] create-comp group box sphere text
      :defs $ {}
        |comp-portal $ quote
          def comp-portal $ create-comp :portal ({})
            fn (mutate-view!)
              fn (state mutate!)
                group ({})
                  box
                    {}
                      :params $ {} (:width 16) (:height 4) (:depth 6) (:x -40) (:y 30) (:z 0)
                      :material $ {} (:kind :mesh-lambert) (:color 0xccc80) (:opacity 0.6)
                      :event $ {}
                        :click $ fn (event dispatch!) (.log js/console |Click: event) (mutate-view! :todolist)
                    text $ {}
                      :params $ {} (:text |Todolist) (:size 4) (:height 2) (:z 40) (:x 0)
                      :material $ {} (:kind :mesh-lambert) (:color 0xffcccc)
                  box
                    {}
                      :params $ {} (:width 16) (:height 4) (:depth 6) (:x 0) (:y 30)
                      :material $ {} (:kind :mesh-lambert) (:color 0xccc80) (:opacity 0.6)
                      :event $ {}
                        :click $ fn (event dispatch!) (.log js/console |Click: event) (mutate-view! :demo)
                    text $ {}
                      :params $ {} (:text |Demo) (:size 4) (:height 2) (:z 40) (:x 0)
                      :material $ {} (:kind :mesh-lambert) (:color 0xffcccc)
      :proc $ quote ()
    |quatrefoil.dsl.render $ {}
      :ns $ quote
        ns quatrefoil.dsl.render $ :require
          [] quatrefoil.util.core :refer $ [] comp? shape? =seq? =component?
          [] clojure.set :as set
      :defs $ {}
        |render-component $ quote
          defn render-component (markup prev-markup coord states instants new? packed) (; .log js/console "|Component states:" states) (; println |Instants: coord instants)
            if
              and (nil? markup) (nil? prev-markup)
              do (.warn js/console "|Calling render-component with nil!") nil
              let
                  elapsed $ :elapsed packed
                  base-tree $ or markup prev-markup
                  comp-name $ :name base-tree
                  args $ :args base-tree
                  base-coord $ conj coord (:name base-tree)
                  render $ :render base-tree
                  hooks $ :hooks base-tree
                  init-instant $ :init-instant hooks
                  on-tick $ or (:on-tick hooks) defaut-tick
                  on-unmount $ :on-unmount hooks
                  on-update $ :on-update hooks
                  remove? $ :remove? hooks
                  state $ get-state states (:init-state hooks) args
                  at-place? $ and (not new?) (nil? prev-markup)
                  instant $ get-instant instants init-instant args state at-place? (some? prev-markup)
                  build-mutate $ :build-mutate packed
                  mutate! $ fn (& state-args)
                    let
                        update-state $ :update-state hooks
                        new-state $ apply update-state (prepend state-args state)
                      .log js/console "|During mutate:" base-coord state new-state states
                      build-mutate base-coord new-state
                  queue! $ :queue! packed
                  curry-render $ apply render args
                  cached-tree $ if (some? prev-markup) (:tree prev-markup) nil
                  render-result $ fn (the-instant removing?)
                    let
                        tree-markup $ curry-render state mutate!
                        tree $ render-markup tree-markup cached-tree base-coord base-coord states instants true packed
                      merge base-tree $ {} (:tree tree)
                        :states $ if (some? states) (assoc states 'data state) nil
                        :instants $ if (some? instants) (assoc instants :data the-instant) nil
                        :removing? removing?
                cond
                    and (some? markup) (nil? prev-markup)
                    do
                      if (some? instant) (queue! base-coord instant :init)
                      render-result instant false
                  (and (some? markup) (some? prev-markup) (=component? prev-markup markup))
                    do (; .log js/console "|Reusing component:" coord) prev-markup
                  (and (some? markup) (some? prev-markup))
                    if
                      and (fn? on-update) (updated? markup prev-markup)
                      let
                          new-instant $ on-update instant (:args prev-markup) args (:states prev-markup) state
                        if (not= instant new-instant)
                          do (queue! base-coord new-instant :update) (render-result new-instant false)
                          let
                              ticked-instant $ on-tick instant elapsed
                            if (not= instant ticked-instant) (queue! base-coord ticked-instant :tick-on-update)
                            render-result ticked-instant false
                      let
                          new-instant $ on-tick instant elapsed
                        if (not= instant new-instant) (queue! base-coord new-instant :tick)
                        render-result new-instant false
                  (and (nil? markup) (some? prev-markup) (:removing? prev-markup))
                    let
                        new-instant $ on-tick instant elapsed
                      if (remove? new-instant) nil $ do (queue! base-coord new-instant :removing) (render-result new-instant true)
                  (and (nil? markup) (some? prev-markup) (not (:removing? prev-markup)))
                    if (fn? on-unmount)
                      let
                          new-instant $ on-unmount instant
                        queue! base-coord new-instant :unmount
                        render-result new-instant true
                      , nil
                  true $ do (.warn js/console "|Unexpected case:" markup prev-markup)
        |render-shape $ quote
          defn render-shape (markup prev-markup coord comp-coord states instants new? packed)
            let
                prev-children $ either (get prev-markup :children) ({})
                children $ either (:children markup) ({})
                all-keys $ union (keys prev-children) (keys children)
              ; .log js/console |Shape: markup
              -> markup (assoc :coord coord)
                assoc :children $ -> all-keys
                  map $ fn (k)
                    [] k $ let
                        child $ get children k
                        prev-child $ get prev-children k
                      if
                        and (nil? child) (nil? prev-child)
                        , nil $ render-markup child prev-child (conj coord k) comp-coord (get states k) (get instants k) new? packed
                  filter $ fn (entry) (; .log js/console "|Rendering child:" entry)
                    some? $ last entry
                  pairs-map
        |get-instant $ quote
          defn get-instant (instants init-instant args state at-place? has-prev?)
            if (nil? instants) nil $ if
              and has-prev? $ contains? instants 'data
              get instants 'data
              if (fn? init-instant) (init-instant args state at-place?) nil
        |updated? $ quote
          defn updated? (markup prev-tree)
            and
              not $ identical? (:args markup) (:args prev-tree)
              not $ identical? (:states markup) (:states prev-tree)
        |defaut-tick $ quote
          defn defaut-tick (instant elapsed) instant
        |render-markup $ quote
          defn render-markup (markup prev-markup coord comp-coord states instants new? packed)
            cond
                and (nil? markup) (nil? prev-markup)
                , nil
              (and (comp? markup) (or (nil? prev-markup) (shape? prev-markup)))
                let
                    k $ :name markup
                    child-states $ get states k
                    child-instants $ get instants k
                  render-component markup nil coord child-states child-instants new? packed
              (and (comp? prev-markup) (nil? markup))
                let
                    k $ :name prev-markup
                    child-states $ get states k
                    child-instants $ get instants k
                  render-component nil prev-markup coord child-states child-instants new? packed
              (and (comp? prev-markup) (comp? markup) (= (:name prev-markup) (:name markup)))
                let
                    k $ :name markup
                    child-states $ get states k
                    child-instants $ get instants k
                  render-component markup prev-markup coord child-states child-instants new? packed
              (and (comp? prev-markup) (comp? markup) (not= (:name prev-markup) (:name markup)))
                let
                    k $ :name markup
                    child-states $ get states k
                    child-instants $ get instants k
                  render-component markup nil coord child-states child-instants new? packed
              (and (shape? markup) (or (nil? prev-markup) (comp? prev-markup)))
                render-shape markup nil coord comp-coord states instants new? packed
              (and (shape? markup) (shape? prev-markup))
                render-shape markup prev-markup coord comp-coord states instants new? packed
              (and (nil? markup) (shape? prev-markup))
                , nil
              :else $ do (.log js/console "|Unknown markup with" markup prev-markup) nil
        |get-state $ quote
          defn get-state (states init-state args)
            if (nil? states) nil $ if (contains? states 'data) (get states 'data)
              if (fn? init-state) (apply init-state args) nil
      :proc $ quote ()
    |quatrefoil.dsl.object3d-dom $ {}
      :ns $ quote
        ns quatrefoil.dsl.object3d-dom $ :require
          [] quatrefoil.util.core :refer $ [] purify-tree collect-children find-element scale-zero
          [] "\"three" :as THREE
      :defs $ {}
        |create-perspective-camera $ quote
          defn create-perspective-camera (params)
            let
                fov $ :fov params
                aspect $ :aspect params
                near $ :near params
                far $ :far params
                object3d $ new THREE/PerspectiveCamera fov aspect near far
              .set (.-position object3d) (:x params) (:y params) (:z params)
              reset! camera-ref object3d
              , object3d
        |create-element $ quote
          defn create-element (element)
            ; .log js/console |Element: element $ :coord element
            let
                params $ merge default-params (:params element)
                material $ either (:material element)
                  {} (:kind :mesh-basic) (:color 0xa0a0a0)
                event $ :event element
                coord $ :coord element
              case-default (:name element)
                do (.warn js/console "|Unknown element" element)
                  new $ .-Object3D js/THREE
                :scene global-scene
                :group $ create-group-element params
                :box $ create-box-element params material event coord
                :sphere $ create-sphere-element params material event coord
                :point-light $ create-point-light params
                :perspective-camera $ create-perspective-camera params
                :text $ create-text-element params material
        |virtual-tree-ref $ quote
          defatom virtual-tree-ref $ {}
        |create-sphere-element $ quote
          defn create-sphere-element (params material event comp-coord)
            let
                geometry $ new THREE/SphereGeometry
                  or (:radius params) 8
                  or (:width-segments params) 32
                  or (:height-segments params) 32
                object3d $ new THREE/Mesh geometry (create-material material)
              .set (.-position object3d) (:x params) (:y params) (:z params)
              .set (.-scale object3d)
                scale-zero $ :scale-x params
                scale-zero $ :scale-y params
                scale-zero $ :scale-y params
              set! (.-coord object3d) comp-coord
              ; .log js/console |Sphere: object3d
              , object3d
        |create-box-element $ quote
          defn create-box-element (params material event comp-coord)
            let
                geometry $ new THREE/BoxGeometry (:width params) (:height params) (:depth params)
                object3d $ new THREE/Mesh geometry (create-material material)
              .set (.-position object3d) (:x params) (:y params) (:z params)
              .set (.-scale object3d)
                scale-zero $ :scale-x params
                scale-zero $ :scale-y params
                scale-zero $ :scale-y params
              set! (.-coord object3d) comp-coord
              , object3d
        |font-ref $ quote
          def font-ref $ new THREE/Font
            js/JSON.parse $ load-file |assets/hind.json
        |create-material $ quote
          defn create-material (material)
            case-default (:kind material)
              do (.warn js/console "|Unknown material:" material)
                new THREE/LineBasicMaterial $ to-js-data (dissoc material :kind)
              :line-basic $ new THREE/LineBasicMaterial
                to-js-data $ dissoc material :kind
              :mesh-basic $ new THREE/MeshBasicMaterial
                to-js-data $ dissoc material :kind
              :mesh-lambert $ new THREE/MeshLambertMaterial
                to-js-data $ dissoc material :kind
        |default-params $ quote
          def default-params $ {} (:x 0) (:y 0) (:z 0) (:scale-x 1) (:scale-y 1) (:scale-z 1)
        |camera-ref $ quote (defatom camera-ref nil)
        |create-text-element $ quote
          defn create-text-element (params material)
            let
                geometry $ new THREE/TextGeometry
                  either (:text params) |Quatrefoil
                  to-js-data $ assoc params :font font-ref
                object3d $ new THREE/Mesh geometry (create-material material)
              .set (.-position object3d) (:x params) (:y params) (:z params)
              , object3d
        |load-file $ quote
          defmacro load-file (filename) (read-file filename)
        |global-scene $ quote
          def global-scene $ new THREE/Scene
        |on-canvas-click $ quote
          defn on-canvas-click (event dispatch! tree-ref)
            let
                mouse $ new THREE/Vector2
                raycaster $ new THREE/Raycaster
              set! (.-x mouse)
                dec $ * 2
                  / (.-clientX event) js/window.innerWidth
              set! (.-y mouse)
                - 1 $ * 2
                  / (.-clientY event) js/window.innerHeight
              .setFromCamera raycaster mouse @camera-ref
              let
                  intersects $ .intersectObjects raycaster
                    let
                        children $ to-js-data ([])
                        collect! $ fn (x) (.push children x)
                      collect-children global-scene collect!
                      , children
                  maybe-target $ aget intersects 0
                js/console.log intersects
                if (some? maybe-target)
                  let
                      coord $ -> maybe-target .-object .-coord
                      target-el $ find-element @tree-ref coord
                      maybe-handler $ -> target-el (get :event) (get :click)
                    if (some? maybe-handler) (maybe-handler event dispatch!) (println "|Found no handler for" coord)
        |build-tree $ quote
          defn build-tree (coord tree) (; js/console.log "\"build tree:" coord tree)
            let
                object3d $ create-element (assoc tree :children nil)
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
              swap! virtual-tree-ref assoc-in (conj coord 'data) virtual-element
              , object3d
        |create-point-light $ quote
          defn create-point-light (params)
            let
                color $ :color params
                intensity $ :intensity params
                distance $ :distance params
                object3d $ new THREE/PointLight color intensity distance
              .set (.-position object3d) (:x params) (:y params) (:z params)
              ; .log js/console |Light: object3d
              , object3d
        |create-group-element $ quote
          defn create-group-element (params)
            let
                object3d $ new THREE/Group
              .set (.-position object3d) (:x params) (:y params) (:z params)
              .set (.-scale object3d) (:scale-x params) (:scale-y params) (:scale-y params)
              , object3d
      :proc $ quote ()
    |quatrefoil.updater.core $ {}
      :ns $ quote (ns quatrefoil.updater.core)
      :defs $ {}
        |updater $ quote
          defn updater (store op op-data)
            case-default op store
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
    |quatrefoil.dsl.diff $ {}
      :ns $ quote
        ns quatrefoil.dsl.diff $ :require
          [] quatrefoil.util.core :refer $ [] comp? shape? purify-tree
      :defs $ {}
        |diff-params $ quote
          defn diff-params (prev-params params coord collect!)
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
              ; .log js/console "|Common keys to diff:" common-keys prev-children children
              &doseq (k common-keys) (; .log js/console "|Diffing children:" coord common-keys)
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
          defn diff-tree (prev-tree tree coord collect!) (; .log js/console |Diffing: coord prev-tree tree)
            cond
                comp? prev-tree
                recur (:tree prev-tree) tree coord collect!
              (comp? tree)
                recur prev-tree (:tree tree) coord collect!
              true $ if (some? prev-tree)
                if (some? tree)
                  if
                    not= (:name prev-tree) (:name tree)
                    collect! $ [] coord :replace-element (purify-tree tree)
                    do
                      diff-params (:params prev-tree) (:params tree) coord collect!
                      diff-material (:material prev-tree) (:material tree) coord collect!
                      diff-events (:event prev-tree) (:event tree) coord collect!
                      diff-children (:children prev-tree) (:children tree) coord collect!
                  collect! $ [] coord :remove-element
                if (some? tree)
                  collect! $ [] coord :add-element tree
                  , nil
        |select-keys $ quote
          defn select-keys (m xs)
            foldl ({})
              fn (acc x)
                assoc acc x $ &get m x
      :proc $ quote ()
    |quatrefoil.comp.back $ {}
      :ns $ quote
        ns quatrefoil.comp.back $ :require
          [] quatrefoil.dsl.alias :refer $ [] create-comp group box scene text
      :defs $ {}
        |comp-back $ quote
          def comp-back $ create-comp :back ({})
            fn (mutate-view!)
              fn (state mutate!)
                box
                  {}
                    :params $ {} (:width 16) (:height 4) (:depth 6) (:x 60) (:y 30)
                    :material $ {} (:kind :mesh-lambert) (:color 0x808080) (:opacity 0.6)
                    :event $ {}
                      :click $ fn (event dispatch!) (mutate-view! :portal)
                  text $ {}
                    :params $ {} (:text |Back) (:size 4) (:height 2) (:z 10)
                    :material $ {} (:kind :mesh-lambert) (:color 0xffcccc)
      :proc $ quote ()
    |quatrefoil.util.core $ {}
      :ns $ quote
        ns quatrefoil.util.core $ :require
          [] quatrefoil.types :refer $ [] Component Shape
      :defs $ {}
        |comp? $ quote
          defn comp? (x)
            and (record? x) (relevant-record? Component x)
        |scale-zero $ quote
          defn scale-zero (x)
            if (&= 0 x) 0.01 x
        |=component? $ quote
          defn =component? (prev-tree markup)
            let
                prev-args $ :args prev-tree
                prev-states $ :states prev-tree
                prev-instants $ :instants prev-tree
              ; println
                =seq? (:args markup) prev-args
                identical? (:states markup) prev-states
                identical? (:instants markup) prev-instants
              and
                =seq? (:args markup) prev-args
                identical? (:states markup) prev-states
                identical? (:instants markup) prev-instants
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
        |shape? $ quote
          defn shape? (x)
            and (record? x) (relevant-record? Shape x)
        |purify-tree $ quote
          defn purify-tree (tree)
            if (comp? tree)
              recur $ :tree tree
              update tree :children $ fn (children)
                -> children (to-pairs)
                  map $ fn (entry)
                    update entry 1 $ fn (child) (purify-tree child)
                  pairs-map
        |find-element $ quote
          defn find-element (tree comp-coord) (; .log js/console |Find... tree comp-coord)
            if (empty? comp-coord) tree $ let
                cursor $ first comp-coord
              if (comp? tree)
                if
                  = cursor $ :name tree
                  recur (:tree tree) (rest comp-coord)
                  , nil
                if
                  contains? (:children tree) cursor
                  recur
                    get-in tree $ [] :children cursor
                    rest comp-coord
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
    |quatrefoil.dsl.alias $ {}
      :ns $ quote
        ns quatrefoil.dsl.alias $ :require
          [] quatrefoil.types :refer $ [] Shape Component
          [] quatrefoil.util.core :refer $ [] comp? shape?
      :defs $ {}
        |point-light $ quote
          defn point-light (props & children) (create-element :point-light props children)
        |create-element $ quote
          defn create-element (el-name props children)
            %{} Shape (:name el-name)
              :params $ :params props
              :material $ :material props
              :event $ :event props
              :children $ arrange-children children
              :coord nil
        |perspective-camera $ quote
          defn perspective-camera (props & children) (create-element :perspective-camera props children)
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
                  -> cursor (to-pairs)
                    filter $ fn (entry)
                      some? $ last entry
                    pairs-map
                  -> children
                    map-indexed $ fn (idx p) ([] idx p)
                    filter $ fn (entry)
                      some? $ last entry
                    pairs-map
              ; .log js/console "|Handle children:" children result
              , result
        |camera $ quote
          defn camera (props & children) (create-element :camera props children)
        |create-comp $ quote
          defn create-comp (comp-name hooks render)
            fn (& args)
              %{} Component (:name comp-name) (:args args)
                :states $ {}
                :instants $ {}
                :render render
                :tree nil
                :hooks hooks
                :removing? false
        |box $ quote
          defn box (props & children) (create-element :box props children)
        |text $ quote
          defn text (props & children) (create-element :text props children)
        |line $ quote
          defn line (props & children) (create-element :line props children)
        |sphere $ quote
          defn sphere (props & children) (create-element :sphere props children)
        |scene $ quote
          defn scene (props & children) (create-element :scene props children)
      :proc $ quote ()
    |quatrefoil.dsl.patch $ {}
      :ns $ quote
        ns quatrefoil.dsl.patch $ :require
          [] quatrefoil.dsl.object3d-dom :refer $ [] global-scene build-tree
          [] quatrefoil.util.core :refer $ [] reach-object3d scale-zero
      :defs $ {}
        |add-element $ quote
          defn add-element (coord op-data)
            if (empty? coord) (.warn js/console "|Cannot add element with empty coord!")
              let
                  target $ reach-object3d global-scene (butlast coord)
                .addBy target (last coord) (build-tree coord op-data)
        |apply-changes $ quote
          defn apply-changes (changes)
            &doseq (change changes)
              let-sugar
                    [] coord op op-data
                    , change
                ; .log js/console |Change: op coord
                case-default op
                  do $ .log js/console "|Unknown op:" op
                  :add-material $ update-material coord op-data
                  :update-material $ update-material coord op-data
                  :remove-children $ remove-children coord op-data
                  :add-children $ add-children coord op-data
                  :update-params $ update-params coord op-data
                  :add-params $ update-params coord op-data
                  :add-element $ add-element coord op-data
                  :remove-element $ remove-element coord
                  :replace-element $ replace-element coord op-data
        |add-children $ quote
          defn add-children (coord op-data)
            let
                target $ reach-object3d global-scene coord
              &doseq (entry op-data)
                let-sugar
                      [] k tree
                      , entry
                  .addBy target k $ build-tree (conj coord k) tree
        |remove-element $ quote
          defn remove-element (coord)
            if (empty? coord) (.warn js/console "|Cannot remove by empty coord!")
              let
                  target $ reach-object3d global-scene (butlast coord)
                .removeBy target $ last coord
        |replace-element $ quote
          defn replace-element (coord op-data)
            if (empty? coord) (.warn js/console "|Cannot replace with empty coord!")
              let
                  target $ reach-object3d global-scene (butlast coord)
                .replaceBy target (last coord) (build-tree coord op-data)
        |update-material $ quote
          defn update-material (coord op-data) (println "|Update material" coord op-data)
            let
                target $ reach-object3d global-scene coord
              ; .log js/console target
              &doseq (entry op-data)
                let-sugar
                      [] param new-value
                      , entry
                  case-default param
                    do $ .log js/console "|Unknown param:" param
                    :color $ .set (-> target .-material .-color) new-value
        |remove-children $ quote
          defn remove-children (coord op-data)
            let
                target $ reach-object3d global-scene coord
              &doseq (child-key op-data) (.removeBy target child-key)
        |update-params $ quote
          defn update-params (coord op-data)
            let
                target $ reach-object3d global-scene coord
              &doseq (entry op-data)
                let-sugar
                      [] k v
                      , entry
                  case-default k
                    do $ .log js/console "|Unknown param change:" k v
                    :x $ .setX (.-position target) v
                    :y $ .setY (.-position target) v
                    :z $ .setZ (.-position target) v
                    :scale-x $ .setX (.-scale target) (scale-zero v)
                    :scale-y $ .setY (.-scale target) (scale-zero v)
                    :scale-z $ .setZ (.-scale target) (scale-zero v)
                    :radius $ set! (-> target .-geometry .-radius) v
      :proc $ quote ()
    |quatrefoil.types $ {}
      :ns $ quote (ns quatrefoil.types)
      :defs $ {}
        |Component $ quote (defrecord Component :name :args :states :instants :render :tree :hooks :removing?)
        |Shape $ quote (defrecord Shape :name :params :material :event :children :coord)
      :proc $ quote ()
    |quatrefoil.core $ {}
      :ns $ quote
        ns quatrefoil.core $ :require
          [] quatrefoil.dsl.render :refer $ [] render-component
          [] quatrefoil.dsl.diff :refer $ [] diff-tree
          [] quatrefoil.dsl.object3d-dom :refer $ [] build-tree
          [] quatrefoil.util.core :refer $ [] purify-tree
          [] quatrefoil.dsl.patch :refer $ [] apply-changes
      :defs $ {}
        |render-canvas! $ quote
          defn render-canvas! (markup states-ref instants scene) (; js/console.log "\"render" markup)
            let
                build-mutate $ fn (coord new-state) (println "|Mutate states:" new-state)
                  swap! states-ref assoc-in (conj coord 'data) new-state
                queue! $ fn (coord new-instant mark)
                  swap! instant-variation-ref conj $ [] coord new-instant mark
                now $ js/Date.now
                packed $ {} (:build-mutate build-mutate) (:queue! queue!)
                  :elapsed $ - now @timestamp-ref
                new-tree $ with-js-log
                  render-component markup @tree-cache-ref ([])
                    get @states-ref $ :name markup
                    get instants $ :name markup
                    , false packed
              reset! timestamp-ref now
              if (some? @tree-ref)
                let
                    collect! $ fn (x) (swap! *tmp-changes conj x)
                  reset! *tmp-changes $ []
                  diff-tree @tree-ref new-tree ([]) collect!
                  apply-changes @*tmp-changes
                build-tree ([]) (purify-tree new-tree)
              reset! tree-ref new-tree
              reset! tree-cache-ref new-tree
              ; .log js/console |Tree: new-tree
        |tree-cache-ref $ quote (defatom tree-cache-ref nil)
        |instant-variation-ref $ quote
          defatom instant-variation-ref $ []
        |clear-cache! $ quote
          defn clear-cache! () $ reset! tree-cache-ref nil
        |write-instants! $ quote
          defn write-instants! (instants-ref changes)
            &doseq (change changes)
              let-sugar
                    [] coord new-instant mark
                    , change
                swap! instants-ref assoc-in (conj coord 'data) new-instant
        |tree-ref $ quote (defatom tree-ref nil)
        |timestamp-ref $ quote
          defatom timestamp-ref $ js/Date.now
        |*tmp-changes $ quote
          defatom *tmp-changes $ []
      :proc $ quote ()
    |quatrefoil.comp.canvas $ {}
      :ns $ quote
        ns quatrefoil.comp.canvas $ :require
          [] quatrefoil.dsl.alias :refer $ [] create-comp group box sphere point-light perspective-camera scene text
          [] quatrefoil.comp.todolist :refer $ [] comp-todolist
          [] quatrefoil.comp.portal :refer $ [] comp-portal
          [] quatrefoil.comp.back :refer $ [] comp-back
          [] quatrefoil.comp.fade-in-out :refer $ [] comp-fade-in-out
      :defs $ {}
        |comp-canvas $ quote
          def comp-canvas $ create-comp :canvas
            {} (:init-state init-state) (:update-state update-state)
            fn (store)
              fn (state mutate!)
                scene ({})
                  case-default state (comp-portal mutate!)
                    :portal $ comp-portal mutate!
                    :todolist $ comp-todolist (:tasks store)
                    :demo $ comp-demo
                  if (not= state :portal) (comp-back mutate!)
                  point-light $ {}
                    :params $ {} (:color 0xffffff) (:x 20) (:y 40) (:z 100) (:intensity 2) (:distance 400)
                  perspective-camera $ {}
                    :params $ {} (:x 0) (:y 0) (:z 200) (:fov 45)
                      :aspect $ / js/window.innerWidth js/window.innerHeight
                      :near 0.1
                      :far 1000
        |comp-demo $ quote
          def comp-demo $ create-comp :demo
            {}
              :init-state $ fn (& args) 0
              :update-state $ fn (state x) (inc state)
            fn () $ fn (state mutate!)
              group ({})
                box $ {}
                  :params $ {} (:width 16) (:height 4) (:depth 6) (:x -40) (:y 0) (:z 0)
                  :material $ {} (:kind :mesh-lambert) (:color 0x808080) (:opacity 0.6)
                  :event $ {}
                    :click $ fn (event dispatch!) (.log js/console |Click: event) (dispatch! :demo nil) (mutate! "|Mutate demo")
                sphere $ {}
                  :params $ {} (:radius 8) (:x 10)
                  :material $ {} (:kind :mesh-lambert) (:opacity 0.6) (:color 0x9050c0)
                  :event $ {}
                    :click $ fn (event dispatch!) (.log js/console |Click: event) (dispatch! :canvas nil)
                group ({})
                  text $ {}
                    :params $ {} (:text |Quatrefoil) (:size 4) (:height 2) (:z 20) (:x -30)
                    :material $ {} (:kind :mesh-lambert) (:color 0xffcccc)
        |init-state $ quote
          defn init-state (& args) :portal
        |update-state $ quote
          defn update-state (state new-state) new-state
      :proc $ quote ()
    |quatrefoil.comp.todolist $ {}
      :ns $ quote
        ns quatrefoil.comp.todolist $ :require
          [] quatrefoil.dsl.alias :refer $ [] create-comp group box sphere point-light perspective-camera scene text
      :defs $ {}
        |comp-todolist $ quote
          def comp-todolist $ create-comp :todolist ({})
            fn (tasks)
              fn (state mutate!)
                group ({})
                  group
                    {} $ :params
                      {} (:y 40) (:x 0) (:z 0)
                    box $ {}
                      :params $ {} (:width 32) (:height 6) (:depth 1) (:opacity 0.5)
                      :material $ {} (:kind :mesh-lambert) (:color 0xffaaaa)
                      :event $ {}
                        :click $ fn (event dispatch!)
                          dispatch! :add-task $ js/prompt "|Task content?"
                  group
                    {} $ :params
                      {} (:y 30) (:x 0) (:z 0)
                    -> (vals tasks)
                      map-indexed $ fn (idx task)
                        [] (:id task) (comp-task task idx)
                      pairs-map
        |comp-task $ quote
          def comp-task $ create-comp :task ({})
            fn (task idx)
              fn (state mutate)
                group
                  {} $ :params
                    {} (:x 0)
                      :y $ * idx -8
                  sphere $ {}
                    :params $ {} (:radius 2) (:x -20)
                    :material $ {} (:kind :mesh-lambert) (:opacity 0.3)
                      :color $ if (:done? task) 0x905055 0x9050ff
                    :event $ {}
                      :click $ fn (event dispatch!)
                        dispatch! :toggle-task $ :id task
                  box
                    {}
                      :params $ {} (:width 32) (:height 4) (:depth 1) (:opacity 0.5)
                      :material $ {} (:kind :mesh-lambert) (:color 0xcccccc)
                      :event $ {}
                        :click $ fn (event dispatch!)
                          dispatch! :edit-task $ [] (:id task)
                            js/prompt "|New task:" $ :text task
                    text $ {}
                      :params $ {}
                        :text $ :text task
                        :size 3
                        :height 2
                      :material $ {} (:kind :mesh-lambert) (:color 0xffcccc)
                  sphere $ {}
                    :params $ {} (:radius 2) (:x 30)
                    :material $ {} (:kind :mesh-lambert) (:opacity 0.3) (:color 0xff5050)
                    :event $ {}
                      :click $ fn (event dispatch!)
                        dispatch! :delete-task $ :id task
      :proc $ quote ()
