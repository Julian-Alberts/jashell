pragma Singleton
pragma ComponentBehavior: Bound
import QtQuick
import Quickshell.Io
import Quickshell

Singleton {
    id: root
    property var colors: adapter.colors
    property var fonts: adapter.fonts
    property var icons: adapter.icons
    FileView {
        path: Qt.resolvedUrl("../themes/" + Settings.theme + ".json")
        watchChanges: Settings.hotReload
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
        onLoaded: {
            console.log("Theme loaded");
            const palette = Qt.createQmlObject("import QtQuick; Palette {}", root, "palette");
            //palette.accent = ''
            //palette.alternateBase = ''
            palette.base = adapter.colors.background;
            palette.button = adapter.colors.background;
            palette.buttonText = adapter.colors.text;
            //palette.colorGroup = ''
            //palette.dark = ''
            //palette.highlight = ''
            //palette.highlightedText = ''
            //palette.light = ''
            //palette.mid = ''
            //palette.midlight = ''
            //palette.placeholderText = ''
            //palette.shadow = ''
            palette.text = adapter.colors.text;
            palette.window = adapter.colors.background;
            palette.windowText = adapter.colors.text;
            root.palette = palette;
        }
        property Palette tmp: Palette {}
    }
    property Palette palette
}
