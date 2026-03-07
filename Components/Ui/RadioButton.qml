import QtQuick
import QtQuick.Controls as QC

QC.RadioButton {
    id: root
    Component.onCompleted: {
        console.log(JSON.stringify(palette.text));
    }
}
