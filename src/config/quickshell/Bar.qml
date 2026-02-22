import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "Theme"

PanelWindow {
    id: bar

    visible: false

    // Theme
    property color colBg: "#11111b"
    property color colFg: "#a9b1d6"
    property color colMuted: "#313244"
    property color colCyan: "#0db9d7"
    property color colMauve: "#cba6f7"
    property color colBlue: "#7aa2f7"
    property color colYellow: "#e0af68"
    property string fontFamily: "FiraCode Nerd Font"
    property int fontSize: 14

    // System data
    property int cpuUsage: 0
    property int memUsage: 0
    property var lastCpuIdle: 0
    property var lastCpuTotal: 0

    // Processes and timers here...

    anchors.top: true
    anchors.left: true
    anchors.right: true
    implicitHeight: 30
    color: bar.colBg

    RowLayout {
        anchors.fill: parent
        anchors.margins: 8
        spacing: 8

        // Workspaces
        Repeater {
            model: 9
            Text {
                property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
                text: index + 1
                visible: ws ? true : false
                color: isActive ? bar.colMauve : bar.colMuted
                font {
                  family: bar.fontFamily;
                  pixelSize: bar.fontSize;
                  weight: 600
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: Hyprland.dispatch("workspace " + (index + 1))
                }
            }
        }

        Item { Layout.fillWidth: true }

        // Clock
        Text {
            id: clock
            color: bar.colBlue
            font { family: bar.fontFamily; pixelSize: bar.fontSize; bold: true }
            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: clock.text = Qt.formatDateTime(new Date(), "󰅐 HH:mm")
            }
        }

        Text {

        }
    }
}
