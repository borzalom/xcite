import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import "../Controls" as Controls

Column {
    id: onboardingIntroduction
    readonly property color cDiodeBackground: "#2B2C31"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    height: 500
    spacing: 40

    Image {
        smooth: true
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        height: 250
        source: "../backgrounds/launchscreen-logo.png"
    }

    Label {
        id: versionLabel
        font.pixelSize: 24
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 30
        anchors.bottomMargin: 30
        color: "white"
        text: qsTr("XCITE - Version " + AppVersion)
    }

    Label {
        font.pixelSize: 20
        color: "white"
        width: 780
        wrapMode: Text.WordWrap
        anchors.bottomMargin: 40
        anchors.horizontalCenter: parent.horizontalCenter
        text: qsTr("This pre-release version of XCITE includes temporary builds of our XCITE, X-CHAT and X-CHANGE modules.")
    }

    Controls.ButtonModal {
        Layout.fillWidth: false
        width: 220
        buttonHeight: 38
        labelText: "LET'S DO THIS"
        anchors.horizontalCenter: parent.horizontalCenter
        isPrimary: true
        onButtonClicked: {
            mainRoot.push("../DashboardForm.qml")
        }
    }
}
