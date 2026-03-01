import QtQuick
import Quickshell
import "../../service"
import "../../Config"

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
        property bool highlight: hoverHandler.hovered || model.isFocused
        Rectangle {
            width: 50
            height: width
            color: Theme.colors.accent
            border {
                color: Theme.colors.border.active
                width: 2
            }
            radius: 5
            visible: model.isFocused || hoverHandler.hovered
        }
        Image {
            id: windowIcon
            source: model.iconPath ? "file://" + model.iconPath : ""
            sourceSize.width: root.width - 10
            sourceSize.height: root.width - 10
            smooth: true
            visible: !!model.iconPath
            anchors.centerIn: parent
        }
        // Image fallback
        Rectangle {
            width: parent.width - 10
            height: parent.height - 10
            color: Theme.colors.icon
            visible: !windowIcon.visible
            anchors.centerIn: parent
            radius: 5
            Text {
                width: parent.width - 10
                height: parent.height - 10
                clip: true
                anchors.centerIn: parent
                text: model.appId + index
                color: Theme.colors.text
                font.pixelSize: 12
                wrapMode: Text.Wrap
            }
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
