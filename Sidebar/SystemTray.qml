import QtQuick
import Quickshell.Services.SystemTray
import Quickshell
import "../popup"
import "../Components/SystemTray" as SystemTrayComponents

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
            delegate: SystemTrayComponents.Item {
                handle: modelData
            }
        }
    }
}
