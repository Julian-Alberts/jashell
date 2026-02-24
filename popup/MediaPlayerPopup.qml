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
                        anchors.centerIn: parent
                        id: trackArt
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
                    Rectangle {
                        color: "transparent"
                        implicitWidth: 13
                        implicitHeight: parent.controlsHight
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
                        implicitHeight: parent.controlsHight
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
                        implicitHeight: parent.controlsHight
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
            }
        }
    }
}
