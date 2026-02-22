pragma Singleton

import Quickshell
import QtQuick

Singleton {
    readonly property AppearanceConfig.Rounding rounding: Config.appearance.rounding
    readonly property color colBg: "#11111b"
    readonly property color colFg: "#cad3f5"
    readonly property color colMuted: "#313244"
    readonly property color colSky: "#91d7e3"
    readonly property color colMauve: "#cba6f7"
    readonly property color colBlue: "#8aadf4"
    readonly property color colTeal: "#8bd5ca"
    readonly property color colGreen: "#a6da95"
}
