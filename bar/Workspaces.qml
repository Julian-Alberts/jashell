import QtQuick
import Qt.labs.qmlmodels 1.0
import Quickshell
import "../service/"

Item {
    id: root
    property string output
    property bool multiple: false
    property string displayName

    Component.onCompleted: {}
    implicitHeight: 20
    implicitWidth: row.implicitWidth
    anchors.verticalCenter: parent.verticalCenter

    Row {
        id: row
        spacing: 10
        anchors.verticalCenter: parent.verticalCenter

        Text {
            text: root.displayName || root.output
            color: Config.textColor
            visible: root.multiple
            font.bold: true
        }

        SortFilterProxyModel {
            id: filteredWorkspaces
            model: Niri.workspaces

            filters: ValueFilter {
                roleName: "output"
                value: root.output
            }
        }

        Repeater {
            model: filteredWorkspaces
            delegate: Item {
                id: workspaceItem
                implicitWidth: workspaceName.implicitWidth < root.implicitHeight ? root.implicitHeight : workspaceName.implicitWidth
                implicitHeight: 20

                SortFilterProxyModel {
                    id: filteredWindows
                    model: Niri.windows

                    filters: ValueFilter {
                        roleName: "workspaceId"
                        value: model.id
                    }
                }
                Rectangle {
                    anchors.fill: parent
                    color: model.isActive ? "#c0caf5" : "#565f89"

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: Niri.focusWorkspaceById(model.id)
                    }

                    Text {
                        id: workspaceName
                        text: model.name ? `[${model.index}] ${model.name}` : model.index
                        anchors.centerIn: parent
                        font.bold: true
                    }
                }
                HoverHandler {
                    id: hoverWorkspace
                    acceptedPointerTypes: PointerDevice.All
                    onHoveredChanged: {
                        if (this.hovered) {
                            hoverWsTimer.start();
                            hoverWsCloseTimer.stop();
                            thumbnail.windows = filteredWindows;
                            thumbnail.anchorItem = workspaceItem;
                        } else {
                            hoverWsTimer.stop();
                            hoverWsCloseTimer.start();
                        }
                    }
                }
            }
        }
    }
    Timer {
        id: hoverWsTimer
        interval: 500
        onTriggered: {
            thumbnail.preview = true;
        }
    }
    Timer {
        id: hoverWsCloseTimer
        interval: 250
        onTriggered: {
            thumbnail.preview = false;
        }
    }
    WindowThumbnailPopup {
        id: thumbnail
    }
}
