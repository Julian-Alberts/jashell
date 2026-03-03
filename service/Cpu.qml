pragma Singleton
import Quickshell.Io
import Quickshell
import QtQuick

Singleton {
    id: root
    property bool idleIncludeIoWait: false
    property int updateInderval: 5000
    property var cpuData: ({})
    property FileView statFile: FileView {
        id: statFile
        path: "/proc/stat"
        onLoaded: {
            root.updateFromText(text());
        }
    }
    function updateFromText(text) {
        function sumArray(arr) {
            let sum = 0;
            for (const v of arr) {
                sum += v;
            }
            return sum;
        }
        const cpuDataArray = text.split('\n').filter(l => l.startsWith('cpu')).map(line => line.replace('  ', ' ').split(' '));
        for (const data of cpuDataArray) {
            const idStr = data[0].slice(3);
            const id = idStr === "" ? -1 : Number(idStr);
            const numData = data.slice(1, 9).map(Number);
            if (cpuData[id]) {
                const cpuModel = cpuData[id];
                cpuModel.update(sumArray(numData), numData[3]);
            } else {
                const cpuDataComponent = Qt.createComponent("CpuData.qml");
                const cpuModel = cpuDataComponent.createObject(null, {
                    id: 0,
                    lastTotal: sumArray(numData),
                    lastIdle: numData[3]
                });
                cpuData[id] = cpuModel;
            }
        }
    }
    property Timer timer: Timer {
        interval: root.updateInderval
        repeat: true
        running: true
        triggeredOnStart: true
        onTriggered: statFile.reload()
    }
}
