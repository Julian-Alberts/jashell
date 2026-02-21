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
        Battery {
            anchors.right: parent.right
        }
    }
}
