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
      Layout.fillWidth: true
      Layout.alignment: Qt.AlignLeft

      Workspaces {}
    }

    RowLayout {
      Layout.fillWidth: true
    }

    RowLayout {
      Layout.fillWidth: true
      Layout.alignment: Qt.AlignRight
      spacing: 8

      Mpris {}

      Tray {}

      Sound {}

      Clock {}
    }
  }
}
