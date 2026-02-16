import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

PanelWindow {
  id: pokemon

  property var imageRadius: 12
  property var pkmns: ["./assets/serperior.png", "./assets/whimsicott.png", "./assets/mismagius.png"]

  color: "#00000000"
  implicitHeight: 600
  implicitWidth: 120
  aboveWindows: false

  anchors {
    top: true
    left: true
  }

  ColumnLayout {
    spacing: 8
    x: 16
    y: 16

    Repeater {
      model: pkmns

      Rectangle {
        property var iconSize: 80
        property var bgColor: "#11111b"
        required property string modelData


        width: iconSize
        height: iconSize
        color: bgColor
        radius: imageRadius

        Image {
          source: modelData
          width: iconSize
          height: iconSize
        }
      }
    }
  }
}
