import Quickshell.Io
import Quickshell.Hyprland
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick

import qs.config

Rectangle {
  id: workspaces
  readonly property var hPadding: 8

  color: Theme.base1
  radius: height / 2

  Layout.fillHeight: true
  implicitWidth: row.implicitWidth + hPadding * 2

  RowLayout {
    id: row
    anchors.fill: parent
    anchors.leftMargin: hPadding
    anchors.rightMargin: hPadding
    spacing: 8

    Repeater {
      model: 10
      Label {
        id: wsLabel

        property bool isHovered: false
        property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
        property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

        text: index + 1
        visible: ws ? true : false
        color: ws?.urgent ? Theme.peach : Theme.base4;

        leftPadding: wsLabel.height / 2
        rightPadding: wsLabel.height / 2

        font {
          family: bar.fontFamily;
          pixelSize: bar.fontSize;
          weight: 600
        }
        MouseArea {
          cursorShape: Qt.PointingHandCursor
          hoverEnabled: true
          anchors.fill: parent
          onClicked: ws.activate()
          onEntered: wsLabel.isHovered = true
          onExited: wsLabel.isHovered = false
        }

        background: Rectangle {
          color: (isActive || isHovered) ? Theme.mauve : Theme.base1
          radius: height / 2
          Layout.fillHeight: true
          Layout.fillWidth: true
        }
      }
    }
  }
}
