/**
* Filename: Notifications.qml
*
* XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
* blockchain protocol to host decentralized applications
*
* Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
*
* This file is part of an XTRABYTES Ltd. project.
*
*/

import QtQuick 2.7
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtMultimedia 5.8

import "qrc:/Controls" as Controls
import "qrc:/Controls/+desktop" as Desktop

Rectangle {
    id: backgroundNotif
    z: 1
    width: appWidth/6 * 5
    height: appHeight
    anchors.right: xcite.right
    anchors.top: xcite.top
    color: bgcolor

    property int clearFailed: 0

    Label {
        id: notificationsLabel
        text: "ALERTS"
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12
        anchors.top: parent.top
        anchors.topMargin: appWidth/24
        font.pixelSize: appHeight/18
        font.family: xciteMobile.name
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
    }

    Rectangle {
        id: clearAlerts
        height: appHeight/12
        width: height
        anchors.top: notificationsLabel.bottom
        anchors.topMargin: appWidth/24
        anchors.right: notificationsLabel.right
        color: "transparent"
        border.width: 1
        border.color: themecolor


        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onEntered: {
                if (updatingWalletsNotif == false) {
                    clearAlerts.border.color = maincolor
                }
            }

            onExited: {
                clearAlerts.border.color = themecolor
            }

            onClicked: {
                if (updatingWalletsNotif == false) {
                    updatingWalletsNotif = true
                    clearAlertList();
                    checkNotifications();
                    updateToAccount()
                }
            }

            Connections {
                target: UserSettings

                onSaveSucceeded: {
                    if (updatingWalletsNotif == true) {
                        updatingWalletsNotif = false
                    }
                }

                onSaveFailed: {
                    if (updatingWalletsNotif == true) {
                        updatingWalletsNotif = false
                        clearFailed = 1
                    }
                }
            }
        }
    }

    Rectangle {
        id: alertArea
        width: parent.width
        anchors.top: clearAlerts.bottom
        anchors.topMargin: appWidth/48
        anchors.bottom: parent.bottom
        anchors.bottomMargin: appWidth/24
        anchors.left: parent.left
        color: "transparent"
        clip: true

        Desktop.NotificationList {
            id: myAlertList
            anchors.top: parent.top
        }
    }

    Rectangle {
        height: appWidth/24
        width: parent.width
        anchors.bottom: parent.bottom
        color: darktheme == true? "#14161B" : "#FDFDFD"
    }
}
