import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

Item {
    id: staffRoot
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

    // 2. WIDER GLASS CARD
    Rectangle {
        id: glassCard
        anchors.centerIn: parent
        width: 420
        height: 600
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
            spacing: 15

            // Header Section
            Column {
                Layout.fillWidth: true
                spacing: 5
                Text {
                    text: "STAFF CONTROL"
                    color: "#f9ebaf"
                    font.pixelSize: 12
                    font.letterSpacing: 2
                    font.weight: Font.Bold
                }
                Text {
                    text: resManager.availableSeats + " SEATS OPEN"
                    color: "white"
                    font.pixelSize: 24
                    font.weight: Font.Bold
                }
            }

            // 3. QUEUE LIST (TRANSULCENT)
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "#20000000"
                radius: 15
                border.color: "#30ffffff"
                clip: true

                ListView {
                    id: queueView
                    anchors.fill: parent
                    anchors.margins: 10
                    model: resManager.queueList
                    spacing: 8

                    delegate: Rectangle {
                        width: queueView.width
                        height: 50
                        color: "#30ffffff"
                        radius: 8

                        RowLayout {
                            anchors.fill: parent
                            anchors.leftMargin: 15
                            anchors.rightMargin: 15
                            Text {
                                text: modelData.nama
                                color: "white"
                                font.weight: Font.DemiBold
                                Layout.fillWidth: true
                            }
                            Text {
                                text: modelData.jumlah + " PAX"
                                color: "#f9ebaf"
                                font.pixelSize: 12
                            }
                        }
                    }

                    Text {
                        anchors.centerIn: parent
                        text: "Queue is empty"
                        color: "white"
                        opacity: 0.5
                        visible: queueView.count === 0
                    }
                }
            }

            // 4. ACTION BUTTON
            Button {
                id: processBtn
                text: "PROCESS NEXT CUSTOMER"
                Layout.fillWidth: true
                Layout.preferredHeight: 55
                onClicked: {
                    resManager.prosesAntrean();
                    statusPopup.open();
                }

                contentItem: Text {
                    text: processBtn.text
                    color: "white"
                    font.weight: Font.Bold
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                background: Rectangle {
                    color: processBtn.down ? "#6E9630" : (processBtn.hovered ? "#98C05B" : "#81A649")
                    radius: 15
                }
            }

            Text {
                text: "← Back to Dashboard"
                color: "white"
                opacity: 0.7
                Layout.alignment: Qt.AlignHCenter
                MouseArea {
                    anchors.fill: parent
                    onClicked: mainStack.pop()
                }
            }
        }
    }

    // 5. STYLED POPUP
    Popup {
        id: statusPopup
        anchors.centerIn: parent
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        background: Rectangle {
            color: "#CC2F4F4F"
            radius: 20
            border.color: "#81A649"
        }

        contentItem: Text {
            text: "Customer Processed!"
            color: "white"
            padding: 20
            font.weight: Font.Medium
        }
    }
}
