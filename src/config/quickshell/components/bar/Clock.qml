import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs.config

Rectangle {
  radius: 8
  implicitWidth: clock.implicitWidth
  Layout.fillHeight: true
  color: Theme.base1

  function clockContent() {
    return Qt.formatDateTime(new Date(), "  dd ddd 󰅐 HH:mm")
  }

  Label {
    id: clock

    text: clockContent()
    anchors.top: parent.top
    anchors.bottom: parent.bottom

    leftPadding: 8
    rightPadding: 8
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
