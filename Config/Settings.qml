pragma Singleton
pragma ComponentBehavior: Bound
import QtQuick
import Quickshell.Io
import Quickshell

Singleton {
    property Layout layout: adapter.layout
    property string theme: adapter.theme
    property bool hotReload: adapter.hotReload
    property var data: adapter
    FileView {
        path: Qt.resolvedUrl("../settings.json")

        watchChanges: true
        onFileChanged: reload()
        onAdapterUpdated: writeAdapter()
        blockLoading: true

        JsonAdapter {
            id: adapter
            property Layout layout: Layout {}
            property string theme: "Tokyo Night"
            property bool hotReload: false
            onHotReloadChanged: {
                console.log("hotReload changed to", hotReload);
            }
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
