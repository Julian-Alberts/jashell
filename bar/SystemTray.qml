import QtQuick
import Quickshell.Services.SystemTray
import Quickshell
import "../Components/SystemTray/" as SystemTrayComponents

ListView {
    id: root
    height: contentItem.childrenRect.height
    width: contentItem.childrenRect.width
    model: SystemTray.items.values
    spacing: 10
    orientation: ListView.Horizontal
    delegate: SystemTrayComponents.Item {
        popupEdges: Edges.Bottom
        handle: modelData
    }
}
