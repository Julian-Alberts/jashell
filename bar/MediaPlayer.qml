import QtQuick
import QtQuick.Controls
import Quickshell.Services.Mpris
import Quickshell
import "../service"
import "../popup"

Item {
    id: root
    property MprisPlayer player: Mpris.players.values.find(p => p.isPlaying) || Mpris.players.values[0] || null
    anchors {
        top: parent.top
        bottom: parent.bottom
    }
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
        Text {
            text: secsToTime(player.position) + " / " + secsToTime(player.length)
            visible: player.lengthSupported && player.positionSupported
            color: Config.textColor
            font.bold: true
            function secsToTime(secs) {
                const minutes = Math.floor(secs / 60);
                const seconds = Math.floor(secs % 60);
                return `${minutes}:${seconds.toString().padStart(2, '0')}`;
            }
        }
        Loader {
            sourceComponent: mediaButtonComponent
            onLoaded: {
                item.icon = Config.theme.icons.media_previous;
                item.enabled = root.player.canGoPrevious;
                item.onClicked = root.player.previous;
            }
        }
        Loader {
            sourceComponent: mediaButtonComponent
            onLoaded: {
                item.icon = Config.theme.icons.media_pause;
                item.enabled = root.player.canPause;
                item.onClicked = root.player.pause;
            }
            visible: root.player.isPlaying
            active: root.player.isPlaying
        }
        Loader {
            sourceComponent: mediaButtonComponent
            onLoaded: {
                item.icon = Config.theme.icons.media_play;
                item.enabled = root.player.canPlay;
                item.onClicked = root.player.play;
            }
            visible: !root.player.isPlaying
            active: !root.player.isPlaying
        }
        Loader {
            sourceComponent: mediaButtonComponent
            onLoaded: {
                item.icon = Config.theme.icons.media_next;
                item.enabled = player.canGoNext;
                item.onClicked = player.next;
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
        Item {
            id: root
            property string icon
            property bool enabled
            property var onClicked
            implicitWidth: 20
            implicitHeight: 20
            Text {
                font.family: Config.theme.icons.fontFamily
                text: root.icon
                color: root.enabled ? Config.textColor : Config.theme.colors.icon
                font.pixelSize: 16
                anchors.centerIn: parent
                MouseArea {
                    enabled: root.enabled
                    anchors.fill: parent
                    onClicked: root.onClicked()
                    cursorShape: root.enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
                }
            }
        }
    }
    visible: !!player
}
