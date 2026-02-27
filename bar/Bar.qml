import QtQuick
import Quickshell
import "../service/"
import "../Config/"

Item {
    id: root
    property ShellScreen screen
    anchors.fill: parent
    anchors.rightMargin: 10
    anchors.leftMargin: 10
    anchors.topMargin: 5
    anchors.bottomMargin: 5
    Loader {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        sourceComponent: workspaceDelegate
        active: Settings.layout.topbar.showWorkspaces
    }
    Row {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        height: 20
        spacing: 20
        Media {
            anchors {
                top: parent.top
                bottom: parent.bottom
            }
            height: parent.height
        }
        Loader {
            anchors {
                top: parent.top
                bottom: parent.bottom
            }
            sourceComponent: Battery {}
            active: Settings.layout.topbar.showBattery
        }
        Loader {
            anchors {
                top: parent.top
                bottom: parent.bottom
            }
            sourceComponent: Clock {}
            active: Settings.layout.topbar.showClock
        }
        Loader {
            anchors {
                top: parent.top
                bottom: parent.bottom
            }
            sourceComponent: SystemTray {}
            active: Settings.layout.topbar.showSystemTray
        }
    }
    Component {
        id: workspaceDelegate
        Row {
            spacing: 10
            Workspaces {
                output: screen.name
                displayName: screen.name
            }
        }
    }
}
