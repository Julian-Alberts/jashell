import QtQuick
import QtQuick.Controls
import "." as Menu
import "../../../service"

Menu.Base {
    id: root
    implicitHeight: contentRow.height
    implicitWidth: contentRow.width
    Row {
        id: contentRow
        spacing: 5
        CheckBox {
            id: checkBox
            height: 14
            width: 14
            checkState: root.handle.checkState
            anchors.verticalCenter: parent.verticalCenter
            indicator: Rectangle {
                anchors.centerIn: parent
                width: 16
                height: width
                color: parent.checked ? Config.theme.colors.green : root.currentBackgroundColor
                border {
                    width: 1
                    color: root.currentTextColor
                }
            }
        }
        Text {
            text: root.handle.text
            color: root.currentTextColor
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 14
        }
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            checkBox.checked = !checkBox.checked;
            root.handle.triggered();
            console.log("Clicked checkbox " + checkBox.checked);
        }
        cursorShape: Qt.PointingHandCursor
        enabled: root.handle.enabled
    }
}
