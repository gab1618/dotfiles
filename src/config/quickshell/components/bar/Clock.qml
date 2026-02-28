import QtQuick
import QtQuick.Controls

import qs.config

Rectangle {
  radius: 8
  implicitWidth: clock.implicitWidth
  anchors.top: parent.top
  anchors.bottom: parent.bottom
  color: Theme.colBg

  Label {
    id: clock

    topPadding: 4
    bottomPadding: 4
    leftPadding: 8
    rightPadding: 8
    color: Theme.colTeal

    font {
      family: bar.fontFamily;
      pixelSize: bar.fontSize;
      weight: 500;
    }
    Timer {
      interval: 1000
      running: true
      repeat: true
      onTriggered: clock.text = Qt.formatDateTime(new Date(), "  dd ddd 󰅐 HH:mm")
    }
  }
}
