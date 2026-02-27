import QtQuick
import QtQuick.Controls
import Qt.labs.qmlmodels 1.0
import Quickshell
import "../service/"
import "../Config/"

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

        Label {
            text: root.displayName || root.output
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
            delegate: Button {
                id: workspaceName
                implicitWidth: 20
                implicitHeight: 20
                onClicked: Niri.focusWorkspaceById(model.id)
                text: model.name ? `[${model.index}] ${model.name}` : model.index
                background: Rectangle {
                    color: model.isActive ? palette.text : Theme.colors.icon
                }
                contentItem: Label {
                    text: workspaceName.text
                    font.bold: true
                    color: model.isActive ? Theme.colors.background : palette.window
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
                        value: model.id
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
