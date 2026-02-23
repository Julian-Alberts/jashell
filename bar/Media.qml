import QtQuick
import Quickshell.Services.Pipewire
import "../service"

Item {
    anchors {
        top: parent.top
        bottom: parent.bottom
    }
    implicitWidth: row.implicitWidth
    Row {
        id: row
        spacing: 10
        MediaDevice {
            dev: Pipewire.defaultAudioSink
        }
        MediaDevice {
            dev: Pipewire.defaultAudioSource
        }
    }
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
    }
}
