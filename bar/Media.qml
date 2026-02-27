import QtQuick
import Quickshell.Services.Pipewire
import Quickshell.Services.Mpris
import "../service"
import "../Config/"

Item {
    id: root
    implicitWidth: row.implicitWidth
    property var sink: Pipewire.defaultAudioSink
    property var source: Pipewire.defaultAudioSource
    Row {
        id: row
        spacing: 10
        height: parent.height
        Loader {
            anchors {
                top: parent.top
                bottom: parent.bottom
            }
            sourceComponent: MediaPlayer {}
            active: Settings.layout.topbar.showMediaControls
        }
        MediaDevice {
            anchors {
                top: parent.top
                bottom: parent.bottom
            }
            dev: root.sink
        }
        MediaDevice {
            anchors {
                top: parent.top
                bottom: parent.bottom
            }
            dev: root.source
        }
    }
    PwObjectTracker {
        objects: [root.sink, root.source]
    }
}
