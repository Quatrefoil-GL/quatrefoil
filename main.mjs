
import { main_$x_ } from "./js-out/quatrefoil.app.main.mjs"

main_$x_()

if (import.meta.hot) {
  import.meta.hot.accept('./js-out/quatrefoil.app.main.mjs', (main) => {
    main.reload_$x_()
  })
}
