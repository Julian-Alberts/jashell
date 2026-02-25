import QtQuick
import Quickshell
import "../../service"

ListView {
    id: root
    anchors {
        left: parent.left
        right: parent.right
    }
    height: contentHeight
    delegate: Item {
        width: 50
        height: 50
        Rectangle {
            width: 50
            height: width
            color: "#565f89"
            border {
                color: Config.textColor
                width: 2
            }
            radius: 5
            visible: model.isFocused || hoverHandler.hovered
        }
        Image {
            source: model.iconPath ? "file://" + model.iconPath : ""
            sourceSize.width: root.width
            sourceSize.height: root.width
            visible: model.iconPath !== ""
            smooth: true
            anchors.horizontalCenter: parent.horizontalCenter
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("Focusing window with id:", model.id);
                Niri.focusWindow(model.id);
            }
            cursorShape: Qt.PointingHandCursor
        }
        HoverHandler {
            id: hoverHandler
        }
    }
}
