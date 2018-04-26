import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

import "../Controls" as Controls

Item {
    readonly property color cDiodeBackground: "#3a3e46"
    readonly property string defaultView: "home"

    property string selectedView
    property string selectedModule
    //themeControl.currentText == "Dark" ? 0 : 1
    anchors.fill: parent
    Layout.fillHeight: true
    Layout.fillWidth: true

    visible: selectedModule === 'settings'

    Connections {
        target: dashboard
        onSelectView: {
            var parts = path.split('.')

            selectedModule = parts[0]
            if (parts.length === 2) {
                selectedView = parts[1]
            } else {
                selectedView = defaultView
            }
        }
    }

    Controls.Diode {
        anchors.fill: parent
        title: qsTr("Settings")

        RowLayout {
            anchors.fill: parent
            anchors.topMargin: 75
            anchors.leftMargin: 20
            anchors.rightMargin: 20

            ColumnLayout {
                Layout.alignment: Qt.AlignTop
                spacing: 20

                Controls.FormLabel {
                    text: qsTr("Select Your Language")
                }

                ComboBox {
                    id: control
                    currentIndex: 0
                    textRole: "text"

                    Connections {
                        Component.onCompleted: {
                            for (var i = 0; i < languageOptions.count; i++) {
                                if (languageOptions.get(
                                            i).locale === settings.locale) {
                                    control.currentIndex = i
                                    break
                                }
                            }
                        }
                    }

                    model: ListModel {
                        id: languageOptions
                        ListElement {
                            text: qsTr("English")
                            locale: "en_us"
                        }
                        ListElement {
                            text: qsTr("Dutch")
                            locale: "nl_nl"
                        }
                    }

                    onCurrentIndexChanged: {
                        if (languageOptions.get(
                                    currentIndex).locale === settings.locale) {
                            return
                        }

                        var locale = languageOptions.get(currentIndex).locale
                        localeChange(locale)
                        settings.locale = locale
                    }
                }
                Controls.FormLabel {
                    text: qsTr("Theme")
                }
                ComboBox {
                    id: themeControl
                    textRole: "text"

                    model: ListModel {
                        id: themeOptions
                        ListElement {
                            text: qsTr("Dark")
                            locale: "dark"
                        }
                        ListElement {
                            text: qsTr("Light")
                            locale: "light"
                        }
                    }
                }
            }

            DeveloperSettings {
                Layout.alignment: Qt.AlignTop
            }
        }
    }
}
