import QtQuick
import QtQuick.Controls
import Quickshell.Services.UPower
import "../service/"

Rectangle {
    id: root
    color: Config.icon
    radius: 3
    implicitHeight: 20
    implicitWidth: 40
    anchors.verticalCenter: parent.verticalCenter
    anchors.rightMargin: 5
    ProgressBar {
        id: progressBar
        anchors.centerIn: parent
        implicitHeight: parent.implicitHeight - 6
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
    }
    visible: UPower.displayDevice?.isLaptopBattery ?? false
}
