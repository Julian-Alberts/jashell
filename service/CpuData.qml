import QtQuick
QtObject {
        required property int id
        required property int lastTotal
        required property int lastIdle
        property int currentTotal: 0
        property int currentIdle: 0
        property int usage: {
            const total_d = currentTotal - lastTotal;
            const idle_d = currentIdle - lastIdle;
            const busy = total_d - idle_d;
            return (busy / total_d) * 100;
        }
        function update(total, idle) {
            currentTotal = total;
            currentIdle = idle;
        }
    }

