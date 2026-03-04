pragma Singleton
pragma ComponentBehavior: Bound
import QtQuick
import Quickshell.Io
import Quickshell

Singleton {
    id: root
    property Layout layout: adapter.layout
    property var layoutOverrides: ({})
    property string theme: adapter.theme
    property bool hotReload: adapter.hotReload
    property var data: adapter
    FileView {
        path: Qt.resolvedUrl("../settings.json")

        watchChanges: true
        onFileChanged: reload()
        onAdapterUpdated: writeAdapter()
        blockLoading: true
        onLoaded: {
            root.updateLayoutOverrides(adapter.layoutOverrides, adapter.layout);
        }

        JsonAdapter {
            id: adapter
            property Layout layout: Layout {}
            property string theme: "Tokyo Night"
            property bool hotReload: false
            property var layoutOverrides: []
        }
    }
    function updateLayoutOverrides(overrides: var, fallback: Layout) {
        root.layoutOverrides = {};
        if (!overrides)
            return;

        for (const override of overrides) {
            if (!override)
                continue;

            const screenName = override.screen ?? override.name;
            if (!screenName)
                continue;

            const comp = layoutOverrideComponent.createObject(root, {
                "screen": screenName,
                "fallback": fallback,
                "override": override
            });
            root.layoutOverrides[screenName] = comp;
        }
        root.layoutOverridesChanged();
    }
    function getLayout(screen: ShellScreen): Layout {
        const override = root.layoutOverrides[screen.name];
        const selectedLayout = override ? override : layout
        return selectedLayout;
    }
    Component {
        id: layoutOverrideComponent
        LayoutOverride {}
    }
    component Layout: JsonObject {
        property TopBar topbar: TopBar {}
        property SideBar sidebar: SideBar {}
    }
    component ScreenLayout: Layout {
        property string screen
    }
    component LayoutOverride: Layout {
        id: layout
        required property string screen
        required property Layout fallback
        property var override
        topbar: TopBar {
            components: TopBarComponents {
                left: layout.override?.topbar?.components?.left ? layout.override.topbar.components.left : layout.fallback.topbar.components.left
                right: layout.override?.topbar?.components?.right ? layout.override.topbar.components.right : layout.fallback.topbar.components.right
            }
        }
        sidebar: SideBar {
            components: SideBarComponents {
                top: layout.override?.sidebar?.components?.top ? layout.override.sidebar.components.top : layout.fallback.sidebar.components.top
                bottom: layout.override?.sidebar?.components?.bottom ? layout.override.sidebar.components.bottom : layout.fallback.sidebar.components.bottom
            }
        }
    }
    component TopBar: JsonObject {
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
