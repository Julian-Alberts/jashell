import QtQuick
import Quickshell
import "../service/"

Item {
    id: root
    property ShellScreen screen
    anchors.fill: parent
    anchors.rightMargin: 10
    anchors.leftMargin: 10
    anchors.topMargin: 5
    anchors.bottomMargin: 5
    Row {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        spacing: 10
        Workspaces {
            output: screen.name
            displayName: screen.name
        }
    }
    Row {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: 20
        Media {}
        Battery {}
        Clock {}
        SystemTray {}
    }
}
