import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.0

Window {
    visible: true
    width: 370
    height: 500
    title: qsTr("Runequest Dice Roller")
    maximumHeight: 480
    maximumWidth: 640
    minimumHeight: 480
    minimumWidth: 640

    TextEdit {
        id: skillTextEdit
        x: 125
        y: 62
        width: 40
        height: 20
        text: qsTr("50")
        bottomPadding: -4
        font.pixelSize: 12
    }

    Text {
        id: text1
        x: 30
        y: 62
        width: 89
        height: 15
        text: qsTr("Skill:")
        horizontalAlignment: Text.AlignRight
        font.pixelSize: 12
    }

    Button {
        id: button
        x: 135
        y: 95
        text: qsTr("Roll")
    }

    TextField {
        id: textField
        x: 89
        y: 151
        text: qsTr("")
        horizontalAlignment: Text.AlignHCenter
    }

    Connections {
        target: button
        onClicked: {
            textField.clear();
            if (skillTextEdit.text) {
                var message = "Roll is %1";
                var roll = Math.floor(Math.random() * 100) + 1;
                textField.insert(0, message.arg(roll));
            } else {
                textField.insert(0, "Error, you idiot!");
            }
        }
    }

    RowLayout {
        x: 60
        y: 25

        Button {
            id: button25
            text: qsTr("25")
            Layout.preferredHeight: 25
            Layout.preferredWidth: 34
            font.pointSize: 10
        }

        Button {
            id: button50
            text: qsTr("50")
            Layout.preferredHeight: 25
            Layout.preferredWidth: 34
            font.pointSize: 10
        }

        Button {
            id: button75
            text: qsTr("75")
            Layout.preferredHeight: 25
            Layout.preferredWidth: 34
            font.pointSize: 10
        }
    }

    Button {
        id: button100
        x: 178
        y: 25
        width: 34
        height: 25
        text: qsTr("100")
        font.pointSize: 10
    }

    RowLayout {
        x: 178
        y: 56

        Button {
            id: buttonPlus1
            text: qsTr("+1")
            Layout.preferredWidth: 34
            Layout.preferredHeight: 25
            font.pointSize: 10
        }

        Button {
            id: buttonMinus1
            text: qsTr("-1")
            Layout.preferredWidth: 34
            Layout.preferredHeight: 25
            font.pointSize: 10
        }

        Button {
            id: buttonPlus10
            text: qsTr("+10")
            Layout.preferredWidth: 34
            Layout.preferredHeight: 25
            font.pointSize: 10
        }

        Button {
            id: buttonMinus10
            text: qsTr("-10")
            Layout.preferredWidth: 34
            Layout.preferredHeight: 25
            font.pointSize: 10
        }
    }

    Connections {
        target: button25
        onClicked: {
            skillTextEdit.clear();
            skillTextEdit.insert(0, "25");
        }
    }

    Connections {
        target: button50
        onClicked: {
            skillTextEdit.clear();
            skillTextEdit.insert(0, "50");
        }
    }

    Connections {
        target: button75
        onClicked: {
            skillTextEdit.clear();
            skillTextEdit.insert(0, "75");
        }
    }

    Connections {
        target: button100
        onClicked: {
            skillTextEdit.clear();
            skillTextEdit.insert(0, "100");
        }
    }

    Connections {
        target: buttonPlus1
        onClicked: {
            var value = parseInt(skillTextEdit.text);
            skillTextEdit.clear();
            skillTextEdit.insert(0, value + 1);
        }
    }

    Connections {
        target: buttonMinus1
        onClicked: {
            var value = parseInt(skillTextEdit.text);
            skillTextEdit.clear();
            skillTextEdit.insert(0, value - 1);
        }
    }

    Connections {
        target: buttonPlus10
        onClicked: {
            var value = parseInt(skillTextEdit.text);
            skillTextEdit.clear();
            skillTextEdit.insert(0, value + 10);
        }
    }

    Connections {
        target: buttonMinus10
        onClicked: {
            var value = parseInt(skillTextEdit.text);
            skillTextEdit.clear();
            skillTextEdit.insert(0, value - 10);
        }
    }

    RadioButton {
        id: radioButton
        x: 40
        y: 197
        text: qsTr("Very Easy")
    }

    RadioButton {
        id: radioButton1
        x: 40
        y: 243
        text: qsTr("Easy")
    }

    RadioButton {
        id: radioButton2
        x: 40
        y: 289
        text: qsTr("Standard")
        checked: true
    }

    RadioButton {
        id: radioButton3
        x: 40
        y: 335
        text: qsTr("Hard")
        autoExclusive: true
    }

    RadioButton {
        id: radioButton4
        x: 40
        y: 381
        text: qsTr("Formidable")
    }

    RadioButton {
        id: radioButton5
        x: 40
        y: 427
        text: qsTr("Herculean")
    }
}
