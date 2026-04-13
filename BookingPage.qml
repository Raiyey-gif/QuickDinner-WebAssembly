import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

Item {
    id: bookingRoot
    anchors.fill: parent

    // 1. DYNAMIC BACKGROUND
    Image {
        id: bgImage
        anchors.fill: parent
        source: "qrc:/qt/qml/QuickDinner/secondbackground.jpeg"
        fillMode: Image.PreserveAspectCrop
        visible: false
    }

    MultiEffect {
        anchors.fill: parent
        source: bgImage
        blurEnabled: true
        blur: 0.18
        saturation: 1.1
        brightness: -0.15
    }

    // 2. THE GLASS CARD
    Rectangle {
        id: glassCard
        anchors.centerIn: parent
        width: 380
        height: 520 // Slightly taller to fit inputs
        radius: 30
        color: "#40ffffff"
        border.color: "#60ffffff"
        border.width: 1

        layer.enabled: true
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowBlur: 1
            shadowColor: "#80000000"
            shadowVerticalOffset: 12
        }

        // 3. FORM CONTENT
        Column {
            anchors.fill: parent
            anchors.margins: 35
            spacing: 20

            Text {
                text: "Make a\nReservation."
                color: "white"
                font.pixelSize: 28
                font.weight: Font.Bold
                style: Text.Outline
                styleColor: "#40000000"
            }

            // Input Fields
            Column {
                width: parent.width
                spacing: 12

                TextField {
                    id: nameIn
                    placeholderText: "Customer Name"
                    width: parent.width
                    height: 50
                    color: "white"
                    placeholderTextColor: "#ccffffff"
                    leftPadding: 15
                    background: Rectangle {
                        color: "#40000000"
                        radius: 12
                        border.color: nameIn.activeFocus ? "#88B04B" : "transparent"
                    }
                }

                RowLayout {
                    width: parent.width
                    spacing: 10
                    TextField {
                        id: dateIn
                        placeholderText: "DD-MM-YY"
                        Layout.fillWidth: true
                        height: 50
                        color: "white"
                        placeholderTextColor: "#ccffffff"
                        background: Rectangle {
                            color: "#40000000"
                            radius: 12
                            border.color: dateIn.activeFocus ? "#88B04B" : "transparent"
                        }
                    }
                    TextField {
                        id: timeIn
                        placeholderText: "HH:mm"
                        Layout.fillWidth: true
                        height: 50
                        color: "white"
                        placeholderTextColor: "#ccffffff"
                        background: Rectangle {
                            color: "#40000000"
                            radius: 12
                            border.color: timeIn.activeFocus ? "#88B04B" : "transparent"
                        }
                    }
                }

                // Styled SpinBox for Guest Count
                SpinBox {
                    id: countIn
                    from: 1
                    to: 10
                    width: parent.width
                    height: 50
                    editable: true

                    contentItem: Text {
                        text: countIn.textFromValue(countIn.value, countIn.locale) + " GUESTS"
                        font.pixelSize: 14
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    background: Rectangle {
                        color: "#40000000"
                        radius: 12
                    }
                }
            }

            // 4. CONFIRM BUTTON
            Button {
                id: confirmBtn
                text: "CONFIRM BOOKING"
                width: parent.width
                height: 55
                onClicked: {
                    if (resManager.tambahReservasi(nameIn.text, countIn.value, dateIn.text, timeIn.text)) {
                        mainStack.pop();
                    }
                }

                contentItem: Text {
                    text: confirmBtn.text
                    color: "white"
                    font.weight: Font.Bold
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                background: Rectangle {
                    color: confirmBtn.down ? "#6E9630" : (confirmBtn.hovered ? "#98C05B" : "#81A649")
                    radius: 15
                }
            }

            Text {
                text: "← Cancel"
                color: "#f9ebaf"
                font.pixelSize: 14
                anchors.horizontalCenter: parent.horizontalCenter
                MouseArea {
                    anchors.fill: parent
                    onClicked: mainStack.pop()
                }
            }
        }
    }
}
