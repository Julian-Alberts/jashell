import QtQuick

Item {
    id: root
    anchors.fill: parent
    Row {
        anchors.fill: parent
        spacing: 20
        Workspaces {
            output: "eDP-1"
        }
        Row {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 20
            anchors.leftMargin: 20
            spacing: 20
            Battery {}
            Clock {}
        }
    }
}
