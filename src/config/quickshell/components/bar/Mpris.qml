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
  readonly property var buttonsPadding: 6

  property var showTracktitle: true

  visible: player !== null
  radius: height / 2
  implicitWidth: row.implicitWidth + hPadding * 2

  RowLayout {
    id: row

    anchors.fill: parent
    anchors.leftMargin: hPadding
    anchors.rightMargin: hPadding

    Label {
      text: "󰼨"
      visible: player.canGoPrevious
      color: Theme.base1

      leftPadding: buttonsPadding
      rightPadding: buttonsPadding

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

      leftPadding: buttonsPadding
      rightPadding: buttonsPadding

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

      leftPadding: buttonsPadding
      rightPadding: buttonsPadding

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
      Layout.maximumWidth: showTracktitle ? 360 : 0
      Layout.fillHeight: true
      elide: Text.ElideRight
      color: player.isPlaying ? Theme.maroon : Theme.base4
      text: player.trackTitle + " - " + player.trackArtist
      onTextChanged: forceLayout()

      Behavior on Layout.maximumWidth {
        NumberAnimation {
          duration: 400

          easing {
            type: Easing.InOutCubic
            amplitude: 2.0;
            period: 1.5
          }
        }
      }

      verticalAlignment: Text.AlignVCenter

      leftPadding: buttonsPadding
      rightPadding: buttonsPadding

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

      leftPadding: buttonsPadding
      rightPadding: buttonsPadding

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
