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

  readonly property var hPadding: 8
  readonly property var vPadding: 8

  readonly property var thumbSize: root.height - vPadding * 2

  Rectangle {
    anchors.fill: parent
    color: Theme.colBg
    radius: 8

    RowLayout {
      spacing: 12
      anchors.fill: parent
      anchors.leftMargin: hPadding
      anchors.rightMargin: hPadding
      anchors.topMargin: vPadding
      anchors.bottomMargin: vPadding

      Rectangle {
        width: root.thumbSize
        height: root.thumbSize
        color: "#00000000"

        ClippingWrapperRectangle {
          anchors.fill: parent
          radius: 6

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
          Label {
            text: player.trackTitle
            color: Theme.colMaroon
            Layout.topMargin: 12
            Layout.maximumWidth: 280
            elide: Text.ElideRight

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
          RowLayout {
            spacing: 12

            Label {
              text: "󰼨"
              visible: player.canGoPrevious
              color: Theme.colFg
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
              color: Theme.colFg
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
              color: Theme.colFg
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
