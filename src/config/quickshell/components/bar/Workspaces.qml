import Quickshell.Io
import Quickshell.Hyprland
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick

import qs.config

Rectangle {
  color: Theme.colBg
  radius: 8

  RowLayout {
    id: row
    anchors.fill: parent
    anchors.leftMargin: 14
    anchors.rightMargin: 14
    spacing: 16

    Repeater {
      model: 9
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
  implicitWidth: row.implicitWidth + 28
  implicitHeight: 28
}
