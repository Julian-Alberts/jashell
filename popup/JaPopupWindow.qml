import Quickshell
import QtQuick
import "../service"

PopupWindow {
    color: "transparent"
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
            root.visible = hovered
        }
    }
}
