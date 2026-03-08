import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs.config

Rectangle {
  readonly property var hPadding: 16

  implicitWidth: clock.implicitWidth
  Layout.fillHeight: true

  color: Theme.base1

  radius: height / 2

  function clockContent() {
    return Qt.formatDateTime(new Date(), "  dd ddd 󰅐 HH:mm")
  }

  Label {
    id: clock

    text: clockContent()
    anchors.top: parent.top
    anchors.bottom: parent.bottom

    leftPadding: hPadding
    rightPadding: hPadding
    verticalAlignment: Text.AlignVCenter
    color: Theme.green

    font {
      family: bar.fontFamily;
      pixelSize: bar.fontSize;
      weight: 500;
    }
    Timer {
      interval: 1000
      running: true
      repeat: true
      onTriggered: clock.text = clockContent()
    }
  }
}
