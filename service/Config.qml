pragma Singleton
import QtQuick
import Quickshell.Io
import Quickshell
import "../Config/"

Singleton {
    id: config
    property color background: Theme.colors.background
    property color textColor: Theme.colors.text
    property color red: Theme.colors.red
    property color yellow: Theme.colors.yellow
    property color green: Theme.colors.green
    property color icon: Theme.colors.icon
    property JsonObject theme: adapter.theme
    QtObject {
        id: adapter
        property JsonObject theme: JsonObject {
            property JsonObject colors: Theme.colors
            property JsonObject icons: JsonObject {
                property string fontFamily: Theme.fonts.icons
                property string media_play: Theme.icons.mediaPlay
                property string media_pause: Theme.icons.mediaPause
                property string media_next: Theme.icons.mediaNext
                property string media_previous: Theme.icons.mediaPrevious
                property string mediaRepeat: Theme.icons.mediaRepeat
                property string mediaShuffle: Theme.icons.mediaShuffle
                property string microphone: Theme.icons.microphone
                property string microphoneMuted: Theme.icons.microphoneMuted
                property string volumeMuted: Theme.icons.volumeMuted
                property string volumeLow: Theme.icons.volumeLow
                property string volumeMedium: Theme.icons.volumeMedium
                property string volumeHigh: Theme.icons.volumeHigh
                property string volumeOff: Theme.icons.volumeOff
            }
        }
    }
}
