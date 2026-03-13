import QtQuick
import Quickshell

Loader {
    id: root
    required property string name
    required property string namespace
    property ShellScreen screen
    property QsWindow window
    source: Quickshell.shellDir + "/" + namespace + "/Components/" + root.name + ".qml"
    Binding {
        target: root.item
        property: "screen"
        value: root.screen
        when: root.item && root.item.hasOwnProperty("screen")
    }
    Binding {
        target: root.item
        property: "window"
        value: root.window
        when: root.item && root.item.hasOwnProperty("window")
    }
}
