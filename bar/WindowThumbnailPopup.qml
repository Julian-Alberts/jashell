import QtQuick
import Qt.labs.qmlmodels 1.0
import Quickshell
import "../service"

PopupWindow {
    id: root
    property bool preview: false
    property var windows
    property var anchorItem
    anchor {
        rect.y: 30
        item: anchorItem
    }
    onAnchorItemChanged: {
        // Force position update
        anchor.updateAnchor();
    }
    visible: windowHover.hovered || preview
    color: "transparent"
    implicitHeight: 120
    implicitWidth: hoverWsList.implicitWidth > 500 ? hoverWsList.implicitWidth : 500
    HoverHandler {
        id: windowHover
        acceptedPointerTypes: PointerDevice.All
        onHoveredChanged: {
            parent.preview = false;
        }
    }
    Rectangle {
        anchors.fill: parent
        color: Config.background
        border {
            color: Config.textColor
            width: 2
        }
        radius: 5
    }
    Row {
        id: hoverWsList
        spacing: 20
        anchors.centerIn: parent
        Repeater {
            model: root.windows
            delegate: Rectangle {
                implicitWidth: thumbnailContainer.implicitWidth + 20
                implicitHeight: thumbnailContainer.implicitHeight + 20
                color: "transparent"
                border {
                    color: Config.textColor
                    width: 0
                }
                radius: 5
                Column {
                    id: thumbnailContainer
                    spacing: 5
                    anchors.margins: 2
                    anchors.centerIn: parent

                    Image {
                        source: model.iconPath ? "file://" + model.iconPath : ""
                        sourceSize.width: 50
                        sourceSize.height: 50
                        visible: model.iconPath !== ""
                        smooth: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    // Fallback for missing icons
                    Rectangle {
                        width: 50
                        height: 50
                        color: "#CCC"
                        visible: model.iconPath === ""
                        radius: 4
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        text: model.title.slice(0, 20)
                        color: Config.textColor
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        Niri.focusWindow(model.id);
                    }
                    cursorShape: Qt.PointingHandCursor
                }
                HoverHandler {
                    onHoveredChanged: {
                        parent.border.width = hovered ? 2 : 0;
                    }
                }
            }
        }
        visible: windows ? windows.rowCount() > 0 : false
    }
    Text {
        anchors.centerIn: parent
        text: "Empty Workspace"
        color: Config.textColor
        font.bold: true
        font.pixelSize: 20
        visible: !hoverWsList.visible
    }
}
