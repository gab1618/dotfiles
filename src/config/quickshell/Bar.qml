import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire

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

  // System data
  property int cpuUsage: 0
  property int memUsage: 0
  property var lastCpuIdle: 0
  property var lastCpuTotal: 0

  // Processes and timers here...

  anchors.top: true
  anchors.left: true
  anchors.right: true
  implicitHeight: 30
  color: bar.colBg

  RowLayout {
    anchors.fill: parent
    anchors.margins: 8
    spacing: 12

    Rectangle {
      color: bar.colBg
    }

    // Workspaces
    Repeater {
      model: 9
      Text {
        property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
        property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
        text: index + 1
        visible: ws ? true : false
        color: isActive ? bar.colMauve : bar.colMuted
        font {
          family: bar.fontFamily;
          pixelSize: bar.fontSize;
          weight: 600
        }
        MouseArea {
          anchors.fill: parent
          onClicked: Hyprland.dispatch("workspace " + (index + 1))
        }
      }
    }

    Item { Layout.fillWidth: true }

    // Clock

    Text {
      text: " " + Math.round(Audio.volume * 100) + "%"
      color: bar.colGreen
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
    }

    Text {
      id: clock
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
    }
  }
}
