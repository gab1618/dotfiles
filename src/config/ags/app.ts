import app from "ags/gtk4/app"
import scss from "./style.scss"
import { Hub } from "./src/widgets/hub"

app.start({
  css: scss,
  main() {
    app.hold()
    return Hub()
  },
})
