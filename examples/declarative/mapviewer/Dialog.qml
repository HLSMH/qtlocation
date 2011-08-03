/****************************************************************************
**
** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the examples of the Qt Mobility Components.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
**     the names of its contributors may be used to endorse or promote
**     products derived from this software without specific prior written
**     permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 1.1
import "common" as Common

Item {
    id: dialog
    signal goButtonClicked
    signal cancelButtonClicked

    anchors.fill: parent

    property alias title: titleBar.text
    property alias dialogModel: dialogModel
    property alias length: dialogModel.count
    property int gap: 20
    property int listItemHeight: 30

    opacity: 0

    function setModel(objects)
    {
        dialogModel.clear()

        for (var i=0; i< objects.length; i++){
            dialogModel.append({"labelText": objects[i][0], "inputText": objects[i][1]})
        }
    }

    Common.Fader {}

    Rectangle {
        id: dialogRectangle

        color: "lightsteelblue"
        opacity: parent.opacity
        width: parent.width - gap;
        height: listview.height + titleBar.height + buttons.height + gap*2

        anchors {
            top: parent.top
            topMargin: 50
            left: parent.left
            leftMargin: gap/2
        }

        border.width: 1
        border.color: "darkblue"
        radius: 5

        Common.TitleBar {
            id: titleBar;
            width: parent.width; height: 40;
            anchors.top: parent.top; anchors.left: parent.left;
            opacity: 0.9
            onClicked: { dialog.cancelButtonClicked() }
        }

        ListModel {
            id: dialogModel
        }

        Component{
            id: listDelegate
            Column {
                id: column1
                height: listItemHeight
                TextWithLabel {
                    id: textWithLabel
                    label: labelText
                    text: inputText
                    width: dialogRectangle.width - gap
                    labelWidth: 75

                    onTextChanged:
                    {
                        dialogModel.set(index, {"inputText": text})
                    }
                }
            }
        }

        ListView {
            id: listview
            anchors {
                top: titleBar.bottom
                topMargin: gap
                left: parent.left
                leftMargin: gap/2
            }
            model: dialogModel
            delegate: listDelegate
            spacing: gap/2
            interactive: false
            Component.onCompleted: {
                height = (listItemHeight + gap/2)*length + gap/2
            }
        }

        Row {
            id: buttons
            anchors.top: listview.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: gap/3
            height: 32
            Common.Button {
                id: buttonClearAll
                text: "Clear"
                width: 80; height: parent.height
                onClicked: {
                    for (var i = 0; i<length; i++){
                       dialogModel.set(i, {"inputText": ""})
                    }
                }
            }
            Common.Button {
                id: buttonGo
                text: "Go!"
                width: 80; height: parent.height
                onClicked: {
                    dialog.goButtonClicked ()
                }
            }
        }
    }
}
