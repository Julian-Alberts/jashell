pragma Singleton
pragma ComponentBehavior: Bound
import QtQuick
import Quickshell.Io
import Quickshell

Singleton {
    id: root
    property Colors colors: adapter.colors
    property Fonts fonts: adapter.fonts
    property Icons icons: adapter.icons
    FileView {
        path: Qt.resolvedUrl("../themes/" + Settings.theme + ".json")
        watchChanges: Settings.hotReload
        onFileChanged: reload()
        blockLoading: true
        JsonAdapter {
            id: adapter
            property Colors colors: Colors {}
            property Fonts fonts: Fonts {}
            property Icons icons: Icons {}
        }
        onLoaded: {
            console.log("Theme loaded");
            root.palette.accent = adapter.colors.accent;
            //palette.alternateBase = ''
            root.palette.base = adapter.colors.background;
            root.palette.button = adapter.colors.background;
            root.palette.buttonText = adapter.colors.text;
            //palette.colorGroup = ''
            //palette.dark = ''
            //palette.highlight = ''
            //palette.highlightedText = ''
            //palette.light = ''
            //palette.mid = ''
            //palette.midlight = ''
            //palette.placeholderText = ''
            //palette.shadow = ''
            root.palette.text = adapter.colors.text;
            root.palette.window = adapter.colors.background;
            root.palette.windowText = adapter.colors.text;
            root.paletteChanged();
        }
    }
    component Colors: JsonObject {
        property color background: "#1a1b26"
        property color text: "#a9b1d6"
        property color red: "#f7768e"
        property color yellow: "#e0af68"
        property color green: "#73daca"
        property color icon: "#565f89"
        property color accent: "#565f89"
        property ColorGroup border: ColorGroup {
            active: text
            inactive: text
        }
    }

    component ColorGroup: JsonObject {
        required property color active
        required property color inactive
    }

    component Fonts: JsonObject {
        property string icons: "Font Awesome 7 Free Solid"
    }
    component Icons: JsonObject {
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
    property Palette palette: Palette {
        accent: root.colors.accent
        //alternateBase : ''
        base: root.colors.background
        button: root.colors.background
        buttonText: root.colors.text
        //colorGroup : ''
        //dark : ''
        //highlight : ''
        //highlightedText : ''
        //light : ''
        //mid : ''
        //midlight : ''
        //placeholderText : ''
        //shadow : ''
        text: root.colors.text
        window: root.colors.background
        windowText: root.colors.text
    }
}
