import QtQuick
import QtQuick.Controls
import Quickshell
import "../../service"
import "../../Config"

Item {
    property var workspaces
    property int count: root.count
    anchors {
        left: parent.left
        right: parent.right
    }
    implicitHeight: root.height
    clip: true
    ListView {
        id: root
        model: parent.workspaces
        anchors {
            left: parent.left
            right: parent.right
        }
        height: contentHeight
        delegate: Item {
            width: parent.width
            height: width
            property bool highlight: model.isFocused
            onHighlightChanged: {
                if (highlight) {
                    highlightRect.y = y;
                }
            }
            onYChanged: {
                if (highlight) {
                    highlightRect.y = y;
                }
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
            ToolTip {
                delay: 200
                text: model.title
                visible: hoverHandler.hovered
                popupType: Popup.Native
            }
        }
    }
    Rectangle {
        id: highlightRect
        width: parent.width
        height: width
        z: -1
        x: 0
        color: Theme.colors.accent
        border {
            color: Theme.colors.border.active
            width: 2
        }
        Behavior on y {
            NumberAnimation {
                duration: 200
            }
        }
    }
}
