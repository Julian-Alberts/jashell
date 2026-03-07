pragma Singleton
import QtQuick
import QtQuick.Controls as QC
import Quickshell.Services.UPower
import "../Components/Ui"
import "../Config"

JaPopupWindow {
    id: root
    property UPowerDevice device: UPower.displayDevice
    Column {
        palette: Theme.palette
        RadioButton {
            text: "Performance"
            visible: PowerProfiles.hasPerformanceProfile
            checked: PowerProfiles.profile === PowerProfile.Performance
        }
        RadioButton {
            text: "Balanced"
            checked: PowerProfiles.profile === PowerProfile.Balanced
        }
        RadioButton {
            text: "PowerSaver"
            checked: PowerProfiles.profile === PowerProfile.PowerSaver
        }
    }
}
