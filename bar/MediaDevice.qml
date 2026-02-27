import QtQuick
import QtQuick.Controls
import Quickshell.Services.Pipewire
import "../service"
import "../Config"

Item {
    id: root
    property PwNode dev
    width: contentLoader.implicitWidth
    Loader {
        id: contentLoader
        sourceComponent: contentComponent
        active: root.dev !== null
        height: parent.height
    }
    Component {
        id: contentComponent
        Item {
            implicitWidth: row.implicitWidth
            height: parent.height
            anchors.verticalCenter: parent.verticalCenter
            Row {
                id: row
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height
                spacing: 5
                Label {
                    id: icon
                    color: dev.audio.muted ? Theme.colors.red : palette.text
                    font {
                        family: Theme.fonts.icons
                        pixelSize: 15
                    }
                    anchors.verticalCenter: parent.verticalCenter
                    text: {
                        const muted = dev.audio.muted;
                        if (dev.isSink) {
                            const volume = dev.audio.volume;
                            return sinkIcon(muted, volume);
                        } else {
                            return sourceIcon(muted);
                        }
                    }
                    function sinkIcon(muted, volume) {
                        if (muted) {
                            return Theme.icons.volumeMuted;
                        } else if (volume > .80) {
                            return Theme.icons.volumeHigh;
                        } else if (volume > .40) {
                            return Theme.icons.volumeMedium;
                        } else if (volume > .10) {
                            return Theme.icons.volumeLow;
                        } else {
                            return Theme.icons.volumeOff;
                        }
                    }
                    function sourceIcon(muted) {
                        if (muted) {
                            return Theme.icons.microphoneMuted;
                        } else {
                            return Theme.icons.microphone;
                        }
                    }
                }
                Label {
                    anchors.verticalCenter: parent.verticalCenter
                    color: icon.color
                    font.bold: true
                    text: Math.round(dev.audio.volume * 100)
                }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    dev.audio.muted = !dev.audio.muted;
                }
                onWheel: {
                    const y = wheel.angleDelta.y;
                    if (y < .1 && y > -.1)
                        return;
                    let newVol = dev.audio.volume + (wheel.angleDelta.y > 0 ? .05 : -.05);
                    if (newVol > 1)
                        newVol = 1;
                    dev.audio.volume = newVol;
                }
            }
        }
    }
}
