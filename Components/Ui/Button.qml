import QtQuick
import QtQuick.Controls as Controls

Controls.Button {
    id: root
    contentItem: Label {
        anchors.centerIn: parent
        text: root.text
    }
    background: Rectangle {
        color: palette.inactive.base
    }
    HoverHandler {
        cursorShape: Qt.PointingHandCursor
    }
}
