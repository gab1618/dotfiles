import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs.config
import qs.services

Rectangle {
  readonly property var hPadding: 12

  implicitWidth: soundLabel.implicitWidth
  Layout.fillHeight: true

  readonly property real audioDelta: 0.05

  color: Theme.base1
  radius: height / 2

  Label {
    id: soundLabel
    text: " " + Math.round(Audio.volume * 100) + "%"
    color: Theme.peach
    leftPadding: hPadding
    rightPadding: hPadding
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    verticalAlignment: Text.AlignVCenter

    font {
      family: bar.fontFamily
      pixelSize: bar.fontSize
    }

    MouseArea {
      anchors.fill: parent

      onWheel: event => {
        if (event.angleDelta.y > 0)
        Audio.incrementVolume(audioDelta);
        else if (event.angleDelta.y < 0)
        Audio.decrementVolume(audioDelta);
      }
    }
  }
}
