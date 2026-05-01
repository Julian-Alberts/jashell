import QtQuick
import Quickshell.Services.Pipewire
import "../Components"

Row {
    id: root
    spacing: 10
    UnifiedAudioDevice {
        dev: Pipewire.defaultAudioSink
    }
    UnifiedAudioDevice {
        dev: Pipewire.defaultAudioSource
    }
}
