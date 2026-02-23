import Quickshell
import QtQuick
import "../service"

PopupWindow {
    color: "transparent"
    property bool preview: false
    onPreviewChanged: {
        if (preview) {
            visible = true
            return
        }
        preview = false
        hideTimer.restart()
    }
    Timer {
        id: hideTimer
        interval: 200
        onTriggered: root.visible = false
    }
    Rectangle {
        anchors.fill: parent
        color: Config.background
        border {
            color: Config.textColor
            width: 2
        }
        radius: 5
    }
    HoverHandler {
        id: hoverHandler
        onHoveredChanged: {
            hideTimer.stop()
            root.visible = hovered
        }
    }
}
