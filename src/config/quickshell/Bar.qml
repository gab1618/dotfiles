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
  implicitHeight: 36
  color: "#00000000"

  RowLayout {
    anchors.fill: parent
    anchors.margins: 2
    anchors.leftMargin: 6
    anchors.rightMargin: 6

    RowLayout {
      anchors.left: parent.left
      anchors.top: parent.top
      anchors.bottom: parent.bottom

      Workspaces {}
    }

    RowLayout {
      anchors.centerIn: parent
      anchors.top: parent.top
      anchors.bottom: parent.bottom

      Mpris {}
    }

    RowLayout {
      spacing: 8

      anchors.right: parent.right
      anchors.top: parent.top
      anchors.bottom: parent.bottom

      Tray {}

      Sound {}

      Clock {}
    }
  }
}
