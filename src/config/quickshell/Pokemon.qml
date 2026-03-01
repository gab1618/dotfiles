import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import Qt.labs.folderlistmodel
import qs.config

PanelWindow {
  id: root

  readonly property var hPadding: 16
  readonly property var vPadding: 16

  FolderListModel {
    id: folderModel
    folder: Qt.resolvedUrl("assets/pkmns")
    showDirs: false
  }
  property var imageRadius: 12
  property var iconSize: 80

  color: "#00000000"
  implicitHeight: content.implicitHeight + vPadding
  implicitWidth: content.implicitWidth + hPadding
  aboveWindows: false

  anchors {
    top: true
    left: true
  }

  ColumnLayout {
    id: content
    spacing: 8
    x: hPadding
    y: vPadding

    Repeater {
      model: folderModel
      delegate: sprite

      Rectangle {
        id: sprite

        width: iconSize
        height: iconSize
        color: Theme.colBg
        radius: imageRadius

        Image {
          source: filePath
          width: iconSize
          height: iconSize
        }
      }
    }
  }
}
