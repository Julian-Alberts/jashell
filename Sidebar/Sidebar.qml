import QtQuick
import Quickshell
import Quickshell.Services.Mpris
import "../service"
import "../Config/"

Item {
    id: root
    property ShellScreen screen
    anchors.fill: parent
    implicitWidth: 50
    implicitHeight: 200
    Loader {
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
        sourceComponent: Column {
            spacing: 10
            Repeater {
                /* Youtube does not remove the player but sets artist and title to null */
                model: Mpris.players.values.filter(player => player.trackArtist || player.trackTitle)
                delegate: MediaPlayer {
                    width: parent.width
                    player: modelData
                }
            }
        }
        active: Settings.layout.sidebar.showMediaControls
    }
    Column {
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        spacing: 10
        Loader {
            anchors {
                left: parent.left
                right: parent.right
            }
            sourceComponent: TaskList {
                screen: root.screen
            }
            active: Settings.layout.sidebar.showWorkspaces
        }
        Loader {
            anchors {
                left: parent.left
                right: parent.right
            }
            sourceComponent: SystemTray {}
            active: Settings.layout.sidebar.showSystemTray
        }
    }
}
