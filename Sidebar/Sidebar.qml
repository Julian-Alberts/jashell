import QtQuick
import Quickshell
import Quickshell.Services.Mpris
import "../service" as Service
import "../Config" as Config
import "../popup" as Popup
import "./Components"
import "../Components"

Item {
    id: root
    required property ShellScreen screen
    required property QsWindow window
    property Config.Settings.SideBar settings: Config.Settings.getLayout(screen).sidebar
    anchors.fill: parent
    implicitWidth: 50
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton
        onClicked: ev => {
            Popup.Settings.visible = true;
            Popup.Settings.anchor.item = root;
            Popup.Settings.anchor.rect.y = ev.y - Popup.Settings.height / 2;
            Popup.Settings.anchor.edges = Edges.Right;
        }
    }
    DynCompCol {
        componentNames: root.settings.components.top
        screen: root.screen
        window: root.window
        anchors.top: parent.top
    }
    DynCompCol {
        componentNames: root.settings.components.center
        screen: root.screen
        window: root.window
        anchors.verticalCenter: parent.verticalCenter
    }
    DynCompCol {
        componentNames: root.settings.components.bottom
        screen: root.screen
        window: root.window
        anchors.bottom: parent.bottom
    }
    component DynCompCol: Column {
        id: root
        required property list<string> componentNames
        required property ShellScreen screen
        required property QsWindow window
        anchors {
            left: parent.left
            right: parent.right
        }
        spacing: 10
        Repeater {
            model: root.componentNames
            DynComponent {
                id: loader
                required property string modelData
                namespace: "Sidebar"
                name: modelData
                screen: root.screen
                window: root.window
                anchors {
                    left: parent.left
                    right: parent.right
                }
            }
        }
    }
}
