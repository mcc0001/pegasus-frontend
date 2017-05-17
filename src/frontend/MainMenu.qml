// Pegasus Frontend
// Copyright (C) 2017  Mátyás Mustoha
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.


import "menuitems"
import QtQuick 2.8


FocusScope {
    Keys.onEscapePressed: toggleMenu()

    Rectangle {
        id: shade
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
            right: menuPanel.left
        }

        color: "black"
        opacity: 0
        visible: opacity > 0

        MouseArea {
            anchors.fill: parent
            onClicked: toggleMenu()
        }
    }

    Text {
        id: revision
        text: pegasus.meta.gitRevision
        color: "#eee"
        font {
            pixelSize: rpx(12)
            family: "monospace"
        }
        anchors {
            left: parent.left
            bottom: parent.bottom
            margins: rpx(10)
        }
        visible: false
    }

    Rectangle {
        id: menuPanel
        color: "#333"
        width: rpx(420)
        height: parent.height
        visible: x < parent.width
        x: parent.width

        PrimaryMenuItem {
            id: mbSettings
            text: qsTr("Settings")
            selected: focus

            focus: true
            KeyNavigation.down: mbControls
            Keys.onSpacePressed: quitSubmenu.visible = !quitSubmenu.visible
            anchors.bottom: mbControls.top
        }
        PrimaryMenuItem {
            id: mbControls
            text: qsTr("Controls")
            selected: focus

            KeyNavigation.up: mbSettings
            KeyNavigation.down: mbQuit
            anchors.bottom: mbQuit.top
        }
        PrimaryMenuItem {
            id: mbQuit
            text: qsTr("Quit")
            onActivated: {
                if (quitSubmenu.focus) mbQuit.forceActiveFocus()
                else quitSubmenu.forceActiveFocus()
            }
            selected: focus || quitSubmenu.visible

            KeyNavigation.up: mbControls
            anchors.bottom: menuFooter.top
        }
        FocusScope {
            id: quitSubmenu
            width: parent.width
            height: quitSubmenuColumn.height
            visible: focus || (mbQuit.focus && subMenuAnim.running)
            anchors.bottom: menuFooter.top

            Column {
                id: quitSubmenuColumn
                width: parent.width

                SecondaryMenuItem {
                    id: mbQuitShutdown
                    text: qsTr("Shutdown")
                    onActivated: pegasus.system.shutdown()

                    focus: true
                    KeyNavigation.down: mbQuitReboot
                    Keys.onEscapePressed: mbQuit.forceActiveFocus()
                }
                SecondaryMenuItem {
                    id: mbQuitReboot
                    text: qsTr("Reboot")
                    onActivated: pegasus.system.reboot()

                    KeyNavigation.up: mbQuitShutdown
                    KeyNavigation.down: mbQuitExit
                    Keys.onEscapePressed: mbQuit.forceActiveFocus()
                }
                SecondaryMenuItem {
                    id: mbQuitExit
                    text: qsTr("Exit Pegasus")
                    onActivated: Qt.quit()

                    KeyNavigation.up: mbQuitReboot
                    Keys.onEscapePressed: mbQuit.forceActiveFocus()
                }
            }
        }
        Item {
            id: menuFooter
            width: parent.width
            height: rpx(30)
            anchors.bottom: parent.bottom
        }

        states: State {
            name: "quitOpen"; when: quitSubmenu.focus
            AnchorChanges { target: mbQuit; anchors.bottom: quitSubmenu.top }
        }

        transitions: Transition {
            id: subMenuAnim
            AnchorAnimation { duration: 150 }
        }
    }

    states: State {
        name: "menuOpen"; when: activeFocus
        PropertyChanges { target: shade; opacity: 0.75 }
        PropertyChanges { target: revision; visible: true }
        PropertyChanges { target: menuPanel; x: parent.width - width }
    }

    transitions: Transition {
        NumberAnimation { properties: "opacity,x"; duration: 300; easing.type: Easing.OutCubic }
    }
}