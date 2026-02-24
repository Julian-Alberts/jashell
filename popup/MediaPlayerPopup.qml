import Quickshell
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Controls
import "../service"
import "../bar"

JaPopupWindow {
    id: root
    property MprisPlayer player: null
    implicitWidth: 350
    implicitHeight: playerLoader.implicitHeight || 100
    Loader {
        id: playerLoader
        active: root.player !== null && root.visible
        sourceComponent: contentComponent
    }
    Component {
        id: contentComponent
        Item {
            id: content
            anchors.centerIn: parent
            implicitWidth: 350
            implicitHeight: column.implicitHeight
            visible: root.player !== null
            Column {
                id: column
                spacing: 10
                padding: 20
                Text {
                    text: root.player.trackTitle || "Unknown Title"
                    anchors.horizontalCenter: column.horizontalCenter
                    color: Config.textColor
                    font.pixelSize: 20
                    font.bold: true
                }
                Text {
                    text: root.player.trackArtist || "Unknown Artist"
                    anchors.horizontalCenter: column.horizontalCenter
                    color: Config.icon
                    font.pixelSize: 16
                    font.bold: true
                }
                Item {
                    implicitHeight: 200
                    implicitWidth: 200
                    anchors.horizontalCenter: column.horizontalCenter
                    Image {
                        id: trackArt
                        anchors.centerIn: parent
                        source: root.player.trackArtUrl
                        fillMode: Image.PreserveAspectFit
                        visible: source !== ""
                        smooth: true
                        onStatusChanged: {
                            visible = (status === Image.Ready);
                        }
                    }
                    Rectangle {
                        color: Config.icon
                        anchors.fill: parent
                        visible: !trackArt.visible
                    }
                }
                Row {
                    anchors.horizontalCenter: column.horizontalCenter
                    visible: root.player.lengthSupported && root.player.positionSupported
                    Text {
                        text: parent.secsToTime(root.player?.position)
                        color: Config.textColor
                        font.bold: true
                    }
                    Text {
                        text: " / "
                        color: Config.textColor
                        font.bold: true
                    }
                    Text {
                        text: parent.secsToTime(root.player?.length)
                        color: Config.textColor
                        font.bold: true
                    }
                    function secsToTime(secs) {
                        const minutes = Math.floor(secs / 60);
                        const seconds = Math.floor(secs % 60);
                        return `${minutes}:${seconds.toString().padStart(2, '0')}`;
                    }
                }
                Row {
                    spacing: 20
                    property int controlsHight: 30
                    anchors.horizontalCenter: column.horizontalCenter
                    Repeater {
                        model: [
                            {
                                icon: Config.theme.icons.mediaShuffle,
                                supported: root.player.shuffleSupported && root.player.canControl,
                                onClicked: () => root.player.shuffle = !root.player.shuffle
                            },
                            {
                                icon: Config.theme.icons.media_previous,
                                supported: root.player.canGoPrevious,
                                onClicked: root.player.previous
                            },
                            {
                                icon: root.player.isPlaying ? Config.theme.icons.media_pause : Config.theme.icons.media_play,
                                supported: root.player.canPlay && root.player.canPause,
                                onClicked: root.player.togglePlaying
                            },
                            {
                                icon: Config.theme.icons.media_next,
                                supported: root.player.canGoNext,
                                onClicked: root.player.next
                            },
                            {
                                icon: Config.theme.icons.mediaRepeat,
                                supported: root.player.loopStatusSupported && root.player.canControl,
                                onClicked: () => {
                                    if (root.player.loopStatus === MprisPlayer.LoopStatus.None) {
                                        root.player.loopStatus = MprisPlayer.LoopStatus.Track;
                                    } else if (root.player.loopStatus === MprisPlayer.LoopStatus.Track) {
                                        root.player.loopStatus = MprisPlayer.LoopStatus.Playlist;
                                    } else {
                                        root.player.loopStatus = MprisPlayer.LoopStatus.None;
                                    }
                                }
                            }
                        ].filter(button => button.supported)
                        delegate: Item {
                            implicitWidth: 20
                            implicitHeight: 30
                            Text {
                                font.family: Config.theme.icons.fontFamily
                                text: modelData.icon
                                color: Config.theme.colors.text
                                font.pixelSize: 16
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: modelData.onClicked()
                                    cursorShape: Qt.PointingHandCursor
                                }
                            }
                        }
                    }
                    Text {
                        id: volumeIcon
                        visible: root.player.volumeSupported && root.player.canControl
                        font.family: Config.theme.icons.fontFamily
                        text: Config.theme.icons.volumeHigh
                        color: Config.theme.colors.text
                        font.pixelSize: 16
                        MouseArea {
                            anchors.fill: parent
                            onClicked: volumeSlider.visible = !volumeSlider.visible
                            cursorShape: Qt.PointingHandCursor
                        }
                        Slider {
                            id: volumeSlider
                            from: 0
                            to: 1
                            value: root.player.volume
                            onValueChanged: {
                                root.player.volume = value;
                            }
                            orientation: Qt.Vertical
                            implicitWidth: 20
                            implicitHeight: 100
                            anchors {
                                horizontalCenter: parent.horizontalCenter
                            }
                            y: parent.y - 10 - implicitHeight
                            background: Rectangle {
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: 4
                                color: Config.icon
                            }
                            handle: Rectangle {
                                anchors {
                                    left: parent.left
                                    right: parent.right
                                }
                                color: Config.textColor
                                y: volumeSlider.visualPosition * volumeSlider.height - 5
                                height: 10
                                /*implicitHeight: parent.height * volumeSlider.visualPosition*/
                            }
                            visible: false
                            HoverHandler {
                                onHoveredChanged: {
                                    if (volumeSlider.visible && !hovered) {
                                        volumeSlider.visible = false;
                                    }
                                }
                            }
                        }
                    }
                }
                ProgressBar {
                    implicitWidth: 350 - 40
                    implicitHeight: 10
                    value: root.player?.position
                    from: 0
                    to: root.player?.length
                    background: Rectangle {
                        anchors.fill: parent
                        color: Config.icon
                        radius: 3
                    }
                    contentItem: Item {
                        anchors.fill: parent
                        Rectangle {
                            width: parent.parent.visualPosition * parent.parent.width
                            height: parent.height
                            radius: 2
                            color: Config.textColor
                        }
                    }
                }
                Component {
                    id: mediaButtonDelegate
                    Rectangle {
                        id: root
                        property string icon
                        property var onClicked
                        property bool enabled

                        color: "transparent"
                        implicitWidth: 13
                        visible: enabled
                    }
                }
            }
        }
    }
}
