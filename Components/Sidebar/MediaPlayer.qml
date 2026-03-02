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
                onClicked: {
                    MediaPlayerPopup.toggle(root.player, trackArt, Edges.Right | Edges.Top);
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
            height: hoverHandler.hovered ? childrenRect.height : 0
            clip: true
            Repeater {
                id: controlsRepeater
                model: [
                    {
                        icon: Config.theme.icons.media_previous,
                        enabled: root.player.canGoPrevious,
                        onClicked: root.player.goPrevious
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
                        onClicked: root.player.goNext
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
