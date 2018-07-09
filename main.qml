import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.0
import Qt.labs.handlers 1.0
import Qt.labs.folderlistmodel 2.11
import Qt.labs.calendar 1.0

Window {
    visible: true
    width: 275
    height: 390
    title: qsTr("Runequest Dice Roller")
    maximumHeight: 390
    maximumWidth: 370
    minimumHeight: 390
    minimumWidth: 370

    TextEdit {
        id: skillTextEdit
        x: 137
        y: 63
        width: 40
        height: 20
        text: qsTr("50")
        bottomPadding: -4
        font.pixelSize: 12
    }

    Text {
        id: text1
        x: 42
        y: 63
        width: 89
        height: 15
        text: qsTr("Skill:")
        horizontalAlignment: Text.AlignRight
        font.pixelSize: 12
    }

    Button {
        id: button
        x: 87
        y: 142
        text: qsTr("Roll")
    }

    Connections {
        target: button
        onClicked: {
            if (skillTextEdit.text) {
                var roll = Math.floor(Math.random() * 100) + 1;
                var threshold = parseInt(skillTextEdit.text);
                var critThreshold = Math.ceil(threshold * 0.1);

                canvas.roll = roll;
                canvas.skillLevel = threshold;
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
            y: 0
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
        x: 60
        y: 91

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

    function writeOutput(roll, threshold, row, ctx, rowName) {
        var messageLeft;
        var messageRight = " : %1".arg(rowName)
        if (roll >= 99) {
            ctx.fillStyle = "#ba1401";
            ctx.fillRect(6, (row * 21) + 6, canvas.width - 12, 20)

            ctx.fillStyle = "lightgray";
            messageLeft = "%1 > %2".arg(roll).arg(threshold);
        } else if (roll <= threshold) {
            if (roll <= Math.ceil(threshold * .1)) {
                ctx.fillStyle = "#89f442";
                ctx.fillRect(6, (row * 21) + 6, canvas.width - 12, 20)
            }

            ctx.fillStyle = "black";
            messageLeft = "%1 <= %2".arg(roll).arg(threshold);
        } else {
            ctx.fillStyle = "lightgray";
            messageLeft = "%1 > %2".arg(roll).arg(threshold);
        }
        var half = canvas.width / 2;
        ctx.textAlign = "right";
        ctx.fillText(messageLeft, half, (row * 21) + 21);
        ctx.textAlign = "left";
        ctx.fillText(messageRight, half, (row * 21) + 21);
    }

    Item {
        id: item1
        x: 167
        y: 215
        width: 162
        height: 133

        Canvas {
            id: canvas
            width: 207
            height: 143

            property color fillStyle : "#ffffff";
            property string text : "";

            property int roll;
            property int skillLevel;
            x: -134
            y: 0

            onPaint: {
                var ctx = getContext("2d");
                ctx.save();
                ctx.clearRect(0, 0, canvas.width, canvas.height);

                ctx.strokeStyle = Qt.darker(fillStyle, 1.4)
                ctx.lineWidth = 2
                ctx.fillStyle = canvas.fillStyle;
                ctx.beginPath();
                ctx.moveTo(0, 0);
                ctx.lineTo(canvas.width, 0);
                ctx.lineTo(canvas.width, canvas.height);
                ctx.lineTo(0, canvas.height);
                ctx.lineTo(0, 0);
                ctx.closePath();

                ctx.fill();
                ctx.stroke();

                ctx.font = "15pt Arial";

                if (canvas.roll != 0) {
                    writeOutput(canvas.roll, canvas.skillLevel * 2, 0, ctx, "Very Easy");
                    writeOutput(canvas.roll, Math.ceil(canvas.skillLevel * 1.5), 1, ctx, "Easy");
                    writeOutput(canvas.roll, canvas.skillLevel, 2, ctx, "Standard");
                    writeOutput(canvas.roll, Math.ceil(canvas.skillLevel * .66), 3, ctx, "Hard");
                    writeOutput(canvas.roll, Math.ceil(canvas.skillLevel * .5), 4, ctx, "Formidable");
                    writeOutput(canvas.roll, Math.ceil(canvas.skillLevel * .1), 5, ctx, "Herculean");
                }

                ctx.restore();
            }
        }
    }
}
