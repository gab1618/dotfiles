import Quickshell.Io
import Quickshell.Hyprland
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick

import qs.config

Rectangle {
  readonly property var hPadding: 14
  color: Theme.colBg
  radius: 8
  anchors.top: parent.top
  anchors.bottom: parent.bottom
  implicitWidth: row.implicitWidth + hPadding * 2

  RowLayout {
    id: row
    anchors.fill: parent
    anchors.leftMargin: hPadding
    anchors.rightMargin: hPadding
    spacing: 16

    Repeater {
      model: 10
      Text {
        id: wsLabel
        property bool isHovered: false
        property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
        property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
        text: index + 1
        visible: ws ? true : false
        color: (isActive || isHovered) ? Theme.colMauve : Theme.colMuted
        font {
          family: bar.fontFamily;
          pixelSize: bar.fontSize;
          weight: 600
        }
        MouseArea {
          cursorShape: Qt.PointingHandCursor
          hoverEnabled: true
          anchors.fill: parent
          onClicked: Hyprland.dispatch("workspace " + (index + 1))
          onEntered: wsLabel.isHovered = true
          onExited: wsLabel.isHovered = false
        }
      }
    }
  }
}
