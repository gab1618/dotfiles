import app from "ags/gtk4/app"
import scss from "./style.scss"
import { Hub } from "./src/widgets/hub"
import { setupAllTimeouts } from "./src/providers/timeouts"

app.start({
  css: scss,
  main() {
    setupAllTimeouts()
    app.hold()
    return Hub()
  },
})
