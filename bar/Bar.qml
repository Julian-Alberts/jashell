import QtQuick
import "../service/"

Item {
    id: root
    anchors.fill: parent
    anchors.rightMargin: 10
    anchors.leftMargin: 10
    anchors.topMargin: 5
    anchors.bottomMargin: 5
    Row {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        spacing: 20
        Workspaces {
            multiple: true
            output: "eDP-1"
            displayName: "Main"
        }
    }
    Row {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: 20
        Media {}
        Battery {}
        Clock {}
    }
}
