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
    function getLayout(screen: ShellScreen): Layout {
        return layout;
    }
    component Layout: JsonObject {
        property TopBar topbar: TopBar {}
        property SideBar sidebar: SideBar {}
    }
    component TopBar: JsonObject {
        property bool showWorkspaces: true
        property bool showMediaControls: true
        property bool showSystemTray: true
        property bool showClock: true
        property bool showAudioControls: false
        property bool showBattery: true
        property TopBarComponents components: TopBarComponents {}
    }
    component TopBarComponents: JsonObject {
        property list<string> left: ["Workspaces"]
        property list<string> right: ["MediaPlayer", "AudioDevices", "Battery", "Clock", "SystemTray"]
    }
    component SideBar: JsonObject {
        property bool showWorkspaces: true
        property bool showMediaControls: true
        property bool showSystemTray: true
        property SideBarComponents components: SideBarComponents {}
    }
    component SideBarComponents: JsonObject {
        property list<string> top: ["MediaPlayer"]
        property list<string> bottom: ["Workspaces", "SystemTray"]
    }
}
