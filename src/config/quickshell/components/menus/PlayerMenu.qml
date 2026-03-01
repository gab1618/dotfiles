import Quickshell
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Widgets
import qs.config
import Quickshell.Hyprland

PopupWindow {
  id: root
  anchor.window: bar

  property var show: false

  readonly property list<MprisPlayer> players: Mpris.players.values
  readonly property MprisPlayer player: players[0] ?? null

  implicitWidth: 480
  implicitHeight: 160
  color: "#00000000"

  visible: player != null && show

  readonly property var thumbSize: root.height

  readonly property real progress: player.length > 0 ? player.position / player.length : 0

  Timer {
    running: player.playbackState == MprisPlaybackState.Playing
    interval: 1000
    repeat: true
    onTriggered: player.positionChanged()
  }

  Rectangle {
    id: content
    anchors.fill: parent
    color: Theme.base1
    clip: true
    radius: 8

    RowLayout {
      anchors.fill: parent

      Rectangle {
        width: root.thumbSize
        height: root.thumbSize
        color: "#00000000"

        ClippingWrapperRectangle {
          anchors.fill: parent
          topLeftRadius: content.radius
          bottomLeftRadius: content.radius

          Image {
            source: player.trackArtUrl
            fillMode: Image.PreserveAspectCrop
          }
        }

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor

          onClicked: {
            Hyprland.dispatch(`focuswindow class:^(${player.desktopEntry})$`)
            root.show = false
          }
        }
      }
      Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        color: "#00000000"

        ColumnLayout {
          anchors.left: parent.left
          anchors.right: parent.right
          anchors.margins: 8

          Label {
            text: player.trackTitle
            Layout.fillWidth: true

            color: Theme.rosewater
            Layout.topMargin: 12
            Layout.maximumWidth: 280

            elide: Text.ElideRight
            wrapMode: Text.Wrap
            maximumLineCount: 2

            font {
              weight: 700;
              pixelSize: 20;
            }
          }
          Label {
            text: player.trackArtist
            color: Theme.base6
            font {
              weight: 600;
              pixelSize: 12;
            }
          }
          RowLayout {
            spacing: 12

            Label {
              text: "󰼨"
              visible: player.canGoPrevious
              color: Theme.peach
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
              text: player.isPlaying ? "󰏤" : ""
              visible: player.canTogglePlaying
              color: Theme.peach
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
              color: Theme.peach
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
        }
      }
    }

    Item {
      id: progressBar
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.bottom: parent.bottom
      height: 2

      Rectangle {
        anchors.fill: parent
        bottomLeftRadius: height / 2
        bottomRightRadius: height / 2
        color: Theme.base3
      }

      Rectangle {
        height: parent.height
        width: parent.width * progress
        bottomLeftRadius: height / 2
        bottomRightRadius: height / 2
        color: Theme.peach
      }
    }
  }
}
