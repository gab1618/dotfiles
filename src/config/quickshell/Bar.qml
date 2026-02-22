import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire
import QtQuick.Controls

import qs.services

PanelWindow {
  id: bar

  visible: true

  // Theme
  property color colBg: "#11111b"
  property color colFg: "#cad3f5"
  property color colMuted: "#313244"
  property color colSky: "#91d7e3"
  property color colMauve: "#cba6f7"
  property color colBlue: "#8aadf4"
  property color colTeal: "#8bd5ca"
  property color colGreen: "#a6da95"

  property string fontFamily: "FiraCode Nerd Font"
  property int fontSize: 14

  // Processes and timers here...

  anchors.top: true
  anchors.left: true
  anchors.right: true
  implicitHeight: 32
  color: "#00000000"

  RowLayout {
    anchors.fill: parent
    anchors.margins: 4
    spacing: 12

    // Workspaces
    Rectangle {
      color: bar.colBg
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
            color: (isActive || isHovered) ? bar.colMauve : bar.colMuted
            font {
              family: bar.fontFamily;
              pixelSize: bar.fontSize;
              weight: 600
            }
            MouseArea {
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
      implicitHeight: row.implicitHeight + 10

    }

    Item { Layout.fillWidth: true }

    // Clock

    Label {
      text: " " + Math.round(Audio.volume * 100) + "%"
      color: bar.colGreen
      topPadding: 4
      bottomPadding: 4
      leftPadding: 8
      rightPadding: 8

      font {
        family: bar.fontFamily
        pixelSize: bar.fontSize
      }

      MouseArea {
        anchors.fill: parent

        onWheel: event => {
          if (event.angleDelta.y > 0)
          Audio.incrementVolume();
          else if (event.angleDelta.y < 0)
          Audio.decrementVolume();
        }
      }
      background: Rectangle {
        radius: 8
        color: bar.colBg
      }
    }

    Label {
      id: clock

      topPadding: 4
      bottomPadding: 4
      leftPadding: 8
      rightPadding: 8
      color: bar.colTeal

      font {
        family: bar.fontFamily;
        pixelSize: bar.fontSize;
        weight: 500;
      }
      Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: clock.text = Qt.formatDateTime(new Date(), "󰅐 HH:mm")
      }
      background: Rectangle {
        radius: 8
        color: bar.colBg
      }
    }
  }
}
