import QtQuick
import QtQuick.Controls
import Quickshell
import "../Config/"
import "./Components"
import "../Components"

Pane {
    id: root
    property ShellScreen screen
    property Settings.Layout layout: Settings.getLayout(screen)
    anchors.fill: parent
    DynCompRow {
        componentNames: root.layout.topbar.components.left
        screen: root.screen
        anchors.left: parent.left
    }
    DynCompRow {
        componentNames: root.layout.topbar.components.right
        screen: root.screen
        anchors.right: parent.right
    }
    component DynCompRow: Row {
        id: root
        required property list<string> componentNames
        required property ShellScreen screen
        anchors {
            verticalCenter: parent.verticalCenter
        }
        height: 20
        spacing: 20
        Repeater {
            model: root.componentNames
            DynComponent {
                id: leftLoader
                required property string modelData
                namespace: "bar"
                name: modelData
                screen: root.screen
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                }
                onLoaded: {
                    if (leftLoader.modelData === "Workspaces") {
                        item.settings.screen = root.screen;
                    }
                }
            }
        }
    }
}
