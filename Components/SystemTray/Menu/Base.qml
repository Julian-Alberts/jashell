import QtQuick
import Quickshell
import "../../../service"

Item {
    id: root
    property QsMenuHandle handle
    property real menuWidth
    property color textColor: Config.theme.colors.text
    property color backgroundColor: Config.theme.colors.background

    property color currentTextColor: hoverHandler.hovered ? backgroundColor : textColor
    property color currentBackgroundColor: hoverHandler.hovered ? textColor : backgroundColor

    Rectangle {
        anchors.fill: parent
        color: root.currentBackgroundColor
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.handle.triggered();
        }
        cursorShape: Qt.PointingHandCursor
    }
    HoverHandler {
        id: hoverHandler
    }
}
