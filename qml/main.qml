import QtQuick 2.3
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import MycroftLauncher 1.0

ApplicationWindow {
    id: root
    visible: true
    width: 640
    height: 400
    minimumHeight: 400
    minimumWidth: 640
    maximumHeight: 400
    maximumWidth: 640
    title: qsTr("Mycroft AI Setup")

    Component.onCompleted: {
        seqinstallanim.running = true;
    }

    property string distrotype: distrogroup.checkedButton.objectName
    property string installtype: installtypegroup.checkedButton.objectName

    Connections {
        target: myLauncher

        onProcessed: {
            console.log(str)
            switch(str){
            case "debiangitInstallcompleted":
                debiangetInstallers()
                break;
            case "debiangetInstallerscompleted":
                if(installtype === "coreplasmoid"){
                debianInstall()
                }
                else if(installtype === "coreonly"){
                debianInstallCoreOnly()
                }
                else if(installtype === "plasmoidonly"){
                debianInstallPlasmoidOnly()
                }
                break;
            case "debianInstallcompleted":
                pbarstop()
                break
            case "fedoragitInstallcompleted":
                fedoragetInstallers()
                break;
            case "fedoragetInstallerscompleted":
                if(installtype === "coreplasmoid"){
                fedoraInstall()
                }
                else if(installtype === "coreonly"){
                fedoraInstallCoreOnly()
                }
                else if(installtype === "plasmoidonly"){
                fedoraInstallPlasmoidOnly()
                }
                break;
            case "fedoraInstallcompleted":
                pbarstop()
                break
            }
        }
    }

    function gitInstallDebian(){
        myLauncher.launchScript("konsole -e pkexec sudo apt install git")
        myLauncher.mText("debiangitInstallcompleted");
    }

    function debiangetInstallers(){
        myLauncher.launchScript("konsole -e git clone -b guiver https://github.com/aiix/installers.git /tmp/installers")
        myLauncher.mText("debiangetInstallerscompleted");
    }

    function debianInstall(){
        myLauncher.launchScript("konsole -e bash /tmp/installers/kde_plasmoid_debian/install.sh")
        myLauncher.mText("debianInstallcompleted");
    }

    function debianInstallCoreOnly(){
        myLauncher.launchScript("konsole -e bash /tmp/installers/kde_plasmoid_debian/installcore.sh")
        myLauncher.mText("debianInstallcompleted");
    }

    function debianInstallPlasmoidOnly(){
        myLauncher.launchScript("konsole -e bash /tmp/installers/kde_plasmoid_debian/installplasmoid.sh")
        myLauncher.mText("debianInstallcompleted");
    }

    function gitInstallFedora(){
        myLauncher.launchScript("konsole -e pkexec sudo dnf install git")
        myLauncher.mText("fedoragitInstallcompleted");
    }

    function fedoragetInstallers(){
        myLauncher.launchScript("konsole -e git clone -b guiver https://github.com/aiix/installers.git /tmp/installers")
        myLauncher.mText("fedoragetInstallerscompleted");
    }

    function fedoraInstall(){
        myLauncher.launchScript("konsole -e bash /tmp/installers/kde_plasmoid_fedora/install.sh")
        myLauncher.mText("fedoraInstallcompleted");
    }

    function fedoraInstallCoreOnly(){
        myLauncher.launchScript("konsole -e bash /tmp/installers/kde_plasmoid_fedora/installcore.sh")
        myLauncher.mText("fedoraInstallcompleted");
    }

    function fedoraInstallPlasmoidOnly(){
        myLauncher.launchScript("konsole -e bash /tmp/installers/kde_plasmoid_fedora/installplasmoid.sh")
        myLauncher.mText("fedoraInstallcompleted");
    }

    function pbarstart(){
        progressBar1.indeterminate = true
        text5p2.text = "Installating"
    }

    function pbarstop(){
        progressBar1.indeterminate = false
        progressBar1.value = 1.0
        ongoingtwoinstalltextbx.opacity = 0
        ongoingoneinstalltextbx.opacity = 0
        text5p2.text = "Installation Completed"
        seqinstallanim.running = false
        endanim.running = true
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

    ScriptLauncher { id: myLauncher }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page {
            id: p1info
            width: 640
            height: 400

            Rectangle {
                id: rectangle1
                color: "#202328"
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0
                border.color: "#2b2b2b"
                anchors.fill: parent

                ButtonGroup {
                    id: distrogroup
                    buttons: column.children
                }

                ButtonGroup {
                    id: installtypegroup
                    buttons: column2.children
                }

                Rectangle {
                    id: rectangle5
                    x: 0
                    y: 0
                    width: 640
                    height: 132
                    color: "#211e1e"

                    Image {
                        id: image1
                        x: 0
                        y: 3
                        width: 128
                        height: 126
                        source: "qrc:images/mycroft_logo.png"
                    }

                    Text {
                        id: text1
                        x: 125
                        y: 50
                        width: 508
                        height: 33
                        color: "#76bbe9"
                        text: qsTr("Let's Get Started Setting Up Mycroft AI")
                        horizontalAlignment: Text.AlignHCenter
                        font.bold: true
                        font.family: "Tahoma"
                        font.pixelSize: 21
                    }
                }

                Rectangle {
                    id: rectangle2
                    x: -1
                    y: 132
                    width: 320
                    height: 202
                    color: "#00000000"
                    border.color: "#00000000"

                    Column {
                        id: column
                        x: -22
                        y: 53
                        spacing: 6

                        RadioButton {
                            id: sysselecter1
                            x: 27
                            y: 220
                            checked: true
                            objectName: "distrodebian"
                            text: "Kubuntu 17.04 ⤴/ KDE Neon"
                        }

                        RadioButton {
                            id: sysselecter2
                            x: 27
                            y: 265
                            objectName: "distrofedora"
                            text: "Fedora 25 KDE Spin ⤴"
                        }

                        RadioButton {
                            id: sysselecter3
                            x: 27
                            y: 265
                            enabled: false
                            objectName: "distrosuse"
                            text: "OpenSuse Tumbleweed"
                        }
                    }

                    Text {
                        id: text5p1
                        x: 4
                        y: 16
                        color: "#ffffff"
                        text: qsTr("Step 1: Select Distribution")
                        font.bold: true
                        font.italic: false
                        font.underline: true
                        font.family: "Tahoma"
                        font.pixelSize: 15
                    }

                }

                Rectangle {
                    id: rectangle3
                    x: 321
                    y: 132
                    width: 320
                    height: 150
                    color: "#00000000"
                    border.color: "#00000000"

                    Column {
                        id: column2
                        x: -22
                        y: 54
                        spacing: 6

                        RadioButton {
                            id: coreinstalltype
                            x: 27
                            y: 220
                            checked: true
                            objectName: "coreplasmoid"
                            text: "Install Mycroft Core + KDE Plasmoid"
                        }

                        RadioButton {
                            id: coreplasmoidinstalltype
                            x: 27
                            y: 265
                            checked: false
                            objectName: "coreonly"
                            text: "Install Mycroft Core"
                        }

                        RadioButton {
                            id: plasmoidinstalltype
                            x: 27
                            y: 320
                            objectName: "plasmoidonly"
                            text: "Install KDE Plasmoid"
                        }
                    }

                    Text {
                        id: text6p1
                        x: 8
                        y: 16
                        color: "#ffffff"
                        text: qsTr("Step 2: Select Type")
                        font.bold: true
                        font.underline: true
                        font.italic: false
                        font.family: "Tahoma"
                        font.pixelSize: 15
                    }
                }
            }
        }

        Page {
            id: p2installer
            width: 640
            height: 400

            Rectangle {
                id: rectangle1p2
                color: "#202328"
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0
                border.color: "#2b2b2b"
                anchors.fill: parent

                Text {
                    id: text1p2
                    x: 22
                    y: 44
                    color: "#fbfbfb"
                    text: qsTr("Please Note:")
                    font.bold: true
                    font.family: "Tahoma"
                    font.pixelSize: 15
                }

                Text {
                    id: text2p2
                    x: 22
                    y: 129
                    color: "#ffffff"
                    text: qsTr("This installation requires an Active Internet Connection")
                    textFormat: Text.PlainText
                    font.italic: true
                    font.family: "Tahoma"
                    font.bold: false
                    font.pixelSize: 13
                }

                Text {
                    id: text4p2
                    x: 22
                    y: 70
                    width: 538
                    height: 40
                    color: "#ffffff"
                    text: qsTr("The installation procedure might require you to enter your administrator password multiple times to be able to successfully install Mycroft AI and its components")
                    textFormat: Text.PlainText
                    font.family: "Tahoma"
                    wrapMode: Text.WordWrap
                    font.pixelSize: 13
                }

                Button {
                    id: button1p2
                    x: 22
                    y: 155
                    text: qsTr("Install")

                    onClicked: {
                        text5p2.text = "Installing"
                        switch(distrotype){
                        case "distrodebian":
                            console.log("debian")
                            switch(installtype){
                            case "coreonly":
                                gitInstallDebian();
                                pbarstart();
                                break
                            case "coreplasmoid":
                                gitInstallDebian();
                                pbarstart();
                                break
                            case "plasmoidonly":
                                gitInstallDebian();
                                pbarstart();
                                break
                            }
                            break
                        case "distrofedora":
                            console.log("fedora")
                            switch(installtype){
                            case "coreonly":
                                gitInstallFedora();
                                pbarstart();
                                break
                            case "coreplasmoid":
                                gitInstallFedora();
                                pbarstart();
                                break
                            case "plasmoidonly":
                                gitInstallFedora();
                                pbarstart();
                                break
                            }
                            break
                        }
                    }
                }

                ProgressBar {
                    id: progressBar1
                    anchors.centerIn: parent
                    width: 432
                    height: 16
                    indeterminate: false
                }

                Text {
                    id: text5p2
                    anchors.top: progressBar1.bottom
                    anchors.topMargin: 5
                    anchors.left: progressBar1.left
                    anchors.right: progressBar1.right
                    color: "#ffffff"
                    text: qsTr("Ready To Install")
                    font.italic: true
                    font.bold: false
                    font.family: "Tahoma"
                    font.pixelSize: 12
                }

                Rectangle {
                    id: rectangle4
                    x: 0
                    y: 220
                    width: 640
                    height: 180
                    color: "#211e1e"

                    Column{
                        id: completedinstalltextbx
                        anchors.topMargin: 7
                        spacing: 7
                        anchors.fill: parent
                        opacity: 0

                        Text {
                            id: text5
                            x: 16
                            y: 14
                            width: 396
                            height: 20
                            color: "#ffffff"
                            text: qsTr("Completed Installation .. What's Next ?")
                            font.italic: false
                            font.bold: true
                            font.family: "Tahoma"
                            font.pixelSize: 17
                        }

                        Text {
                            id: text2
                            x: 16
                            y: 48
                            color: "#ffffff"
                            text: qsTr("⬣ Restart your System / Session")
                            font.family: "Tahoma"
                            font.pixelSize: 14
                        }

                        Text {
                            id: text4
                            x: 16
                            y: 72
                            width: 546
                            height: 36
                            color: "#ffffff"
                            text: qsTr("⬣ Plasmoid users need to activate the plasmoid by Right-clicking on the Desktop / Panel and picking 'Add Widget...'")
                            wrapMode: Text.WordWrap
                            textFormat: Text.AutoText
                            verticalAlignment: Text.AlignTop
                            font.family: "Tahoma"
                            font.pixelSize: 14
                        }

                        Text {
                            id: text3
                            x: 16
                            y: 96
                            color: "#ffffff"
                            text: qsTr("⬣ Register your devices at https://home.mycroft.ai with the pairing code")
                            font.family: "Tahoma"
                            font.pixelSize: 14
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
                            id: text5new
                            x: 16
                            y: 14
                            width: 396
                            height: 20
                            color: "#ffffff"
                            text: qsTr("Some Awesome! Plasma Desktop Skills")
                            font.italic: false
                            font.bold: true
                            font.family: "Tahoma"
                            font.pixelSize: 17
                        }

                        Text {
                            id: text2new
                            color: "#ffffff"
                            text: qsTr("⬣ Krunner Search 'Hey Mycroft, Search This Computer For...'")
                            font.family: "Tahoma"
                            font.pixelSize: 14
                        }

                        Text {
                            id: text4new
                            color: "#ffffff"
                            text: qsTr("⬣ Plasma Activities 'Hey Mycroft, Show Activites / Switch Activity...'")
                            wrapMode: Text.WordWrap
                            textFormat: Text.AutoText
                            verticalAlignment: Text.AlignTop
                            font.family: "Tahoma"
                            font.pixelSize: 14
                        }

                        Text {
                            id: text3new
                            color: "#ffffff"
                            text: qsTr("⬣ Wallpaper 'Hey Mycroft, Change Wallpaper Type Nature'")
                            font.family: "Tahoma"
                            font.pixelSize: 14
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
                            id: text5tips
                            x: 16
                            y: 14
                            width: 396
                            height: 20
                            color: "#ffffff"
                            text: qsTr("What's New ?")
                            font.italic: false
                            font.bold: true
                            font.family: "Tahoma"
                            font.pixelSize: 17
                        }

                        Text {
                            id: text2tips
                            color: "#ffffff"
                            text: qsTr("⬣ Updated Look & Feel")
                            font.family: "Tahoma"
                            font.pixelSize: 14
                        }

                        Text {
                            id: text4tips
                            color: "#ffffff"
                            text: qsTr("⬣ Drag & Drop Image Recognization!")
                            wrapMode: Text.WordWrap
                            textFormat: Text.AutoText
                            verticalAlignment: Text.AlignTop
                            font.family: "Tahoma"
                            font.pixelSize: 14
                        }

                        Text {
                            id: text3tips
                            color: "#ffffff"
                            text: qsTr("⬣ Cool Skills With Infromation Displays")
                            font.family: "Tahoma"
                            font.pixelSize: 14
                        }
                    }
                }

                Rectangle {
                    id: rectangle6
                    y: 34
                    width: 640
                    height: 1
                    color: "#211e1e"
                }

            }
        }
    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton {
            text: qsTr("Getting Started")
        }
        TabButton {
            text: qsTr("Install")
        }
    }
}
