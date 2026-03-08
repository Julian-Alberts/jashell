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
    property RotateScreen rotateScreen: adapter.rotateScreen
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
            property RotateScreen rotateScreen: RotateScreen {}
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

            let comp = root.layoutOverrides[screenName];
            if (comp) {
                comp.override = override;
            } else {
                comp = layoutOverrideComponent.createObject(root, {
                    "screen": screenName,
                    "fallback": fallback,
                    "override": override
                });
                root.layoutOverrides[screenName] = comp;
            }
        }
        root.layoutOverridesChanged();
    }
    function getLayout(screen: ShellScreen): Layout {
        const override = root.layoutOverrides[screen.name];
        if (!override) {
            root.layoutOverrides[screen.name] = layoutOverrideComponent.createObject(root, {
                "screen": screen.name,
                "fallback": root.layout
            });
            return root.layoutOverrides[screen.name];
        }
        return override;
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
            id: topbarLayout
            property var topbarOverride: layout.override?.topbar || layout.fallback.topbar
            property TopBar fallbackTopBar: layout.fallback.topbar
            enabled: (typeof topbarOverride.enabled === "boolean") ? topbarOverride.enabled : fallbackTopBar.enabled
            position: topbarOverride?.position ? topbarOverride.position : fallbackTopBar.position
            components: TopBarComponents {
                property var componentsOverride: topbarLayout.topbarOverride.components || topbarLayout.fallbackTopBar.components
                property TopBarComponents fallbackComponents: layout.fallback.topbar.components
                left: componentsOverride?.left ? componentsOverride.left : fallbackComponents.left
                right: componentsOverride?.right ? componentsOverride.right : fallbackComponents.right
            }
        }
        sidebar: SideBar {
            id: sidebarLayout
            property var sideBarOverride: layout.override?.sidebar || layout.fallback.sidebar
            property SideBar fallbackSideBar: layout.fallback.sidebar
            enabled: (typeof sideBarOverride.enabled === "boolean") ? sideBarOverride.enabled : fallbackSideBar.enabled
            position: sideBarOverride.position ? sideBarOverride.position : fallbackSideBar.position
            components: SideBarComponents {
                property var componentsOverride: sidebarLayout.sideBarOverride.components || sidebarLayout.fallbackSideBar.components
                property SideBarComponents fallbackComponents: sidebarLayout.fallbackSideBar.components
                top: componentsOverride.top || fallbackComponents.top
                center: componentsOverride.center || fallbackComponents.center
                bottom: componentsOverride.bottom || fallbackComponents.bottom
            }
        }
    }
    component TopBar: JsonObject {
        property bool enabled: true
        property string position: "top"
        property TopBarComponents components: TopBarComponents {}
    }
    component TopBarComponents: JsonObject {
        property list<string> left: ["Workspaces"]
        property list<string> right: ["MediaPlayer", "AudioDevices", "Battery", "Clock", "SystemTray"]
    }
    component SideBar: JsonObject {
        property bool enabled: true
        property string position: "left"
        property SideBarComponents components: SideBarComponents {}
    }
    component SideBarComponents: JsonObject {
        property list<string> top: ["MediaPlayer"]
        property list<string> center: []
        property list<string> bottom: ["Workspaces", "SystemTray"]
    }

    component RotateScreen: JsonObject {
        property list<string> rotations: ["normal", "90"]
    }
}
