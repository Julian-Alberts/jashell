import QtQuick
import Quickshell
import "../service"
import "./TaskList/"

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
    WorkspaceList {
        id: content
        model: filteredWorkspaces
        width: root.barWidth
    }
}
