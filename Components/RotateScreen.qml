import QtQuick
import Quickshell.Io
import "./Ui"
import "../Config"

Item {
    id: root
    property list<string> states: Settings.rotateScreen.rotations
    required property string outputName
    property int currentStateIndex: 0
    property int nextStateIndex: (currentStateIndex + 1) < states.length ? currentStateIndex + 1 : 0
    height: width
    Button {
        anchors.centerIn: parent
        font {
            family: Theme.fonts.icons
            pixelSize: root.width * 0.5
        }
        text: "\uf021"
        onClicked: {
            switchProcess.running = true;
        }
    }
    Process {
        id: switchProcess
        command: ["niri", "msg", "output", root.outputName, "transform", root.states[root.nextStateIndex]]
        onExited: _ => {
            initProcess.running = true;
        }
    }
    Process {
        id: initProcess
        running: true
        command: ["niri", "msg", "outputs"]
        stdout: StdioCollector {
            onStreamFinished: {
                const lines = text.split('\n').map(l => l.trim());
                let startIndex = null;
                for (let index = 0; index < lines.length; index++) {
                    const line = lines[index];
                    if (line.startsWith('Output ') && line.endsWith(`(${root.outputName})`)) {
                        startIndex = index;
                        break;
                    }
                }
                if (startIndex === null)
                    return;
                let state = null;
                for (let index = startIndex + 1; state !== null, index < lines.length; index++) {
                    if (!lines[index].startsWith('Transform:'))
                        continue;
                    state = lines[index].split(' ')[1].replace('°', '');
                }
                if (state === null)
                    return;
                let stateIndex = root.states.findIndex(v => v === state);
                if (stateIndex < 0)
                    stateIndex = 0;
                root.currentStateIndex = stateIndex;
            }
        }
    }
}
