pragma Singleton
import QtQuick
import Quickshell.Io

FileView {
    id: config
    property color background: adapter.theme.colors.background
    property color textColor: adapter.theme.colors.text
    property color red: adapter.theme.colors.red
    property color yellow: adapter.theme.colors.yellow
    property color green: adapter.theme.colors.green
    property color icon: adapter.theme.colors.icon
    property JsonObject theme: adapter.theme
    path: Qt.resolvedUrl("../config.json")
    watchChanges: true
    onFileChanged: reload()
    JsonAdapter {
        id: adapter
        property JsonObject theme: JsonObject {
            property JsonObject colors: JsonObject {
                property string background: "#1a1b26"
                property string text: "#a9b1d6"
                property string red: "#f7768e"
                property string yellow: "#e0af68"
                property string green: "#73daca"
                property string icon: "#565f89"
            }
            property JsonObject icons: JsonObject {
                property string fontFamily: "Font Awesome 7 Free Solid"
                property string media_play: "\uf04b"
                property string media_pause: "\uf04c"
                property string media_next: "\uf051"
                property string media_previous: "\uf048"
            }
        }
    }
}
