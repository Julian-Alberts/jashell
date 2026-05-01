import QtQuick
import QtQuick.Controls
import Quickshell.Services.Pipewire
import "../Config"

Loader {
    id: root
    property PwNode dev
    property bool isVertical: false
    sourceComponent: audioDeviceComponent
    active: root.dev !== null
    anchors {
        left: isVertical ? parent.left : undefined
        right: isVertical ? parent.right : undefined
        top: !isVertical ? parent.top : undefined
        bottom: !isVertical ? parent.bottom : undefined
    }
    Binding {
        target: root.item
        property: "isVertical"
        value: root.isVertical
        when: root.item && root.item.hasOwnProperty("isVertical")
    }
    Binding {
        target: root.item
        property: "dev"
        value: root.dev
        when: root.item && root.item.hasOwnProperty("dev")
    }
    Component {
        id: audioDeviceComponent
        Grid {
            id: grid
            property PwNode dev
            property bool isVertical
            columns: root.isVertical ? 1 : 2
            spacing: 5
            Label {
                id: icon
                width: grid.isVertical ? parent.width : undefined
                color: dev.audio.muted ? Theme.colors.red : Theme.colors.text
                font {
                    family: Theme.fonts.icons
                    pixelSize: 15
                }
                horizontalAlignment: grid.isVertical ? Text.AlignHCenter : Text.AlignLeft
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
                color: icon.color
                font.bold: true
                text: Math.round(dev.audio.volume * 100)
                horizontalAlignment: icon.horizontalAlignment
                width: icon.width
            }
        }
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.dev.audio.muted = !root.dev.audio.muted;
        }
        onWheel: {
            const y = wheel.angleDelta.y;
            if (y < .1 && y > -.1)
                return;
            let newVol = root.dev.audio.volume + (wheel.angleDelta.y > 0 ? .05 : -.05);
            if (newVol > 1)
                newVol = 1;
            root.dev.audio.volume = newVol;
        }
        enabled: root.dev !== null
    }
}
