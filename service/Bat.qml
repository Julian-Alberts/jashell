import QtQuick

Bat {
    property int cap
    Timer {
        interval: 500
        running: true
        repeat: true
        onTriggered: time.text = Date().toString()
    }
}
