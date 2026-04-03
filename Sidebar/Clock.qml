import "../Components"
import "../Config"

Clock {
    isVertical: true
    format: Settings.clock.verticalFormat || Settings.clock.format
    anchors {
        left: parent.left
        right: parent.right
    }
}
