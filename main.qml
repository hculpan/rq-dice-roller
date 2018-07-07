import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.0
import Qt.labs.handlers 1.0
import Qt.labs.folderlistmodel 2.11
import Qt.labs.calendar 1.0

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

    function calcThreshold() {
        var threshold = parseInt(skillTextEdit.text);
        if (radioButtonVeryEasy.checked) {
            threshold *=2;
        } else if (radioButtonEasy.checked) {
            threshold = Math.ceil(threshold * 1.5);
        } else if (radioButtonHard.checked) {
            threshold = Math.ceil(threshold * 0.66);
        } else if (radioButtonFormidable.checked) {
            threshold = Math.ceil(threshold * 0.5);
        } else if (radioButtonHerculean.checked) {
            threshold = Math.ceil(threshold * 0.1);
        }

        return threshold;
    }

    Connections {
        target: button
        onClicked: {
            textField.clear();
            if (skillTextEdit.text) {
                var roll = Math.floor(Math.random() * 100) + 1;
                var threshold = calcThreshold();
                var critThreshold = Math.ceil(threshold * 0.1);
                if (roll <= critThreshold) {
                    canvas.fillStyle = "#42f459"
                    textField.insert(0, "Critical Success (%1:%2)".arg(roll).arg(threshold));
                } else if (roll == 99 || roll == 100) {
                    canvas.fillStyle = "#f42a1f"
                    textField.insert(0, "Critical Failure (%1:%2)".arg(roll).arg(threshold));
                } else if (roll <= threshold) {
                    canvas.fillStyle = "#42f459"
                    textField.insert(0, "Success (%1:%2)".arg(roll).arg(threshold));
                } else {
                    canvas.fillStyle = "#f42a1f"
                    textField.insert(0, "Failure (%1:%2)".arg(roll).arg(threshold));
                }
            } else {
                textField.insert(0, "Error, you idiot!");
            }

            canvas.requestPaint();
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
        id: radioButtonVeryEasy
        x: 40
        y: 197
        text: qsTr("Very Easy")
    }

    RadioButton {
        id: radioButtonEasy
        x: 40
        y: 243
        text: qsTr("Easy")
    }

    RadioButton {
        id: radioButtonStandard
        x: 40
        y: 289
        text: qsTr("Standard")
        checked: true
    }

    RadioButton {
        id: radioButtonHard
        x: 40
        y: 335
        text: qsTr("Hard")
        autoExclusive: true
    }

    RadioButton {
        id: radioButtonFormidable
        x: 40
        y: 381
        text: qsTr("Formidable")
    }

    RadioButton {
        id: radioButtonHerculean
        x: 40
        y: 427
        text: qsTr("Herculean")
    }

    Item {
        id: item1
        x: 167
        y: 215
        width: 162
        height: 241

        Canvas {
            id: canvas
            width: 162
            height: 241

            property color fillStyle : "#ffffff";
            property string text : "";

            onPaint: {
                var ctx = getContext("2d");
                ctx.save();
                ctx.clearRect(0, 0, canvas.width, canvas.height);
                ctx.strokeStyle = Qt.darker(fillStyle, 1.4)
                ctx.lineWidth = 3
                ctx.fillStyle = canvas.fillStyle;
//                ctx.globalAlpha = canvas.alpha
                ctx.beginPath();
                ctx.moveTo(0, 0);
                ctx.lineTo(canvas.width, 0);
                ctx.lineTo(canvas.width, canvas.height);
                ctx.lineTo(0, canvas.height);
                ctx.lineTo(0, 0);
                ctx.closePath();
                ctx.fill();
                ctx.stroke();
                ctx.restore();
            }
        }
    }
}
