pragma Singleton
import QtQuick
import QtQuick.Controls
import "../Config/"
import Quickshell
import Quickshell.Io

JaPopupWindow {
    id: root
    implicitWidth: content.width
    implicitHeight: content.height < 300 ? 300 : content.height
    onVisibleChanged: {
        if (visible) {
            fetchThemesProcess.running = true;
        }
    }
    Column {
        id: content
        padding: 10
        CheckBox {
            id: hotReload
            text: "Enable theme hot reload"
            checked: Settings.data.hotReload
            onCheckStateChanged: {
                Settings.data.hotReload = checked;
            }
            contentItem: Label {
                text: parent.text
                color: Theme.colors.text
                leftPadding: 20
            }
        }
        Process {
            id: fetchThemesProcess
            command: ["ls"]
            running: true
            onStarted: {
                console.log("Process started");
            }
            workingDirectory: Quickshell.shellDir + "/themes"
            stdout: StdioCollector {
                onStreamFinished: {
                    themeSelector.model = text.split("\n").filter(line => line.endsWith(".json")).map(line => line.slice(0, -5).trim());
                }
            }
        }
        Text {
            text: "Select Theme"
            color: Theme.colors.text
        }
        ListView {
            id: themeSelector
            width: contentWidth
            height: contentHeight
            delegate: RadioButton {
                id: themeCheckBox
                width: 100
                height: 30
                text: modelData
                checked: Settings.data.theme === modelData
                onCheckedChanged: {
                    if (checked) {
                        Settings.data.theme = modelData;
                    }
                }
                contentItem: Label {
                    text: parent.text
                    color: Theme.colors.text
                    leftPadding: 20
                }
            }
        }
    }
}
