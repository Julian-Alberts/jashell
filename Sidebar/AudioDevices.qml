import QtQuick
import Quickshell.Services.Pipewire
import "../Components"

Column {
    id: root
    spacing: 10
    UnifiedAudioDevice {
        dev: Pipewire.defaultAudioSink
        isVertical: true
    }
    UnifiedAudioDevice {
        dev: Pipewire.defaultAudioSource
        isVertical: true
    }
}
