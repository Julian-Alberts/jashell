pragma Singleton
import QtQuick
import Quickshell.Io
import Quickshell

Singleton {
    property var layout: adapter.layout
    property string theme: adapter.theme
    property bool themeHotReload: adapter.themeHotReload
    FileView {
        path: Qt.resolvedUrl("../settings.json")
        watchChanges: true
        onFileChanged: reload()
        blockLoading: true
        JsonAdapter {
            id: adapter
            property Layout layout: Layout {}
            property string theme: "Tokyo Night"
            property bool hotReload: false
        }
    }
    component Layout: JsonObject {
        property JsonObject topbar: JsonObject {
            property bool showWorkspaces: true
            property bool showMediaControls: true
            property bool showSystemTray: true
            property bool showClock: true
            property bool showAudioControls: false
            property bool showBattery: true
        }
        property JsonObject sidebar: JsonObject {
            property bool showWorkspaces: true
            property bool showMediaControls: true
            property bool showSystemTray: true
        }
    }
}
