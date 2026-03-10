import QtQuick
import Quickshell
import "../../service"
import "../../Config"
import Niri as NiriConnection

ListView {
    id: root
    anchors {
        left: parent.left
        right: parent.right
    }
    spacing: -2
    height: contentHeight
    delegate: Rectangle {
        id: workspaceRect
        property bool isHighlighted: model.isActive || hoverHandler.hovered
        color: Config.background
        border {
            color: isHighlighted ? Config.theme.colors.border.active : Config.theme.colors.border.inactive
            width: 2
        }
        topLeftRadius: index === 1 ? 5 : 0
        topRightRadius: topLeftRadius
        bottomLeftRadius: index === root.count ? 5 : 0
        bottomRightRadius: bottomLeftRadius
        z: isHighlighted ? 1 : 0
        width: 50
        height: workspaceItem.height
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
                text: (model.name || model.index)
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
                color: workspaceRect.border.color
                anchors.horizontalCenter: parent.horizontalCenter
                visible: model.isActive && windowList.count > 0
            }
            WindowList {
                id: windowList
                workspaces: filteredWindows
                height: workspaceItem.showWindows ? implicitHeight : 0
                Behavior on height {
                    NumberAnimation {
                        duration: 200
                    }
                }
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
