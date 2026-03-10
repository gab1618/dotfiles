import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Qt.labs.folderlistmodel
import qs.config
import Quickshell.Hyprland
import Quickshell.Io

PopupWindow {
    id: picker

    anchor.window: bar
    anchor.rect.x: parentWindow.width - width
    anchor.rect.y: parentWindow.height

    visible: true

    width: 600
    height: 400
    color: "#00000000"

    Process {
      id: setWallpaperProc
      running: false
    }

    FolderListModel {
      id: folderModel
      folder: Qt.resolvedUrl("assets/wallpapers")
      showDirs: false
    }

    Rectangle {
        anchors.fill: parent
        radius: 10
        color: "#1e1e2e"

        GridView {
            id: grid
            anchors.fill: parent
            anchors.margins: 12

            cellWidth: 180
            cellHeight: 110

            model: folderModel

            delegate: Rectangle {
                width: 160
                height: 90
                radius: 6
                clip: true

                Image {
                    anchors.fill: parent
                    source: "file://" + filePath
                    fillMode: Image.PreserveAspectCrop
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                      setWallpaperProc.command = ["hyprctl", "hyprpaper", "wallpaper", `,${filePath}`]
                      setWallpaperProc.running = true

                      picker.visible = false
                    }
                }
            }
        }
    }
}
