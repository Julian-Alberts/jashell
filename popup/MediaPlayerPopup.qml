import Quickshell
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Controls
import "../service"
import "../bar"

JaPopupWindow {
    id: root
    property MprisPlayer player: null
    implicitWidth: 300
    implicitHeight: content.implicitHeight + 20
    Item {
        id: content
        anchors.centerIn: parent
        implicitWidth: column.implicitWidth
        implicitHeight: column.implicitHeight
        Column {
            id: column
            spacing: 20
            padding: 10
            Ticker {
                message: player ? `${player.trackArtist || "Unknown Artist"}: ${player.trackTitle || "Unknown Title"}` : "Empty"
                anchors.horizontalCenter: column.horizontalCenter
                implicitHeight: 20
                maxWidth: 280
            }
            Image {
                id: trackArt
                source: player && player.trackArtUrl
                fillMode: Image.PreserveAspectFit
                visible: source !== ""
                width: 250
                anchors.horizontalCenter: column.horizontalCenter
                onStatusChanged: {
                    visible = (status === Image.Ready);
                }
            }
            Rectangle {
                color: Config.icon
                implicitWidth: 280
                implicitHeight: implicitWidth
                visible: !trackArt.visible 
            }
            Row {
                anchors.horizontalCenter: column.horizontalCenter
                visible: player.lengthSupported && player.positionSupported
                Text {
                    text: parent.secsToTime(player.position)
                    color: Config.textColor
                    font.bold: true
                }
                Text {
                    text: " / "
                    color: Config.textColor
                    font.bold: true
                }
                Text {
                    text: parent.secsToTime(player.length)
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
                implicitWidth: 280
                implicitHeight: 10
                value: player.position
                from: 0
                to: player.length
            }
        }
    }
}
