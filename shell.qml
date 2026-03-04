//@ pragma UseQApplication
import Quickshell.Bluetooth
import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Controls
import "./bar"
import "./Sidebar/"
import "./service/"
import "./Config/"

ShellRoot {
    Variants {
        model: Quickshell.screens.filter(s => Settings.getLayout(s).topbar.enabled)
        delegate: PanelWindow {
            id: topBar
            property var modelData
            property Settings.TopBar settings: Settings.getLayout(modelData).topbar
            screen: modelData
            anchors {
                top: settings.position === "top"
                bottom: settings.position === "bottom"
                left: true
                right: true
            }
            Component.onCompleted: {
                console.log("Top Pos", settings.position);
            }
            implicitHeight: 30
            Bar {
                palette: Theme.palette
                screen: topBar.modelData
                height: parent.height
            }
        }
    }
    Variants {
        model: Quickshell.screens.filter(s => Settings.getLayout(s).sidebar.enabled)
        delegate: PanelWindow {
            id: sideBar
            property Settings.SideBar settings: Settings.getLayout(modelData).sidebar
            property var modelData
            screen: modelData
            anchors {
                top: true
                left: settings.position === "left"
                right: settings.position === "right"
                bottom: true
            }
            Component.onCompleted: {
                console.log("Pos", settings.position);
            }
            implicitWidth: 50
            color: Config.theme.colors.background
            Sidebar {
                anchors.fill: parent
                screen: sideBar.modelData
            }
        }
    }
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
    }
}
