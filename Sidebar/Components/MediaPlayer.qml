import QtQuick
import Quickshell.Services.Mpris
import "../../Components/Sidebar"
import "../../service"

Column {
    spacing: 10
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
            player: modelData
        }
    }
}
