
{} (:package |quatrefoil)
  :configs $ {} (:init-fn |quatrefoil.app.main/main!) (:reload-fn |quatrefoil.app.main/reload!) (:modules nil) (:version nil)
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
              box
                {} (:width 16) (:height 4) (:depth 6) (:x -40) (:y 30) (:z 0)
                  :material $ {} (:kind :mesh-lambert) (:color 0xccc80) (:opacity 0.6)
                  :event $ {}
                    :click $ fn (e d!) (on-change :todolist d!)
                text $ {} (:text |Todolist) (:size 4) (:height 2) (:z 4) (:x 0)
                  :material $ {} (:kind :mesh-lambert) (:color 0xffcccc)
              box
                {} (:width 16) (:height 4) (:depth 6) (:x 0) (:y 30)
                  :material $ {} (:kind :mesh-lambert) (:color 0xccc80) (:opacity 0.6)
                  :event $ {}
                    :click $ fn (e d!) (on-change :demo d!)
                text $ {} (:text |Demo) (:size 4) (:height 2) (:z 4) (:x 0)
                  :material $ {} (:kind :mesh-lambert) (:color 0xffcccc)
      :proc $ quote ()
    |quatrefoil.alias $ {}
      :ns $ quote
        ns quatrefoil.alias $ :require
          quatrefoil.schema :refer $ Shape Component comp? shape?
      :defs $ {}
        |point-light $ quote
          defn point-light (props & children) (create-element :point-light props children)
        |create-element $ quote
          defn create-element (el-name props children)
            %{} Shape (:name el-name)
              :params $ -> props (dissoc :material) (dissoc :event)
              :material $ :material props
              :event $ :event props
              :children $ arrange-children children
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
                  , cursor
                    -> children
                      map-indexed $ fn (idx p) ([] idx p)
                      pairs-map
              ; .log js/console "|Handle children:" children result
              , result
        |camera $ quote
          defn camera (props & children) (create-element :camera props children)
        |box $ quote
          defn box (props & children) (create-element :box props children)
        |ambient-light $ quote
          defn ambient-light (props & children) (create-element :ambient-light props children)
        |text $ quote
          defn text (props & children) (create-element :text props children)
        |line $ quote
          defn line (props & children) (create-element :line props children)
        |sphere $ quote
          defn sphere (props & children) (create-element :sphere props children)
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
        |global-scene $ quote
          def global-scene $ new THREE/Scene
        |*proxied-dispatch $ quote (defatom *proxied-dispatch nil)
        |*viewer-angle $ quote
          defatom *viewer-angle $ &/ &PI 2
        |*viewer-y-shift $ quote (defatom *viewer-y-shift 0)
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
                {} (:y 40) (:x 0) (:z 0)
                box $ {} (:width 32) (:height 6) (:depth 1)
                  :material $ {} (:kind :mesh-lambert) (:color 0xffaaaa) (:opacity 0.5)
                  :event $ {}
                    :click $ fn (e d!)
                      d! :add-task $ js/prompt "|Task content?"
              group
                {} (:y 30) (:x 0) (:z 0)
                -> (vals tasks)
                  map-indexed $ fn (idx task)
                    [] (:id task) (comp-task task idx)
                  pairs-map
        |comp-task $ quote
          defcomp comp-task (task idx)
            group
              {} (:x 0)
                :y $ * idx -8
              sphere $ {} (:radius 2) (:x -20)
                :material $ {} (:kind :mesh-lambert) (:opacity 0.8) (:transparent true)
                  :color $ if (:done? task) 0x905055 0x9050ff
                :event $ {}
                  :click $ fn (event dispatch!)
                    dispatch! :toggle-task $ :id task
              box
                {} (:width 32) (:height 4) (:depth 1)
                  :material $ {} (:kind :mesh-lambert) (:color 0xcccccc) (:opacity 0.8) (:transparent true)
                  :event $ {}
                    :click $ fn (event dispatch!)
                      dispatch! :edit-task $ [] (:id task)
                        js/prompt "|New task:" $ :text task
                text $ {}
                  :text $ :text task
                  :size 3
                  :height 2
                  :material $ {} (:kind :mesh-lambert) (:color 0xffcccc) (:opacity 0.8) (:transparent true)
              sphere $ {} (:radius 2) (:x 30)
                :material $ {} (:kind :mesh-lambert) (:opacity 0.8) (:color 0xff5050) (:transparent true)
                :event $ {}
                  :click $ fn (event dispatch!)
                    dispatch! :delete-task $ :id task
      :proc $ quote ()
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
          [] quatrefoil.util.core :refer $ [] purify-tree collect-children find-element scale-zero
          [] "\"three" :as THREE
          quatrefoil.globals :refer $ *global-renderer *global-camera global-scene *global-tree *proxied-dispatch
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
              reset! *global-camera object3d
              , object3d
        |create-sphere-element $ quote
          defn create-sphere-element (params material event coord)
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
              set! (.-coord object3d) coord
              ; .log js/console |Sphere: object3d
              , object3d
        |create-box-element $ quote
          defn create-box-element (params material event coord)
            let
                geometry $ new THREE/BoxGeometry (:width params) (:height params) (:depth params)
                object3d $ new THREE/Mesh geometry (create-material material)
              .set (.-position object3d) (:x params) (:y params) (:z params)
              .set (.-scale object3d)
                scale-zero $ :scale-x params
                scale-zero $ :scale-y params
                scale-zero $ :scale-y params
              set! (.-coord object3d) coord
              , object3d
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
        |create-shape $ quote
          defn create-shape (element coord)
            ; .log js/console |Element: element $ :coord element
            let
                params $ merge default-params (:params element)
                material $ either (:material element)
                  {} (:kind :mesh-basic) (:color 0xa0a0a0)
                event $ :event element
              case-default (:name element)
                do (.warn js/console "|Unknown element" element) (new js/Object3D)
                :scene global-scene
                :group $ create-group-element params
                :box $ create-box-element params material event coord
                :sphere $ create-sphere-element params material event coord
                :point-light $ create-point-light params
                :ambient-light $ create-ambient-light params
                :perspective-camera $ create-perspective-camera params
                :text $ create-text-element params material
        |create-text-element $ quote
          defn create-text-element (params material)
            let
                geometry $ new THREE/TextGeometry
                  either (:text params) |Quatrefoil
                  to-js-data $ assoc params :font font-resource
                object3d $ new THREE/Mesh geometry (create-material material)
              .set (.-position object3d) (:x params) (:y params) (:z params)
              , object3d
        |load-file $ quote
          defmacro load-file (filename) (read-file filename)
        |create-ambient-light $ quote
          defn create-ambient-light (params)
            let
                color $ :color params
                intensity $ either (:intensity params) 1
                object3d $ new THREE/AmbientLight color intensity
              .set (.-position object3d) (:x params) (:y params) (:z params)
              ; .log js/console |Light: object3d
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
                      collect-children global-scene collect!
                      , children
                  maybe-target $ aget intersects 0
                ; js/console.log intersects
                if (some? maybe-target)
                  let
                      coord $ -> maybe-target .-object .-coord
                      target-el $ find-element element-tree coord
                      maybe-handler $ -> target-el (get :event) (get :click)
                    if (some? maybe-handler) (maybe-handler event @*proxied-dispatch) (println "|Found no handler for" coord)
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
    |quatrefoil.app.comp.container $ {}
      :ns $ quote
        ns quatrefoil.app.comp.container $ :require
          quatrefoil.alias :refer $ group box sphere point-light ambient-light perspective-camera scene text
          quatrefoil.core :refer $ defcomp
          quatrefoil.app.comp.todolist :refer $ comp-todolist
          quatrefoil.app.comp.portal :refer $ comp-portal
      :defs $ {}
        |comp-demo $ quote
          defcomp comp-demo () $ group ({})
            box $ {} (:width 16) (:height 4) (:depth 6) (:x -40) (:y 0) (:z 0)
              :material $ {} (:kind :mesh-lambert) (:color 0x808080) (:opacity 0.6)
              :event $ {}
                :click $ fn (e d!) (d! :demo nil)
            sphere $ {} (:radius 8) (:x 10)
              :material $ {} (:kind :mesh-lambert) (:opacity 0.6) (:color 0x9050c0)
              :event $ {}
                :click $ fn (e d!) (d! :canvas nil)
            group ({})
              text $ {} (:text |Quatrefoil) (:size 4) (:height 2) (:z 20) (:x -30)
                :material $ {} (:kind :mesh-lambert) (:color 0xffcccc)
        |comp-container $ quote
          defcomp comp-container (store)
            let
                states $ :states store
                cursor $ :cursor states
                state $ either (:data states)
                  {} $ :tab :portal
                tab $ :tab state
              scene ({})
                perspective-camera $ {} (:x 0) (:y 0) (:z 200) (:fov 45)
                  :aspect $ / js/window.innerWidth js/window.innerHeight
                  :near 0.1
                  :far 1000
                case-default tab
                  comp-portal $ fn (next d!)
                    d! cursor $ assoc state :tab next
                  :portal $ comp-portal
                    fn (next d!)
                      d! cursor $ assoc state :tab next
                  :todolist $ comp-todolist (:tasks store)
                  :demo $ comp-demo
                if (not= tab :portal)
                  comp-back $ fn (d!)
                    d! cursor $ assoc state :tab :portal
                ambient-light $ {} (:color 0x666666)
                point-light $ {} (:color 0xffffff) (:x 20) (:y 40) (:z 100) (:intensity 2) (:distance 200)
                point-light $ {} (:color 0xffffff) (:x 0) (:y 20) (:z 0) (:intensity 2) (:distance 40)
        |comp-back $ quote
          defcomp comp-back (on-back)
            box
              {} (:width 16) (:height 4) (:depth 6) (:x 60) (:y 30)
                :material $ {} (:kind :mesh-lambert) (:color 0x808080) (:opacity 0.6)
                :event $ {}
                  :click $ fn (e d!) (on-back d!)
              text $ {} (:text |Back) (:size 4) (:height 2) (:z 10)
                :material $ {} (:kind :mesh-lambert) (:color 0xffcccc)
      :proc $ quote ()
    |quatrefoil.dsl.diff $ {}
      :ns $ quote
        ns quatrefoil.dsl.diff $ :require
          quatrefoil.util.core :refer $ purify-tree
          quatrefoil.schema :refer $ comp? shape?
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
          defn diff-tree (prev-tree tree coord collect!) (; .log js/console |Diffing: coord prev-tree tree)
            cond
                = nil prev-tree tree
                &let nil nil
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
              (and (= :text (:name tree) (:name prev-tree)) (not= (get-in tree ([] :params :text)) (get-in prev-tree ([] :params :text))))
                collect! $ [] coord :replace-element (purify-tree tree)
              true $ do
                diff-params (:params prev-tree) (:params tree) coord collect!
                diff-material (:material prev-tree) (:material tree) coord collect!
                diff-events (:event prev-tree) (:event tree) coord collect!
                diff-children (:children prev-tree) (:children tree) coord collect!
        |select-keys $ quote
          defn select-keys (m xs)
            foldl ({})
              fn (acc x)
                assoc acc x $ &get m x
      :proc $ quote ()
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
        |Shape $ quote (defrecord Shape :name :params :material :event :children)
        |comp? $ quote
          defn comp? (x)
            and (record? x) (relevant-record? Component x)
        |shape? $ quote
          defn shape? (x)
            and (record? x) (relevant-record? Shape x)
      :proc $ quote ()
    |quatrefoil.dsl.patch $ {}
      :ns $ quote
        ns quatrefoil.dsl.patch $ :require
          [] quatrefoil.dsl.object3d-dom :refer $ [] build-tree
          [] quatrefoil.util.core :refer $ [] reach-object3d scale-zero
          quatrefoil.globals :refer $ global-scene
          "\"three" :as THREE
      :defs $ {}
        |add-element $ quote
          defn add-element (coord op-data)
            if (empty? coord) (.warn js/console "|Cannot add element with empty coord!")
              let
                  target $ reach-object3d global-scene (butlast coord)
                .addBy target (last coord) (build-tree coord op-data)
        |apply-changes $ quote
          defn apply-changes (changes)
            println "\"changes" (count changes) changes
            &doseq (change changes)
              let-sugar
                    [] coord op op-data
                    , change
                ; js/console.log |Change: op coord
                case-default op (js/console.log "|Unknown op:" op)
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
          defn update-material (coord op-data) (; println "|Update material" coord op-data)
            let
                target $ reach-object3d global-scene coord
                material $ .-material target
              ; .log js/console target
              &doseq
                entry $ to-pairs op-data
                let[] (param new-value) entry $ case-default param (js/console.log "|Unknown param:" param)
                  :color $ .set (.-color material) new-value
                  :opacity $ set! (.-opacity material) new-value
                  :transparent $ set! (.-transparent material) new-value
        |remove-children $ quote
          defn remove-children (coord op-data)
            let
                target $ reach-object3d global-scene coord
              &doseq (child-key op-data) (.removeBy target child-key)
        |update-params $ quote
          defn update-params (coord op-data)
            let
                target $ reach-object3d global-scene coord
              &doseq
                entry $ to-pairs op-data
                let-sugar
                      [] k v
                      , entry
                  case-default k
                    do $ js/console.error "|Unknown param change:" k v
                    :x $ .setX (.-position target) v
                    :y $ .setY (.-position target) v
                    :z $ .setZ (.-position target) v
                    :color $ set! (.-color target) (new THREE/Color v)
                    :scale-x $ .setX (.-scale target) (scale-zero v)
                    :scale-y $ .setY (.-scale target) (scale-zero v)
                    :scale-z $ .setZ (.-scale target) (scale-zero v)
                    :radius $ set! (-> target .-geometry .-radius) v
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
          quatrefoil.core :refer $ render-canvas! *global-tree clear-cache! init-renderer! handle-key-event
          quatrefoil.app.comp.container :refer $ comp-container
          quatrefoil.dsl.object3d-dom :refer $ on-canvas-click ref-dirty-call!
          quatrefoil.app.updater :refer $ [] updater
          "\"three" :as THREE
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
              init-renderer! canvas-el
            render-app!
            add-watch *store :changes $ fn (store prev) (render-app!)
            set! js/window.onkeydown handle-key-event
            println "|App started!"
        |reload! $ quote
          defn reload! () (clear-cache!) (remove-watch *store :changes)
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
          quatrefoil.globals :refer $ *global-tree *global-camera *global-renderer global-scene *proxied-dispatch *viewer-angle *viewer-y-shift
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
            .render @*global-renderer global-scene @*global-camera
        |tween-move-camera! $ quote
          defn tween-move-camera! (control)
            let
                camera @*global-camera
              key-match control
                  :shift shift
                  tween-call 20 5 $ fn (i)
                    do
                      swap! *viewer-y-shift &+ $ / shift 10
                      .lookAt camera $ new-lookat-point
                      .render @*global-renderer global-scene camera
                (:angle angle)
                  tween-call 20 5 $ fn (i)
                    swap! *viewer-angle &+ $ / angle 10
                    do
                      .lookAt camera $ new-lookat-point
                      .render @*global-renderer global-scene camera
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
                      .lookAt camera $ new-lookat-point
                      .render @*global-renderer global-scene camera
                _ $ println "\"unknown camera control:" control
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
          defn init-renderer! (canvas-el)
            reset! *global-renderer $ new THREE/WebGLRenderer
              &let
                options $ to-js-data
                  {} (:canvas nil) (:antialias true)
                set! (.-canvas options) canvas-el
                , options
            .setPixelRatio @*global-renderer $ either js/window.devicePixelRatio 1
            .setSize @*global-renderer js/window.innerWidth js/window.innerHeight
            .addEventListener canvas-el |click $ fn (event) (on-canvas-click event)
        |clear-cache! $ quote
          defn clear-cache! () $ ; "\"TODO memof..."
        |defcomp $ quote
          defmacro defcomp (comp-name params & body)
            assert "\"expected symbol of comp-name" $ symbol? comp-name
            assert "\"expected params in list" $ and (list? params) (every? params symbol?)
            if (empty? body)
              quasiquote $ echo "\"[Warn] invalid component body for" (quote ~comp-name) (quote ~params)
              quasiquote $ defn ~comp-name (~ params)
                %{} Component (:name ~comp-name)
                  :tree $ &let nil ~@body
      :proc $ quote ()
