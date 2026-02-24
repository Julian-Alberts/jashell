import QtQuick
import Quickshell.Services.Pipewire
import "../service"

Item {
    property PwNode dev
    anchors.verticalCenter: parent.verticalCenter
    implicitWidth: contentLoader.implicitWidth
    implicitHeight: contentLoader.implicitHeight
    Loader {
        id: contentLoader
        sourceComponent: contentComponent
        active: dev !== null
    }
    Component {
        id: contentComponent
        Item {
            implicitWidth: row.implicitWidth
            implicitHeight: row.implicitHeight
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
                            family: "Font Awesome 7 Free Solid"
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
                                return "\uf6a9";
                            } else if (volume > .80) {
                                return "\uf028";
                            } else if (volume > .40) {
                                return "\uf6a8";
                            } else if (volume > .10) {
                                return "\uf027";
                            } else {
                                return "\uf026";
                            }
                        }
                        function sourceIcon(muted) {
                            if (muted) {
                                return "\uf131";
                            } else {
                                return "\uf130";
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
