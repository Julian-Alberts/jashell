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
    onPlayerChanged: {
        if (player) {
            positionTimer.restart()
        } else {
            positionTimer.stop()
        }
    }
    Row {
        id: row
        spacing: 5
        anchors.verticalCenter: parent.verticalCenter
        Ticker {
            message: player ? `${player.trackArtist || "Unknown Artist"}: ${player.trackTitle || "Unknown Title"}` : ""
            speed: 20
            MouseArea {
                anchors.fill: parent
                onClicked: popup.visible = true
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
        Rectangle {
            color: "transparent"
            implicitWidth: 13
            implicitHeight: parent.height
            Text {
                font.family: "Font Awesome 7 Free Solid"
                text: "\uf048"
                color: Config.textColor
                font.pixelSize: 16
                anchors.centerIn: parent
                 MouseArea {
                    anchors.fill: parent
                    onClicked: player.previous()
                }
            }
            visible: player.canGoPrevious
        }
        Rectangle {
            color: "transparent"
            implicitWidth: 15
            implicitHeight: parent.implicitHeight
            Text {
                font.family: "Font Awesome 7 Free Solid"
                text: player.playbackState === MprisPlaybackState.Playing ? "\uf04c" : "\uf04b"
                color: Config.textColor
                font.pixelSize: 16
                anchors.centerIn: parent
                MouseArea {
                    anchors.fill: parent
                    onClicked: player.togglePlaying()
                }
            }
            visible: player.canPlay
        }
        Rectangle {
            color: "transparent"
            implicitWidth: 13
            implicitHeight: parent.height
            Text {
                font.family: "Font Awesome 7 Free Solid"
                text: "\uf051"
                color: Config.textColor
                font.pixelSize: 16
                anchors.centerIn: parent
                MouseArea {
                    anchors.fill: parent
                    onClicked: player.next()
                }
            }
            visible: player.canGoNext
        }
    }
    MediaPlayerPopup {
        id: popup
        player: root.player
        anchor {
            item: root
            edges: Edges.Bottom | Edges.Left
        }
    }
    Timer {
        running: player.isPlaying
        interval: 1000
        repeat: true
        onTriggered: { 
            player.positionChanged() 
        }
    }
    visible: player !== undefined
}
