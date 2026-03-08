import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Mpris
import qs.config
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Hyprland

Rectangle {
  id: root
  color: Theme.base1

  Layout.fillHeight: true

  readonly property list<MprisPlayer> players: Mpris.players.values
  readonly property MprisPlayer player: players[0] ?? null
  readonly property var hPadding: 0

  visible: player !== null
  radius: height / 2
  implicitWidth: row.implicitWidth + hPadding * 2

  RowLayout {
    id: row
    anchors.fill: parent
    anchors.leftMargin: hPadding
    anchors.rightMargin: hPadding

    spacing: 12

    RowLayout {
      spacing: 8

      Rectangle {
        anchors.fill: parent
        color: Theme.maroon
        topLeftRadius: height / 2
        bottomLeftRadius: height / 2
      }

      Label {
        text: "󰼨"
        visible: player.canGoPrevious
        color: Theme.base1
        font {
          pixelSize: 20
          weight: 700;
        }

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onClicked: {
            player.previous();
          }
        }
      }
      Label {
        text: player.isPlaying ? "󰏤" : "󰼛"
        visible: player.canTogglePlaying
        color: Theme.base1
        font {
          pixelSize: 20
          weight: 700;
        }

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onClicked: {
            player.togglePlaying();
          }
        }
      }
      Label {
        text: "󰼧"
        visible: player.canGoNext
        color: Theme.base1
        Layout.rightMargin: 4
        font {
          pixelSize: 20
          weight: 700;
        }

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onClicked: {
            player.next();
          }
        }
      }
    }
    Label {
      Layout.maximumWidth: 360
      elide: Text.ElideRight
      color: player.isPlaying ? Theme.maroon : Theme.base4
      text: player.trackTitle + " - " + player.trackArtist

      font {
        weight: 700;
        pixelSize: bar.fontSize;
      }

      background: Rectangle {
        color: "#00000000"

        MouseArea {
          anchors.fill: parent

          cursorShape: Qt.PointingHandCursor

          onClicked: {
            Hyprland.dispatch(`focuswindow class:^(${player.desktopEntry})$`)
          }
        }
      }
    }
  }
}
