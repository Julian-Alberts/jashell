import QtQuick
import Quickshell.Services.Pipewire
import Quickshell.Services.Mpris
import "../service"

Item {
    id: root
    anchors {
        top: parent.top
        bottom: parent.bottom
    }
    implicitWidth: row.implicitWidth
    property var sink: Pipewire.defaultAudioSink
    property var source: Pipewire.defaultAudioSource
    Row {
        id: row
        spacing: 10
        MediaPlayer {}
        MediaDevice {
            dev: sink
        }
        MediaDevice {
            dev: source
        }
    }
    PwObjectTracker {
        objects: [sink, source];
    }
}
