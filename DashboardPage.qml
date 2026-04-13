import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

Item {
    id: dashboardRoot
    anchors.fill: parent

    // 1. DYNAMIC BACKGROUND (Matches Login Page)
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

    // 2. GLASS CARD CONTAINER
    Rectangle {
        id: glassCard
        anchors.centerIn: parent
        width: 380
        height: 450
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

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 35
            spacing: 20

            // Header Section
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 5
                Text {
                    text: "TABLE STATUS"
                    font.pixelSize: 12
                    font.letterSpacing: 2
                    font.weight: Font.Bold
                    color: "#f9ebaf" // Matching the gold accent
                }
                Text {
                    text: resManager.availableSeats + " SEATS LEFT"
                    font.pixelSize: 26
                    font.weight: Font.Bold
                    color: "white"
                }
            }

            // Spacer
            Item {
                Layout.fillHeight: true
            }

            // Navigation Buttons
            Column {
                Layout.fillWidth: true
                spacing: 15

                // Reservation Button (Vibrant Green)
                Button {
                    id: reserveBtn
                    width: parent.width
                    height: 70
                    onClicked: mainStack.push("qrc:/qt/qml/QuickDinner/BookingPage.qml")

                    contentItem: Text {
                        text: "NEW RESERVATION"
                        color: "white"
                        font.bold: true
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    background: Rectangle {
                        color: reserveBtn.down ? "#6E9630" : (reserveBtn.hovered ? "#98C05B" : "#81A649")
                        radius: 15
                        Rectangle {
                            anchors.fill: parent
                            anchors.margins: 1
                            color: "transparent"
                            radius: 15
                            border.color: "#30ffffff"
                            border.width: 1
                        }
                    }
                }

                // History Button (Dark Glass Style)
                Button {
                    id: historyBtn
                    width: parent.width
                    height: 70
                    onClicked: mainStack.push("qrc:/qt/qml/QuickDinner/HistoryPage.qml")

                    contentItem: Text {
                        text: "MY BOOKINGS"
                        color: "white"
                        font.bold: true
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    background: Rectangle {
                        color: historyBtn.down ? "#60000000" : (historyBtn.hovered ? "#40000000" : "#20000000")
                        radius: 15
                        border.color: "#60ffffff"
                        border.width: 1
                    }
                }
            }

            // Logout Footer
            Text {
                text: "Logout"
                color: "white"
                opacity: 0.7
                font.pixelSize: 14
                Layout.alignment: Qt.AlignHCenter
                MouseArea {
                    anchors.fill: parent
                    onClicked: mainStack.pop()
                }
            }
        }
    }
}
