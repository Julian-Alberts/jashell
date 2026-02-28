import QtQuick
import Quickshell.Services.Mpris
import Quickshell
import "../service"
import "../popup"
import "../Config/"
import "../Components/Ui"

Item {
    id: root
    property MprisPlayer player: Mpris.players.values.find(p => p.isPlaying) || Mpris.players.values[0] || null
    implicitWidth: row.implicitWidth
    Row {
        id: row
        spacing: 5
        anchors.verticalCenter: parent.verticalCenter
        Ticker {
            message: player ? `${player.trackArtist || "Unknown Artist"}: ${player.trackTitle || "Unknown Title"}` : ""
            speed: 20
            MouseArea {
                anchors.fill: parent
                onClicked: MediaPlayerPopup.toggle(root.player, root, Edges.Bottom | Edges.Left)
            }
        }
        Label {
            text: secsToTime(player.position) + " / " + secsToTime(player.length)
            visible: player.lengthSupported && player.positionSupported
            font.bold: true
            anchors.verticalCenter: parent.verticalCenter
            function secsToTime(secs) {
                const minutes = Math.floor(secs / 60);
                const seconds = Math.floor(secs % 60);
                return `${minutes}:${seconds.toString().padStart(2, '0')}`;
            }
        }
        // Previous Button
        Button {
            id: previousButton
            text: Config.theme.icons.media_previous
            font {
                family: Config.theme.icons.fontFamily
                pixelSize: 16
            }
            onClicked: root.player.next()
            enabled: root.player.canGoNext
        }
        // Play/Pause Button
        Button {
            text: root.player.isPlaying ? Config.theme.icons.media_pause : Config.theme.icons.media_play
            font: previousButton.font
            onClicked: root.player.togglePlaying()
            enabled: root.player.canPlay && root.player.canPause
        }
        // Next Button
        Button {
            id: nextButton
            text: Config.theme.icons.media_next
            font: previousButton.font
            onClicked: root.player.next()
            enabled: root.player.canGoNext
        }
    }
    Timer {
        running: player.isPlaying
        interval: 1000
        repeat: true
        onTriggered: {
            player.positionChanged();
        }
    }
    visible: !!player
}
