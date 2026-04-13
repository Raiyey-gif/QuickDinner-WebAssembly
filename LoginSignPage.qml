import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Item {
    id: loginRoot
    anchors.fill: parent
    property bool isRegisterMode: false

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
        brightness: -0.15 // Slightly darker than before to help the card pop
    }

    // 2. THE REFINED GLASS CARD
    Rectangle {
        id: glassCard
        anchors.centerIn: parent
        width: 380
        height: isRegisterMode ? 480 : 420
        radius: 30

        // Increased white tint for better "frost" separation
        color: "#40ffffff"
        border.color: "#60ffffff"
        border.width: 1

        // Increased shadow density so it looks "higher" off the window
        layer.enabled: true
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowBlur: 1
            shadowColor: "#80000000"
            shadowVerticalOffset: 12
        }

        Behavior on height {
            NumberAnimation {
                duration: 400
                easing.type: Easing.OutBack
            }
        }

        // 3. FORM CONTENT
        Column {
            anchors.fill: parent
            anchors.margins: 40
            spacing: 25

            Text {
                text: isRegisterMode ? "Create Account." : "Welcome Back."
                color: "white"
                font.pixelSize: 28
                font.weight: Font.Bold
                style: Text.Outline
                styleColor: "#40000000" // Darker outline for readability
            }

            Column {
                width: parent.width
                spacing: 15

                TextField {
                    id: userIn
                    placeholderText: "Username"
                    width: parent.width
                    height: 50
                    color: "white"
                    placeholderTextColor: "#ccffffff"
                    leftPadding: 15
                    background: Rectangle {
                        // Darker background inside inputs prevents them from "drowning"
                        color: "#40000000"
                        radius: 12
                        border.color: userIn.activeFocus ? "#88B04B" : "transparent"
                    }
                }

                TextField {
                    id: passIn
                    placeholderText: "Password"
                    echoMode: TextInput.Password
                    width: parent.width
                    height: 50
                    color: "white"
                    placeholderTextColor: "#ccffffff"
                    leftPadding: 15
                    background: Rectangle {
                        color: "#40000000"
                        radius: 12
                        border.color: passIn.activeFocus ? "#88B04B" : "transparent"
                    }
                }
            }

            // 4. ACTION BUTTON
            Button {
                id: actionBtn
                text: isRegisterMode ? "Register" : "Sign In"
                width: parent.width
                height: 55

                contentItem: Text {
                    text: actionBtn.text
                    color: "white"
                    font.weight: Font.Bold
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                background: Rectangle {
                    // Slightly more vibrant green to cut through the background
                    color: actionBtn.down ? "#6E9630" : (actionBtn.hovered ? "#98C05B" : "#81A649")
                    radius: 15

                    // Inner light to make the button look 3D
                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: 1
                        color: "transparent"
                        radius: 15
                        border.color: "#30ffffff"
                        border.width: 1
                    }
                }

                onClicked: {
                    if (isRegisterMode) {
                        if (resManager.registerUser(userIn.text, passIn.text))
                            isRegisterMode = false;
                    } else {
                        if (resManager.loginUser(userIn.text, passIn.text))
                            mainStack.push("qrc:/qt/qml/QuickDinner/DashboardPage.qml");
                    }
                }
            }

            Text {
                text: isRegisterMode ? "Already a member? Sign in" : "New here? Create an account"
                color: "#f9ebaf" // Bright gold remains easy to see
                font.pixelSize: 14
                font.weight: Font.Medium
                anchors.horizontalCenter: parent.horizontalCenter
                MouseArea {
                    anchors.fill: parent
                    onClicked: isRegisterMode = !isRegisterMode
                }
            }
        }
    }

    // 5. BACK BUTTON
    Text {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 30
        text: "← Back"
        color: "white"
        opacity: 0.8
        font.pixelSize: 16
        style: Text.Outline
        styleColor: "#40000000"
        MouseArea {
            anchors.fill: parent
            onClicked: mainStack.pop()
        }
    }
}
