import QtQuick
import Quickshell
import Quickshell.Services.Mpris
import "../Components/Sidebar"
import "../service"

Column {
    id: root
    spacing: 10
    property QsWindow window
    anchors {
        left: parent.left
        right: parent.right
    }
    Repeater {
        /* Youtube does not remove the player but sets artist and title to null */
        model: MprisService.players.values.filter(player => player.trackArtist || player.trackTitle)
        delegate: MediaPlayer {
            required property MprisPlayer modelData
            width: parent.width
            window: root.window
            player: modelData
        }
    }
}
