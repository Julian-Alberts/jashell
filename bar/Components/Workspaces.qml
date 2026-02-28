import QtQuick
import QtQuick.Controls
import Qt.labs.qmlmodels 1.0
import Quickshell
import "../../service/"
import "../../Config/"
import ".."

TopBarComponent {
    id: root
    implicitWidth: row.implicitWidth
    SortFilterProxyModel {
        id: filteredWorkspaces
        model: Niri.workspaces

        filters: ValueFilter {
            roleName: "output"
            value: root.settings.screen.name
        }
    }
    ListView {
        id: row
        orientation: ListView.Horizontal
        spacing: 10
        anchors {
            top: parent.top
            bottom: parent.bottom
        }
        implicitWidth: childrenRect.width

        model: filteredWorkspaces
        delegate: Button {
            id: workspaceName
            required property var modelData
            implicitWidth: 20
            implicitHeight: 20
            onClicked: Niri.focusWorkspaceById(modelData.id)
            text: modelData.name ? `[${modelData.index}] ${modelData.name}` : modelData.index
            background: Rectangle {
                color: parent.modelData.isActive ? palette.text : Theme.colors.icon
            }
            contentItem: Label {
                text: workspaceName.text
                font.bold: true
                color: modelData.isActive ? Theme.colors.background : palette.window
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            HoverHandler {
                id: hoverWorkspace
                cursorShape: Qt.PointingHandCursor
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
            SortFilterProxyModel {
                id: filteredWindows
                model: Niri.windows

                filters: ValueFilter {
                    roleName: "workspaceId"
                    value: workspaceName.modelData.id
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
