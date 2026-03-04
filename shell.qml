//@ pragma UseQApplication
import Quickshell.Bluetooth
import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Controls
import "./bar"
import "./Sidebar/"
import "./service/" as Service
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
            implicitWidth: 50
            color: Config.theme.colors.background
            Sidebar {
                anchors.fill: parent
                screen: sideBar.modelData
            }
            Component.onCompleted: {
                console.log(Service.Cpu.cpuData);
            }
        }
    }
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
    }
}
