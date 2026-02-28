import QtQuick
import QtQuick.Controls

import qs.config
import qs.services

Rectangle {
  implicitWidth: soundLabel.implicitWidth
  anchors.top: parent.top
  anchors.bottom: parent.bottom

  color: Theme.colBg
  radius: 8

  Label {
    id: soundLabel
    text: " " + Math.round(Audio.volume * 100) + "%"
    color: Theme.colGreen
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
  }
}
