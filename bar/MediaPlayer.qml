import QtQuick
import QtQuick.Controls
import Quickshell.Services.Mpris
import Quickshell
import "../service"
import "../popup"
import "../Config/"

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
        Loader {
            id: previousLoader
            sourceComponent: mediaButtonComponent
            onLoaded: {
                item.clickAction = root.player.previous;
            }
            Binding {
                target: previousLoader.item
                property: "text"
                value: Config.theme.icons.media_previous
            }
            Binding {
                target: previousLoader.item
                property: "enabled"
                value: root.player.canGoPrevious
            }
        }
        Loader {
            id: pauseLoader
            sourceComponent: mediaButtonComponent
            onLoaded: {
                item.clickAction = root.player.pause;
            }
            Binding {
                target: pauseLoader.item
                property: "text"
                value: Config.theme.icons.media_pause
            }
            Binding {
                target: previousLoader.item
                property: "enabled"
                value: root.player.canPause
            }
            visible: root.player.isPlaying
            active: root.player.isPlaying
        }
        Loader {
            id: playLoader
            sourceComponent: mediaButtonComponent
            onLoaded: {
                item.clickAction = root.player.play;
            }
            Binding {
                target: playLoader.item
                property: "text"
                value: Config.theme.icons.media_play
            }
            Binding {
                target: playLoader.item
                property: "enabled"
                value: root.player.canPlay
            }
            visible: !root.player.isPlaying
            active: !root.player.isPlaying
        }
        Loader {
            id: nextLoader
            sourceComponent: mediaButtonComponent
            onLoaded: {
                item.clickAction = root.player.next;
            }
            Binding {
                target: nextLoader.item
                property: "text"
                value: Config.theme.icons.media_next
            }
            Binding {
                target: nextLoader.item
                property: "enabled"
                value: root.player.canGoNext
            }
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
    Component {
        id: mediaButtonComponent
        Button {
            id: root
            property bool enabled
            property var clickAction
            implicitWidth: 20
            contentItem: Label {
                font.family: Config.theme.icons.fontFamily
                text: root.text
                font.pixelSize: 16
                anchors.centerIn: parent
            }
            background: Rectangle {
                color: palette.base
            }
            onClicked: clickAction()
        }
    }
    visible: !!player
}
