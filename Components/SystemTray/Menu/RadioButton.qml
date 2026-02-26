import QtQuick
import QtQuick.Controls
import "." as Menu

Menu.Base {
    id: root
    implicitHeight: contentRow.height
    implicitWidth: contentRow.width
    Row {
        id: contentRow
        RadioButton {
            checked: root.handle.checkState
        }
        Text {
            text: root.handle.text
            color: root.currentTextColor
        }
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.handle.triggered();
            console.log("Clicked checkbox " + root.handle.text);
        }
        cursorShape: Qt.PointingHandCursor
    }
}
