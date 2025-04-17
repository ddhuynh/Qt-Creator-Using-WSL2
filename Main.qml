import QtQuick

Window
{
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    // Draws the scene from this qml file.
    Scene
    {
        anchors.fill: parent

        Text
        {
            text: "Here's a really simple application. You can move around using WASD. Click and drag to move the camera."
        }
    }
}
