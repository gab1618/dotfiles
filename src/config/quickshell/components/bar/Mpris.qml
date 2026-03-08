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
  color: Theme.maroon

  Layout.fillHeight: true

  readonly property list<MprisPlayer> players: Mpris.players.values
  readonly property MprisPlayer player: players[0] ?? null
  readonly property var hPadding: 12

  property var showTracktitle: false

  visible: player !== null
  radius: height / 2
  implicitWidth: row.implicitWidth + hPadding * 2

  RowLayout {
    id: row
    spacing: 12

    anchors.fill: parent
    anchors.leftMargin: hPadding
    anchors.rightMargin: hPadding

    Label {
      text: "󰼨"
      visible: player.canGoPrevious
      color: Theme.base1

      verticalAlignment: Text.AlignVCenter
      Layout.fillHeight: true

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

      verticalAlignment: Text.AlignVCenter
      Layout.fillHeight: true

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

      verticalAlignment: Text.AlignVCenter
      Layout.fillHeight: true

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
      id: tracktitle
      visible: showTracktitle
      Layout.maximumWidth: showTracktitle ? 360 : 0
      Layout.fillHeight: true
      elide: Text.ElideRight
      color: player.isPlaying ? Theme.maroon : Theme.base4
      text: player.trackTitle + " - " + player.trackArtist

      Behavior on Layout.maximumWidth {
        NumberAnimation {
          duration: 300
        }
      }

      verticalAlignment: Text.AlignVCenter

      leftPadding: 6
      rightPadding: 6

      font {
        weight: 700;
        pixelSize: bar.fontSize;
      }

      background: Rectangle {
        anchors.fill: parent
        color: Theme.base1

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor

          onClicked: {
            Hyprland.dispatch(`focuswindow class:^(${player.desktopEntry})$`)
          }
        }
      }
    }
    Label {
      text: ""
      color: Theme.base1

      font {
        pixelSize: 20
        weight: 700;
      }

      background: MouseArea {
        anchors.fill: parent

        cursorShape: Qt.PointingHandCursor

        onClicked: {
          showTracktitle = !showTracktitle
        }
      }
    }
  }
}
