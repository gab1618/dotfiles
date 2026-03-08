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
    spacing: 0

    RowLayout {
      id: buttons
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

      Label {
        text: "󰌧"
        color: Theme.base1
        rightPadding: 6

        font {
          pixelSize: 20
          weight: 700;
        }

        background: MouseArea {
          anchors.fill: parent

          cursorShape: Qt.PointingHandCursor

          onClicked: {
            Hyprland.dispatch(`focuswindow class:^(${player.desktopEntry})$`)
          }
        }
      }
    }
    Label {
      id: tracktitle
      visible: false
      Layout.maximumWidth: 360
      elide: Text.ElideRight
      color: player.isPlaying ? Theme.maroon : Theme.base4
      text: player.trackTitle + " - " + player.trackArtist

      leftPadding: 6
      rightPadding: 6

      font {
        weight: 700;
        pixelSize: bar.fontSize;
      }

      background: MouseArea {
        anchors.fill: parent

        cursorShape: Qt.PointingHandCursor

        onClicked: {
          Hyprland.dispatch(`focuswindow class:^(${player.desktopEntry})$`)
        }
      }
    }

    RowLayout {
      Rectangle {
        anchors.fill: parent
        color: Theme.maroon
        topRightRadius: height / 2
        bottomRightRadius: height / 2
      }

      Label {
        text: ""
        color: Theme.base1
        rightPadding: 6

        font {
          pixelSize: 20
          weight: 700;
        }

        background: MouseArea {
          anchors.fill: parent

          cursorShape: Qt.PointingHandCursor

          onClicked: {
            tracktitle.visible = !tracktitle.visible
          }
        }
      }
    }
  }
}
