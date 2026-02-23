import QtQuick
import Quickshell
import Quickshell.Services.Mpris
import qs.config
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
  id: root
  color: Theme.colBg

  readonly property list<MprisPlayer> players: Mpris.players.values
  readonly property MprisPlayer player: players[0] ?? null
  readonly property var hPadding: 12
  readonly property var vPadding: 3

  visible: player !== null
  radius: 8

  RowLayout {
    id: row
    anchors.fill: parent
    anchors.leftMargin: hPadding
    anchors.rightMargin: hPadding
    anchors.topMargin: vPadding
    anchors.bottomMargin: vPadding

    Label {
      Layout.maximumWidth: 280
      elide: Text.ElideRight
      color: player.isPlaying ? Theme.colMaroon : Theme.colMuted
      text: player
        ? player.trackTitle + " - " + player.trackArtist
        : ""
      font {
        weight: 500;
        pixelSize: bar.fontSize;
      }
    }
  }

  implicitWidth: row.implicitWidth + hPadding * 2
  implicitHeight: row.implicitHeight + vPadding * 2

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor

    onClicked: {
      player?.togglePlaying();
    }
  }
}
