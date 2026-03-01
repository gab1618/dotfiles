import Quickshell
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Widgets
import qs.config

PopupWindow {
  id: root
  anchor.window: bar

  property var show: false

  readonly property list<MprisPlayer> players: Mpris.players.values
  readonly property MprisPlayer player: players[0] ?? null

  width: 480
  height: 160
  color: "#00000000"

  visible: player != null && show

  readonly property var thumbSize: root.height

  readonly property real progress: player.length > 0 ? player.position / player.length : 0

  Rectangle {
    id: content
    anchors.fill: parent
    color: Theme.colBg
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
            anchors.fill: parent
            source: player.trackArtUrl
            fillMode: Image.PreserveAspectCrop
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

            color: Theme.colMaroon
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
            color: Theme.colFg
            font {
              weight: 500;
              pixelSize: 12;
            }
          }
          Item {
            id: progressBar
            Layout.fillWidth: true
            height: 4

            Rectangle {
              anchors.fill: parent
              radius: height / 2
              color: Theme.colMuted
            }

            Rectangle {
              height: parent.height
              width: parent.width * progress
              radius: height / 2
              color: Theme.colMauve
            }
          }
          RowLayout {
            spacing: 12

            Label {
              text: "󰼨"
              visible: player.canGoPrevious
              color: Theme.colMauve
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
              color: Theme.colMauve
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
              color: Theme.colMauve
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
  }
}
