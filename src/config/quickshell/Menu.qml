import Quickshell
import Quickshell.Io

PanelWindow {
  id: menu
  visible: false

  IpcHandler {
    target: "menu"

    function show() {
      menu.visible = true
    }
    function hide() {
      menu.visible = false
    }
    function toggle() {
      menu.visible = !menu.visible
    }
  }

  anchors {
    top: true
    right: true
  }
}
