pragma Singleton
import Quickshell.Services.Mpris
import QtQuick

QtObject {
    id: root

    readonly property var players: Mpris.players

    property var playerTimers: []

    onPlayersChanged: updatePlayerTimers()

    function updatePlayerTimers() {
        playerTimers.forEach(timer => timer.destroy())
        playerTimers = Mpris.players.values.map(player => {
            const timer = playerTimerComponent.createObject(root, { player })
            if (!timer) {
                console.error("Failed to create timer for player", player)
            }
            return timer
        })
    }

    property Component playerTimerComponent: Component {
        Timer {
            required property MprisPlayer player
            running: player.playbackState == MprisPlaybackState.Playing
            interval: 1000
            repeat: true
            onTriggered: player.positionChanged()
            triggeredOnStart: true
            Component.onCompleted: player.positionChanged()
        }
    }

}
