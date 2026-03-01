import QtQuick
import Quickshell
import "../../service"
import "../../Config"

Item {
    id: root
    property ShellScreen screen
    property int barWidth: 50
    width: parent.width
    height: content.height
    SortFilterProxyModel {
        id: filteredWorkspaces
        model: Niri.workspaces
        filters: [
            ValueFilter {
                roleName: "output"
                value: root.screen.name
            }
        ]
    }
    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border {
            color: Theme.colors.icon
            width: 2
        }
        radius: 5
    }
    WorkspaceList {
        id: content
        model: filteredWorkspaces
        width: root.barWidth
    }
}
