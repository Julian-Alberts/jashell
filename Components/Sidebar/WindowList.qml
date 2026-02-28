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
            sourceSize.width: root.width - 10
            sourceSize.height: root.width - 10
            smooth: true
            visible: !!model.iconPath
            anchors.centerIn: parent
        }
        Rectangle {
            width: parent.width - 10
            height: parent.height - 10
            color: Config.theme.colors.icon
            visible: !model.iconPath
            anchors.centerIn: parent
            radius: 5
            Text {
                width: parent.width - 10
                height: parent.height - 10
                clip: true
                anchors.centerIn: parent
                text: model.appId
                color: Config.textColor
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
