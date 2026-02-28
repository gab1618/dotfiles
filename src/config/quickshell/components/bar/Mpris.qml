import QtQuick
import Quickshell
import Quickshell.Widgets
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
  property var showPlayer: false

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
      text: player.trackTitle + " - " + player.trackArtist
      font {
        weight: 700;
        pixelSize: bar.fontSize;
      }
    }
  }

  implicitWidth: row.implicitWidth + hPadding * 2
  implicitHeight: 28

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

  PopupWindow {
    id: playerMenu
    anchor.window: bar
    visible: player !== null && showPlayer

    width: 480
    height: 160
    color: "#00000000"

    onVisibleChanged: if (visible) forceActiveFocus()

    readonly property var hPadding: 8
    readonly property var vPadding: 8

    readonly property var thumbSize: playerMenu.height - vPadding * 2

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
          width: playerMenu.thumbSize
          height: playerMenu.thumbSize
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
}
