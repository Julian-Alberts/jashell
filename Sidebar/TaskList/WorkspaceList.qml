import QtQuick
import Quickshell
import "../../service"

ListView {
    anchors {
        left: parent.left
        right: parent.right
    }
    height: contentHeight
    delegate: Rectangle {
        color: Config.background
        border {
            color: model.isActive || hoverHandler.hovered ? Config.theme.colors.text : Config.theme.colors.icon
            width: 2
        }
        width: 50
        height: workspaceItem.height
        radius: 5
        Column {
            id: workspaceItem
            property bool showWindows: model.isActive
            width: parent.width
            SortFilterProxyModel {
                id: filteredWindows
                model: Niri.windows
                filters: [
                    ValueFilter {
                        roleName: "workspaceId"
                        value: model.id
                    }
                ]
            }

            Text {
                text: model.name || model.index
                color: Config.textColor
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                width: parent.width
                height: implicitHeight + 4
            }
            Rectangle {
                width: parent.width
                height: 2
                color: Config.theme.colors.text
                anchors.horizontalCenter: parent.horizontalCenter
                visible: model.isActive
            }
            WindowList {
                model: filteredWindows
                height: workspaceItem.showWindows ? contentHeight : 0
            }
        }
        HoverHandler {
            id: hoverHandler
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                Niri.focusWorkspaceById(model.id);
            }
            cursorShape: Qt.PointingHandCursor
            enabled: !model.isActive
        }
    }
}
