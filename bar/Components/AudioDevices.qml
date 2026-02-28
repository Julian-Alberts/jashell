import QtQuick
import Quickshell.Services.Pipewire
import "../../Components"

Row {
    id: root
    spacing: 10
    property var sink: Pipewire.defaultAudioSink
    property var source: Pipewire.defaultAudioSource
    AudioDevice {
        anchors {
            top: parent.top
            bottom: parent.bottom
        }
        dev: root.sink
    }
    AudioDevice {
        anchors {
            top: parent.top
            bottom: parent.bottom
        }
        dev: root.source
    }
}
