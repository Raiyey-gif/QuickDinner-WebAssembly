import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

Item {
    id: queueRoot
    anchors.fill: parent

    // 1. DYNAMIC BACKGROUND
    Image {
        id: bgImage
        anchors.fill: parent
        source: "qrc:/qt/qml/QuickDinner/backgroundpict.jpeg"
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
        width: 400
        height: 550
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
            anchors.margins: 30
            spacing: 20

            // Header Section
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 5
                Text {
                    text: "RESERVATIONS"
                    color: "#f9ebaf"
                    font.pixelSize: 12
                    font.letterSpacing: 2
                    font.weight: Font.Bold
                }
                Text {
                    text: "Current Queue"
                    color: "white"
                    font.pixelSize: 26
                    font.weight: Font.Bold
                }
            }

            // 3. QUEUE LIST VIEW
            ListView {
                id: listView
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                model: resManager.queueList
                spacing: 12

                delegate: Rectangle {
                    width: listView.width
                    height: 70
                    radius: 15
                    color: "#30000000" // Darker translucent background for items
                    border.color: "#20ffffff"

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 18

                        Column {
                            Layout.fillWidth: true
                            Text {
                                text: modelData.nama
                                color: "white"
                                font.pixelSize: 16
                                font.weight: Font.DemiBold
                            }
                            Text {
                                text: modelData.jumlah + " GUESTS"
                                color: "#ccffffff"
                                font.pixelSize: 12
                            }
                        }

                        Text {
                            text: modelData.waktu
                            color: "#f9ebaf"
                            font.pixelSize: 13
                            font.weight: Font.Medium
                        }
                    }
                }

                // Empty State
                Text {
                    anchors.centerIn: parent
                    text: "No active bookings."
                    color: "white"
                    opacity: 0.5
                    visible: listView.count === 0
                }
            }

            // 4. BACK BUTTON
            Button {
                id: backBtn
                text: "BACK"
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                onClicked: mainStack.pop()

                contentItem: Text {
                    text: backBtn.text
                    color: "white"
                    font.weight: Font.Bold
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                background: Rectangle {
                    color: backBtn.down ? "#60000000" : (backBtn.hovered ? "#40000000" : "#20000000")
                    radius: 12
                    border.color: "#60ffffff"
                }
            }
        }
    }
}
