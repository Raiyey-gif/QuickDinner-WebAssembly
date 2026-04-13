import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Item {
    id: pageRoot
    anchors.fill: parent

    // =========================================================
    // BACKGROUND: THE WINDOW VIEW
    // =========================================================
    Item {
        id: bgContainer
        anchors.fill: parent

        Image {
            id: mainBg
            anchors.fill: parent
            source: "qrc:/qt/qml/QuickDinner/backgroundpict.jpeg"
            fillMode: Image.PreserveAspectCrop
            visible: false
        }

        // Frosted Glass Layer
        MultiEffect {
            anchors.fill: parent
            source: mainBg
            blurEnabled: true
            blur: 0.6
            saturation: 1.1
            brightness: -0.2 // Darker for better reservation form contrast
        }
    }

    MouseArea {
        id: mouseTracker
        anchors.fill: parent
        hoverEnabled: true
    }

    // =========================================================
    // CONTENT: PROFESSIONAL MINIMALISM
    // =========================================================
    Column {
        anchors.centerIn: parent
        spacing: 15

        Text {
            text: "QUICKDINNER"
            color: "white"
            opacity: 0.5
            font.pixelSize: 14
            font.weight: Font.Medium
            font.letterSpacing: 10
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            // Direct and functional wording
            text: "Your favorite spot,\nreserved."
            font.bold: true
            color: "#f3f1d7"
            font.pixelSize: 49
            font.weight: Font.DemiBold
            font.letterSpacing: -2
            lineHeight: 1.0
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter

            layer.enabled: true
            layer.effect: MultiEffect {
                shadowEnabled: true
                shadowColor: "#000000"
                shadowOpacity: 0.5
                shadowBlur: 0.7
            }
        }
    }

    // =========================================================
    // ACTION: THE "BOOK" BUTTON
    // =========================================================
    Button {
        id: stepButton
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 100

        background: Rectangle {
            implicitWidth: 260
            implicitHeight: 64
            radius: 32

            // Clean Apple White Button
            color: stepButton.hovered ? "#e9e5a9" : "#f3f1d7"

            scale: stepButton.pressed ? 0.96 : 1.0
            Behavior on scale {
                NumberAnimation {
                    duration: 100
                }
            }
            Behavior on color {
                ColorAnimation {
                    duration: 200
                }
            }

            layer.enabled: true
            layer.effect: MultiEffect {
                shadowEnabled: true
                shadowColor: "#40000000"
                shadowBlur: 0.5
            }
        }

        contentItem: Text {
            text: "Book a Table" // Direct action
            color: "#000630" // Dark text on light button
            font.pixelSize: 18
            font.weight: Font.DemiBold
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        onClicked: mainStack.push("qrc:/qt/qml/QuickDinner/LoginSignPage.qml")
    }

    // Subtle Footer
    Text {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 40
        text: "Your next memory starts here."
        color: "#F9D423" // Golden Sun Accent
        opacity: 0.8
        font.italic: true
        font.pixelSize: 11
        font.letterSpacing: 2
    }
}
