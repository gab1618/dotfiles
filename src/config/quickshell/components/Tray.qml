import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import QtQuick.Controls
import QtQuick.Layouts

import qs.config

Rectangle {
  id: root
  color: Theme.colBg

  readonly property var vPadding: 4
  readonly property var hPadding: 12
  readonly property var iconSize: 16

  radius: 8

  RowLayout {
    id: row

    anchors.fill: parent
    anchors.topMargin: vPadding
    anchors.bottomMargin: vPadding
    anchors.leftMargin: hPadding
    anchors.rightMargin: hPadding

    spacing: 12

    Repeater {
      model: SystemTray.items

      Rectangle {
        id: trayItem
        required property SystemTrayItem modelData
        implicitWidth: root.iconSize
        implicitHeight: root.iconSize
        color: "#00000000"

        Image {
          source: modelData.icon
          width: root.iconSize
          height: root.iconSize
        }

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor

          onClicked: _ => {
            const pos = trayItem.mapToItem(null, 0, trayItem.height)
            modelData.display(bar, pos.x, pos.y);
          }
        }
      }
    }
  }
  implicitWidth: row.implicitWidth + hPadding * 2
  implicitHeight: 28

}
