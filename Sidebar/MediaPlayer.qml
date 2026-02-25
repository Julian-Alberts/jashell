import QtQuick
import QtQuick.Controls
import Quickshell.Services.Mpris
import Quickshell
import "../service"
import "../popup"

Item {
    id: root
    property MprisPlayer player
    implicitHeight: content.implicitHeight
    Column {
        id: content
        spacing: 10
        width: parent.width
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
                anchors.fill: parent
                background: Item {}
                contentItem: Rectangle {
                    color: "#C0565f89"
                    width: progressBar.visualPosition * parent.width
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
            visible: hoverHandler.hovered
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
                delegate: Text {
                    text: modelData.icon
                    color: Config.theme.colors.text
                    font.pixelSize: 24
                    anchors.horizontalCenter: parent.horizontalCenter
                    MouseArea {
                        anchors.fill: parent
                        onClicked: modelData.onClicked()
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }
        }
        HoverHandler {
            id: hoverHandler
        }
    }
}
