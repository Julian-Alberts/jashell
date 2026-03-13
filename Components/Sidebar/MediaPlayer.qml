import QtQuick
import QtQuick.Controls
import Quickshell.Services.Mpris
import Quickshell
import "../../service"
import "../../popup"
import "../../Config"
import "../Ui" as Ui

Rectangle {
    id: root
    property MprisPlayer player
    property QsWindow window
    implicitHeight: content.height
    color: "transparent"
    border {
        color: player.isPlaying ? Theme.colors.accent : Theme.colors.icon
        width: 2
    }
    radius: 5
    Column {
        id: content
        width: parent.width - root.border.width * 2
        height: content.implicitHeight + root.border.width * 2
        x: root.border.width
        y: root.border.width
        Image {
            id: trackArt
            width: parent.width
            height: parent.width
            source: root.player.trackArtUrl
            fillMode: Image.PreserveAspectFit
            ProgressBar {
                id: progressBar
                from: 0
                to: root.player.length
                value: root.player.position
                implicitHeight: 4
                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }
                background: Item {}
                contentItem: Rectangle {
                    color: root.border.color
                    width: parent.visualPosition * parent.width
                    height: parent.height
                }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: ev => {
                    MediaPlayerPopup.toggle(root.player, root.window, Edges.None, true);
                    const global = mapToGlobal(trackArt.x * 2 + trackArt.width, ev.y);
                    // Center the popup vertically on the click position and align it to the right of the track art
                    MediaPlayerPopup.anchor.rect.y = global.y - MediaPlayerPopup.height / 2;
                    MediaPlayerPopup.anchor.rect.x = global.x;
                }
                cursorShape: Qt.PointingHandCursor
            }
        }
        Column {
            id: controlsContainer
            anchors {
                left: parent.left
                right: parent.right
            }
            height: hoverHandler.hovered ? implicitHeight : 0
            clip: true
            Repeater {
                id: controlsRepeater
                model: [
                    {
                        icon: Config.theme.icons.media_previous,
                        enabled: root.player.canGoPrevious,
                        onClicked: root.player.previous
                    },
                    {
                        icon: Config.theme.icons.media_play,
                        enabled: root.player.canPlay && !root.player.isPlaying,
                        onClicked: root.player.play
                    },
                    {
                        icon: Config.theme.icons.media_pause,
                        enabled: root.player.canPause && root.player.isPlaying,
                        onClicked: root.player.pause
                    },
                    {
                        icon: Config.theme.icons.media_next,
                        enabled: root.player.canGoNext,
                        onClicked: root.player.next
                    }
                ].filter(button => button.enabled)
                delegate: Ui.Button {
                    height: controlsContainer.width
                    text: modelData.icon
                    font.pixelSize: 24
                    anchors.horizontalCenter: parent.horizontalCenter
                    onClicked: modelData.onClicked()
                }
            }
            Behavior on height {
                NumberAnimation {
                    duration: 200
                }
            }
        }
        HoverHandler {
            id: hoverHandler
        }
    }
}
