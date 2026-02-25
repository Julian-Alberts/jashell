import QtQuick
import Quickshell
import Quickshell.Services.Mpris
import "../service"

Item {
    id: root
    property ShellScreen screen
    anchors.fill: parent
    implicitWidth: 50
    implicitHeight: 200
    Column {
        spacing: 10
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
        Repeater {
            /* Youtube does not remove the player but sets artist and title to null */
            model: Mpris.players.values.filter(player => player.trackArtist || player.trackTitle)
            delegate: MediaPlayer {
                width: parent.width
                player: modelData
            }
        }
    }
    Column {
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        bottomPadding: 10
        spacing: 10
        TaskList {
            screen: root.screen
            anchors {
                left: parent.left
                right: parent.right
            }
        }
        SystemTray {
            anchors {
                left: parent.left
                right: parent.right
            }
        }
    }
}
