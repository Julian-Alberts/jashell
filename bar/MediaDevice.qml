import QtQuick
import Quickshell.Services.Pipewire
import "../service"

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
                spacing: 5
                Item {
                    implicitHeight: 20
                    implicitWidth: 20
                    Text {
                        id: icon
                        color: dev.audio.muted ? Config.red : Config.textColor
                        font {
                            family: Config.theme.icons.fontFamily
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
                                return Config.theme.icons.volumeMuted;
                            } else if (volume > .80) {
                                return Config.theme.icons.volumeHigh;
                            } else if (volume > .40) {
                                return Config.theme.icons.volumeMedium;
                            } else if (volume > .10) {
                                return Config.theme.icons.volumeLow;
                            } else {
                                return Config.theme.icons.volumeOff;
                            }
                        }
                        function sourceIcon(muted) {
                            if (muted) {
                                return Config.theme.icons.microphoneMuted;
                            } else {
                                return Config.theme.icons.microphone;
                            }
                        }
                    }
                }
                Item {
                    implicitWidth: 20
                    implicitHeight: 20
                    Text {
                        anchors.right: parent.right
                        color: icon.color
                        text: Math.round(dev.audio.volume * 100)
                    }
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
