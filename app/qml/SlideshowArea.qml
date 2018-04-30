import QtQuick 2.9
import QtGraphicalEffects 1.0

Rectangle {
    anchors.fill: parent
    color: "#211e1e"
    layer.enabled: true
    layer.effect: DropShadow {
        horizontalOffset: 0
        verticalOffset: 1
        radius: 10
        samples: 32
        spread: 0.1
        color: Qt.rgba(0, 0, 0, 0.3)
    }

PropertyAnimation{
    id: endanim;
    target: completedinstalltextbx
    property: "opacity"
    to: 1;
    duration: 500
}

SequentialAnimation{
    id: seqinstallanim
    running: true
    loops: Animation.Infinite

    PropertyAnimation{
        id: startanim;
        target: ongoingtwoinstalltextbx
        property: "opacity"
        to: 1;
        duration: 500
    }
    PropertyAnimation{
        id: waitanim1;
        target: ongoingtwoinstalltextbx
        property: "opacity"
        to: 1;
        duration: 10000
    }
    PropertyAnimation{
        id: stopanim1;
        target: ongoingtwoinstalltextbx
        property: "opacity"
        to: 0;
        duration: 1000
    }
    PropertyAnimation{
        id: startanim2;
        target: ongoingoneinstalltextbx
        property: "opacity"
        to: 1;
        duration: 500
    }
    PropertyAnimation{
        id: waitanim2;
        target: ongoingoneinstalltextbx
        property: "opacity"
        to: 1;
        duration: 10000
    }
    PropertyAnimation{
        id: stopanim2;
        target: ongoingoneinstalltextbx
        property: "opacity"
        to: 0;
        duration: 1000
    }
}

Column{
    id: completedinstalltextbx
    anchors.topMargin: 7
    spacing: 7
    anchors.fill: parent
    opacity: 0

    Text {
        id: compinstalllbl1
        width: 396
        height: 20
        color: "#ffffff"
        text: qsTr("Completed Installation .. What's Next ?")
        font.italic: false
        font.bold: true
        font.family: "Tahoma"
        font.pointSize: dpiUnit * 3.25
    }

    Text {
        id: compinstalllbl2
        color: "#ffffff"
        text: qsTr("⬣ Restart your System  Session")
        font.family: "Tahoma"
        font.pointSize: dpiUnit * 3
    }

    Text {
        id: compinstalllbl3
        color: "#ffffff"
        text: qsTr("⬣ Plasmoid users need to activate the plasmoid by Right-clicking on the Desktop / Panel and picking 'Add Widget...'")
        wrapMode: Text.WordWrap
        textFormat: Text.AutoText
        verticalAlignment: Text.AlignTop
        font.family: "Tahoma"
        font.pointSize: dpiUnit * 3
    }

    Text {
        id: text3
        color: "#ffffff"
        text: qsTr("⬣ Register your devices at https:home.mycroft.ai with the pairing code")
        font.family: "Tahoma"
        font.pointSize: dpiUnit * 3
    }
}

Column{
    id: ongoingoneinstalltextbx
    anchors.topMargin: 7
    anchors.leftMargin: 5
    spacing: 10
    anchors.fill: parent
    opacity: 0

    Text {
        id: ongoinglbl1
        color: "#ffffff"
        text: qsTr("Some Awesome! Plasma Desktop Skills")
        font.italic: false
        font.bold: true
        font.family: "Tahoma"
        font.pointSize: dpiUnit * 3.25
    }

    Text {
        id: ongoinglbl1list1
        color: "#ffffff"
        text: qsTr("⬣ Krunner Search 'Hey Mycroft, Search This Computer For...'")
        font.family: "Tahoma"
        font.pointSize: dpiUnit * 3
    }

    Text {
        id: ongoinglbl1list2
        color: "#ffffff"
        text: qsTr("⬣ Plasma Activities 'Hey Mycroft, Show Activites / Switch Activity...'")
        wrapMode: Text.WordWrap
        textFormat: Text.AutoText
        verticalAlignment: Text.AlignTop
        font.family: "Tahoma"
        font.pointSize: dpiUnit * 3
    }

    Text {
        id: ongoinglbl1list3
        color: "#ffffff"
        text: qsTr("⬣ Wallpaper 'Hey Mycroft, Change Wallpaper Type Nature'")
        font.family: "Tahoma"
        font.pointSize: dpiUnit * 3
    }
}

Column{
    id: ongoingtwoinstalltextbx
    anchors.topMargin: 7
    anchors.leftMargin: 5
    spacing: 10
    anchors.fill: parent
    opacity: 0

    Text {
        id: ongoinglbl2
        color: "#ffffff"
        text: qsTr("What's New ?")
        font.italic: false
        font.bold: true
        font.family: "Tahoma"
        font.pointSize: dpiUnit * 3.25
    }

    Text {
        id: ongoinglbl2list1
        color: "#ffffff"
        text: qsTr("⬣ Updated Look & Feel")
        font.family: "Tahoma"
        font.pointSize: dpiUnit * 3
    }

    Text {
        id: ongoinglbl2list2
        color: "#ffffff"
        text: qsTr("⬣ Drag & Drop Image Recognization!")
        wrapMode: Text.WordWrap
        textFormat: Text.AutoText
        verticalAlignment: Text.AlignTop
        font.family: "Tahoma"
        font.pointSize: dpiUnit * 3
    }

    Text {
        id: ongoinglbl2list3
        color: "#ffffff"
        text: qsTr("⬣ Cool Skills With Infromation Displays")
        font.family: "Tahoma"
        font.pointSize: dpiUnit * 3
        }
    }
}
