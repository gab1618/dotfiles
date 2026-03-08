import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.components.bar

PanelWindow {
  id: bar

  visible: true

  property string fontFamily: "FiraCode Nerd Font"
  property int fontSize: 14

  anchors.top: true
  anchors.left: true
  anchors.right: true
  implicitHeight: 32
  color: "#00000000"

  RowLayout {
    anchors.fill: parent
    anchors.margins: 2
    anchors.leftMargin: 6
    anchors.rightMargin: 6

    RowLayout {
      anchors.left: parent.left
      anchors.verticalCenter: parent.verticalCenter

      Workspaces {}
    }

    RowLayout {
      anchors.verticalCenter: parent.verticalCenter
      anchors.centerIn: parent

      Mpris {}
    }

    RowLayout {
      spacing: 8

      anchors.right: parent.right
      anchors.verticalCenter: parent.verticalCenter

      Tray {}

      Sound {}

      Clock {}
    }
  }
}
