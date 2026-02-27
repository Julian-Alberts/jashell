import QtQuick
import Quickshell
import Quickshell.Services.Mpris
import "../service" as Service
import "../Config" as Config
import "../popup" as Popup

Item {
    id: root
    property ShellScreen screen
    anchors.fill: parent
    implicitWidth: 50
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton
        onClicked: ev => {
            Popup.Settings.visible = true;
            Popup.Settings.anchor.item = root;
            Popup.Settings.anchor.rect.y = ev.y - Popup.Settings.height / 2;
            Popup.Settings.anchor.edges = Edges.Right;
        }
    }
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
        active: Config.Settings.layout.sidebar.showMediaControls
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
            active: Service.Config.Settings.layout.sidebar.showWorkspaces
        }
        Loader {
            anchors {
                left: parent.left
                right: parent.right
            }
            sourceComponent: SystemTray {}
            active: Config.Settings.layout.sidebar.showSystemTray
        }
    }
}
