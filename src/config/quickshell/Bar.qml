import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.config
import qs.services
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
    anchors.margins: 4
    spacing: 8

    Workspaces {}

    Item { Layout.fillWidth: true }

    Tray {}

    Mpris {}

    Sound {}

    Clock {}
  }
}
