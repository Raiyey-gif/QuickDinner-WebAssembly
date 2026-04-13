import QtQuick
import QtQuick.Controls
import QuickDinner  // This matches the URI in your CMakeLists.txt

Window {
    id: window
    width: 360
    height: 640
    visible: true
    title: "QuickDinner"
    color: "#1a161e" // Warm "Paper" White (Neutral/Pro)

    StackView {
        id: mainStack
        anchors.fill: parent
        // Add /qt/qml/ to the start of the path
        initialItem: "qrc:/qt/qml/QuickDinner/LandingPage.qml"
    }
}
