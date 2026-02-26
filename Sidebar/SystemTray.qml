import QtQuick
import Quickshell.Services.SystemTray
import Quickshell
import "../popup"

Item {
    id: root
    height: list.height
    Grid {
        id: list
        columns: 2
        spacing: 5
        anchors {
            left: parent.left
            right: parent.right
        }
        Repeater {
            model: SystemTray.items.values
            delegate: Image {
                id: icon
                source: modelData.icon
                sourceSize.width: 20
                sourceSize.height: 20
                width: 20
                height: 20
                MouseArea {
                    acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                    anchors.fill: parent
                    onClicked: ev => {
                        switch (ev.button) {
                        case Qt.LeftButton:
                            if (!modelData.onlyMenu) {
                                modelData.activate();
                                break;
                            }
                        case Qt.RightButton:
                            if (!modelData.hasMenu)
                                break;
                            SystemTrayMenu.menu = modelData.menu;
                            SystemTrayMenu.anchor.item = icon;
                            SystemTrayMenu.visible = true;
                            SystemTrayMenu.edges = Edges.Right;
                            break;
                        case Qt.MiddleButton:
                            modelData.secondaryActivate();
                            break;
                        default:
                            console.warn("Unknown button " + ev.button + " clicked on " + modelData.id);
                        }
                    }
                }
            }
        }
    }
}
