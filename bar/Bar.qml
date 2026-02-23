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
        spacing: 10
        Workspaces {
            multiple: true
            output: "DP-1"
            displayName: "Main"
        }
        Workspaces {
            multiple: true
            output: "HDMI-A-1"
            displayName: "Secondary"
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
