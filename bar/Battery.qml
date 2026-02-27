import QtQuick
import QtQuick.Controls
import Quickshell.Services.UPower
import Quickshell
import "../service/"

Rectangle {
    id: root
    color: Config.icon
    radius: 3
    implicitWidth: 40
    property bool showPercentage: true
    ProgressBar {
        id: progressBar
        anchors.centerIn: parent
        implicitHeight: parent.height - 6
        implicitWidth: parent.implicitWidth - 6
        from: 0
        to: 1
        value: UPower.displayDevice?.percentage ?? 1
        background: Rectangle {
            color: "white"
            radius: 4
        }
        contentItem: Item {
            implicitWidth: parent.implicitWidth
            implicitHeight: parent.implicitHeight
            Rectangle {
                implicitWidth: progressBar.visualPosition * parent.implicitWidth
                implicitHeight: parent.implicitHeight
                radius: progressBar.background.radius
                color: {
                    if (progressBar.value > .5)
                        return Config.green;
                    else if (progressBar.value > .3)
                        return Config.yellow;
                    else
                        return Config.red;
                }
            }
        }
    }
    Rectangle {
        color: parent.color
        width: 5
        height: 10
        topRightRadius: 3
        bottomRightRadius: 3
        anchors.verticalCenter: parent.verticalCenter
        anchors {
            left: parent.right
        }
    }

    Text {
        text: Math.floor(progressBar.value * 100)
        anchors.centerIn: progressBar
        visible: root.showPercentage
        font.bold: true
    }
    Text {
        anchors.centerIn: progressBar
        visible: !root.showPercentage
        text: {
            let time;
            if (UPower.displayDevice.timeToEmpty > 0)
                time = UPower.displayDevice.timeToEmpty;
            if (UPower.displayDevice.timeToFull > .1)
                time = UPower.displayDevice.timeToFull;
            if (!time)
                return "Full";
            const mins = time / 60;
            const displayMins = String(Math.floor(mins % 60)).padStart(2, '0');
            const displayHours = Math.floor(mins / 60);

            return `${displayHours}:${displayMins}`;
        }
        font.bold: true
    }
    visible: UPower.displayDevice?.isLaptopBattery ?? false
    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.showPercentage = !root.showPercentage;
        }
    }
}
