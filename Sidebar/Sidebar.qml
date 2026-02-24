import QtQuick
import Quickshell
import Quickshell.Services.Mpris

Item {
    id: root
    property ShellScreen screen
    anchors.fill: parent
    implicitWidth: 50
    implicitHeight: 200
    Column {
        anchors.fill: parent
        Repeater {
            model: Mpris.players.values.filter(player => player.trackArtist || player.trackTitle)
            delegate: MediaPlayer {
                width: parent.width
                player: modelData
            }
        }
    }
}
