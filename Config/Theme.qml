pragma Singleton
import QtQuick
import Quickshell.Io
import Quickshell

Singleton {
    property var colors: adapter.colors
    property var fonts: adapter.fonts
    property var icons: adapter.icons
    FileView {
        path: Qt.resolvedUrl("../theme.json")
        watchChanges: true
        onFileChanged: reload()
        blockLoading: true
        JsonAdapter {
            id: adapter
            property JsonObject colors: JsonObject {
                property color background: "#1a1b26"
                property color text: "#a9b1d6"
                property color red: "#f7768e"
                property color yellow: "#e0af68"
                property color green: "#73daca"
                property color icon: "#565f89"
            }
            property JsonObject fonts: JsonObject {
                property string icons: "Font Awesome 7 Free Solid"
            }
            property JsonObject icons: JsonObject {
                property string mediaPlay: "\uf04b"
                property string mediaPause: "\uf04c"
                property string mediaNext: "\uf051"
                property string mediaPrevious: "\uf048"
                property string mediaRepeat: "\uf363"
                property string mediaShuffle: "\uf074"
                property string microphone: "\uf130"
                property string microphoneMuted: "\uf131"
                property string volumeMuted: "\uf6a9"
                property string volumeLow: "\uf027"
                property string volumeMedium: "\uf6a8"
                property string volumeHigh: "\uf028"
                property string volumeOff: "\uf026"
            }
        }
    }
}
