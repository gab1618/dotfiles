import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Mpris
import qs.config
import qs.components.menus
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
  id: root
  color: Theme.colBg

  anchors.top: parent.top
  anchors.bottom: parent.bottom

  readonly property list<MprisPlayer> players: Mpris.players.values
  readonly property MprisPlayer player: players[0] ?? null
  readonly property var hPadding: 12
  property var showPlayer: false

  visible: player !== null
  radius: 8
  implicitWidth: row.implicitWidth + hPadding * 2

  RowLayout {
    id: row
    anchors.fill: parent
    anchors.leftMargin: hPadding
    anchors.rightMargin: hPadding

    Label {
      Layout.maximumWidth: 280
      elide: Text.ElideRight
      color: player.isPlaying ? Theme.colMaroon : Theme.colMuted
      text: player.trackTitle + " - " + player.trackArtist
      font {
        weight: 700;
        pixelSize: bar.fontSize;
      }
    }
  }


  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor

    onClicked: {
      const menuPos = root.mapToItem(null, 0, root.height)
      showPlayer = !showPlayer
      playerMenu.anchor.rect.x = menuPos.x
      playerMenu.anchor.rect.y = menuPos.y + 2
    }
  }

  PlayerMenu {
    id: playerMenu
    show: showPlayer
  }
}
