import QtQuick
import QtQuick.Controls as Controls
import "../../Config"

Controls.Button {
    id: root
    contentItem: Label {
        anchors.centerIn: parent
        text: root.text
        color: Theme.colors.text
    }
    background: Rectangle {
        color: Theme.colors.background
    }
    HoverHandler {
        cursorShape: Qt.PointingHandCursor
    }
}
