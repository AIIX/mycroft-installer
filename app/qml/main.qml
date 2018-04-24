import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import MycroftLauncher 1.0
import QMLTermWidget 1.0
import QtGraphicalEffects 1.0

ApplicationWindow {
    id: root
    visible: true
    minimumHeight: Screen.desktopAvailableHeight / 2
    minimumWidth: Screen.desktopAvailableWidth / 2
    maximumHeight: Screen.desktopAvailableHeight / 2
    maximumWidth: Screen.desktopAvailableWidth / 2
    title: qsTr("Mycroft AI Setup")

    property string distrotype: distrogroup.checkedButton.objectName
    property string installtype: installtypegroup.checkedButton.objectName
    property string ubuntuversion: ubuntuveriontypegroup.checkedButton.objectName
    property string fedoraversion: fedoraveriontypegroup.checkedButton.objectName
    property string currentPos

    function gitInstallDebian(){
        progressText.text = qsTr("Installing Git")
        var installgitarg = ["-c", "pkexec apt install git"]
        mainsession.setShellProgram("bash");
        mainsession.setArgs(installgitarg)
        mainsession.startShellProgram()
        currentPos = "debiangitInstallcompleted"
    }

    function debiancleanInstaller(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = qsTr("Cleaning Previous Installer Files")
        var cleaninstallerfiles = ["-c", "rm -rf /tmp/installers"]
        mainsession.setShellProgram("bash");
        mainsession.setArgs(cleaninstallerfiles)
        mainsession.startShellProgram();
        currentPos = "debiancleanInstallerCompleted"
    }

    function debiangetInstallers(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = qsTr("Downloading Installation Files")
        var getinstallersarg = ["-c", "git clone -b guiver https://github.com/aiix/installers.git /tmp/installers"]
        mainsession.setShellProgram("bash");
        mainsession.setArgs(getinstallersarg)
        mainsession.startShellProgram();

        if(installtype === "coreplasmoid"){
            currentPos = "debiangetInstallerscompleted"
        }
        else if(installtype === "coreonly"){
            currentPos = "debiangetInstallerscompletedcoreonly"
        }
        else if(installtype === "plasmoidonly"){
            currentPos = "debianinstallmycroftcompleted"
        }
    }

    function debianCloneMycroftInstall(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = "Downloading Mycroft-Core"
        var getmycorearg = ["-c", "git clone https://github.com/MycroftAi/mycroft-core /home/$USER/mycroft-core"]
        mainsession.setShellProgram("bash");
        mainsession.setArgs(getmycorearg);
        mainsession.startShellProgram();
        currentPos = "debiangetMycroftcompleted"
    }

    function debianCloneMycroftInstallcoreonly(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = "Downloading Mycroft-Core"
        var getmycorearg = ["-c", "git clone https://github.com/MycroftAi/mycroft-core /home/$USER/mycroft-core"]
        mainsession.setShellProgram("bash");
        mainsession.setArgs(getmycorearg);
        mainsession.startShellProgram();
        currentPos = "debiangetMycroftcompletedcoreonly"
    }

    function debianCopyInstallToHome(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = "Installing System Dependencies"
        var copyinstallr = ["-c", "/tmp/installers/kde_plasmoid_debian/copy.sh"]
        mainsession.setShellProgram("bash");
        mainsession.setArgs(copyinstallr);
        mainsession.startShellProgram();
        currentPos = "debiancopyinstallercompleted"
    }

    function debianCopyInstallToHomecoreonly(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = "Installing System Dependencies"
        var copyinstallr = ["-c", "/tmp/installers/kde_plasmoid_debian/copy.sh"]
        mainsession.setShellProgram("bash");
        mainsession.setArgs(copyinstallr);
        mainsession.startShellProgram();
        currentPos = "debiancopyinstallercompletedcoreonly"
    }

    function debianInstallSystemDeps(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = "Installing System Dependencies"

        if(ubuntuversion === "ubuntuxenial"){
            var installsysdeparg = ["-c", "pkexec /home/$USER/mycroft-core/depsXenial.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installsysdeparg);
            mainsession.startShellProgram();
            currentPos = "debianinstallsysdepscompleted"
        }
        else if(ubuntuversion === "ubuntubionic"){
            var installsysdeparg2 = ["-c", "pkexec /home/$USER/mycroft-core/depsBionic.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installsysdeparg2);
            mainsession.startShellProgram();
            currentPos = "debianinstallsysdepscompleted"
        }
    }

    function debianInstallSystemDepscoreonly(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = "Installing System Dependencies"

        if(ubuntuversion === "ubuntuxenial"){
            var installsysdeparg = ["-c", "pkexec /home/$USER/mycroft-core/depsXenial.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installsysdeparg);
            mainsession.startShellProgram();
            currentPos = "debianinstallsysdepscompletedcoreonly"
        }
        else if(ubuntuversion === "ubuntubionic"){
            var installsysdeparg2 = ["-c", "pkexec /home/$USER/mycroft-core/depsBionic.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installsysdeparg2);
            mainsession.startShellProgram();
            currentPos = "debianinstallsysdepscompletedcoreonly"
        }
    }

    function debianInstallMycroft(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = "Installing Mycroft-Core"
        var installmycroftsh = ["-c", "/home/$USER/mycroft-core/installmycroft.sh"]
        mainsession.setShellProgram("bash");
        mainsession.setArgs(installmycroftsh);
        mainsession.startShellProgram();
        currentPos = "debianinstallmycroftcompleted"
    }

    function debianInstallMycroftCoreOnly(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = "Installing Mycroft-Core"
        var installmycroftsh = ["-c", "/home/$USER/mycroft-core/installmycroft.sh"]
        mainsession.setShellProgram("bash");
        mainsession.setArgs(installmycroftsh);
        mainsession.startShellProgram();
        currentPos = "debiancoreonlyinstallcompleted"
    }

    function debianGetPlasmoid(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = "Downloading Mycroft-Plasmoid"
        var getplasmoid = ["-c", "git clone https://anongit.kde.org/plasma-mycroft.git /home/$USER/plasma-mycroft"]
        mainsession.setShellProgram("bash");
        mainsession.setArgs(getplasmoid);
        mainsession.startShellProgram();
        currentPos = "debiangetplasmoidcompleted"
    }

    function debianInstallPlasmoidDeps(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = "Installing Plasmoid System Dependencies"
        var installplasmoiddeps = ["-c", "pkexec /tmp/installers/kde_plasmoid_debian/appletdeps.sh"]
        mainsession.setShellProgram("bash");
        mainsession.setArgs(installplasmoiddeps);
        mainsession.startShellProgram();
        currentPos = "debianinstallplasmoiddepscompleted"
    }

    function debianInstallPlasmoid(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = "Building & Installing Plasmoid"
        var installplasmoid = ["-c", "pkexec /tmp/installers/kde_plasmoid_debian/appletdeps.sh"]
        mainsession.setShellProgram("bash");
        mainsession.setArgs(installplasmoid);
        mainsession.startShellProgram();
        currentPos = "debianplasmoidinstallcompleted"
    }

    function installationCompleted(){
        mainsession.hasFinished = true
        currentPos = ""
        progressText.text = "Installation Completed!"
        progressBar1.indeterminate = false
        progressBar1.value = 1
        exitinstallerbtn.enabled = true
        exitinstallerbtn.visible = true
    }

    function gitInstallFedora(){
        progressText.text = qsTr("Installing Git")
        var installgitarg = ["-c", "pkexec dnf install git -y"]
        mainsession.setShellProgram("bash");
        mainsession.setArgs(installgitarg)
        mainsession.startShellProgram()
        currentPos = "fedoragitInstallcompleted"
    }

    function fedoracleanInstaller(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = qsTr("Cleaning Previous Installer Files")
        var cleaninstallerfiles = ["-c", "rm -rf /tmp/installers"]
        mainsession.setShellProgram("bash");
        mainsession.setArgs(cleaninstallerfiles)
        mainsession.startShellProgram();
        currentPos = "fedoracleanInstallerCompleted"
    }

    function fedoragetInstallers(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = qsTr("Downloading Installation Files")
        var getinstallersarg = ["-c", "git clone -b guiver https://github.com/aiix/installers.git /tmp/installers"]
        mainsession.setShellProgram("bash");
        mainsession.setArgs(getinstallersarg)
        mainsession.startShellProgram();

        if(installtype === "coreplasmoid"){
            currentPos = "fedoragetInstallerscompleted"
        }
        else if(installtype === "coreonly"){
            currentPos = "fedoragetInstallerscompletedcoreonly"
        }
        else if(installtype === "plasmoidonly"){
            currentPos = "fedorainstallmycroftcompleted"
        }
    }

    function fedoraCloneMycroftInstall(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = "Downloading Mycroft-Core"
        var getmycorearg = ["-c", "git clone https://github.com/MycroftAi/mycroft-core /home/$USER/mycroft-core"]
        mainsession.setShellProgram("bash");
        mainsession.setArgs(getmycorearg);
        mainsession.startShellProgram();
        currentPos = "fedoragetMycroftcompleted"
    }

    function fedoraCloneMycroftInstallcoreonly(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = "Downloading Mycroft-Core"
        var getmycorearg = ["-c", "git clone https://github.com/MycroftAi/mycroft-core /home/$USER/mycroft-core"]
        mainsession.setShellProgram("bash");
        mainsession.setArgs(getmycorearg);
        mainsession.startShellProgram();
        currentPos = "fedoragetMycroftcompletedcoreonly"
    }

    function fedoraCopyInstallToHome(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = "Installing System Dependencies"
        var copyinstallr = ["-c", "/tmp/installers/kde_plasmoid_fedora/copy.sh"]
        mainsession.setShellProgram("bash");
        mainsession.setArgs(copyinstallr);
        mainsession.startShellProgram();
        currentPos = "fedoracopyinstallercompleted"
    }

    function fedoraCopyInstallToHomecoreonly(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = "Installing System Dependencies"
        var copyinstallr = ["-c", "/tmp/installers/kde_plasmoid_fedora/copy.sh"]
        mainsession.setShellProgram("bash");
        mainsession.setArgs(copyinstallr);
        mainsession.startShellProgram();
        currentPos = "fedoracopyinstallercompletedcoreonly"
    }

    function fedoraInstallSystemDeps(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = "Installing System Dependencies"

        if(fedoraversion === "fedora2526"){
            var installsysdeparg = ["-c", "pkexec /home/$USER/mycroft-core/depsFed25.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installsysdeparg);
            mainsession.startShellProgram();
            currentPos = "fedorainstallsysdepscompleted"
        }
        else if(fedoraversion === "fedora27"){
            var installsysdeparg2 = ["-c", "pkexec /home/$USER/mycroft-core/depsFed27.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installsysdeparg2);
            mainsession.startShellProgram();
            currentPos = "fedorainstallsysdepscompleted"
        }
    }

    function fedoraInstallSystemDepscoreonly(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = "Installing System Dependencies"

        if(fedoraversion === "fedora2526"){
            var installsysdeparg = ["-c", "pkexec /home/$USER/mycroft-core/depsFed25.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installsysdeparg);
            mainsession.startShellProgram();
            currentPos = "fedorainstallsysdepscompletedcoreonly"
        }
        else if(fedoraversion === "fedora27"){
            var installsysdeparg2 = ["-c", "pkexec /home/$USER/mycroft-core/depsFed27.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installsysdeparg2);
            mainsession.startShellProgram();
            currentPos = "fedorainstallsysdepscompletedcoreonly"
        }
    }

    function fedoraInstallMycroft(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = "Installing Mycroft-Core"
        var installmycroftsh = ["-c", "/home/$USER/mycroft-core/installmycroft.sh"]
        mainsession.setShellProgram("bash");
        mainsession.setArgs(installmycroftsh);
        mainsession.startShellProgram();
        currentPos = "fedorainstallmycroftcompleted"
    }

    function fedoraInstallMycroftCoreOnly(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = "Installing Mycroft-Core"
        var installmycroftsh = ["-c", "/home/$USER/mycroft-core/installmycroft.sh"]
        mainsession.setShellProgram("bash");
        mainsession.setArgs(installmycroftsh);
        mainsession.startShellProgram();
        currentPos = "fedoracoreonlyinstallcompleted"
    }

    function fedoraGetPlasmoid(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = "Downloading Mycroft-Plasmoid"
        var getplasmoid = ["-c", "git clone https://anongit.kde.org/plasma-mycroft.git /home/$USER/plasma-mycroft"]
        mainsession.setShellProgram("bash");
        mainsession.setArgs(getplasmoid);
        mainsession.startShellProgram();
        currentPos = "fedoragetplasmoidcompleted"
    }

    function fedoraInstallPlasmoidDeps(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = "Installing Plasmoid System Dependencies"
        var installplasmoiddeps = ["-c", "pkexec /tmp/installers/kde_plasmoid_fedora/appletdeps.sh"]
        mainsession.setShellProgram("bash");
        mainsession.setArgs(installplasmoiddeps);
        mainsession.startShellProgram();
        currentPos = "fedorainstallplasmoiddepscompleted"
    }

    function fedoraInstallPlasmoid(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = "Building & Installing Plasmoid"
        var installplasmoid = ["-c", "pkexec /tmp/installers/kde_plasmoid_fedora/appletdeps.sh"]
        mainsession.setShellProgram("bash");
        mainsession.setArgs(installplasmoid);
        mainsession.startShellProgram();
        currentPos = "fedoraplasmoidinstallcompleted"
    }

    Item {
        id: mainRect
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent

        ButtonGroup {
            id: distrogroup
            buttons: columnOS.children
        }

        ButtonGroup {
            id: installtypegroup
            buttons: columnInstallType.children
        }

        ButtonGroup {
            id: ubuntuveriontypegroup
            buttons: columnUbuntuOsVersionType.children
        }

        ButtonGroup {
            id: fedoraveriontypegroup
            buttons: columnFedoraOsVersionType.children
        }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page {
            id: p1info
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            Rectangle {
                id: bgRectPage1
                anchors.fill: parent
                color: "#202328"

                Rectangle {
                    id: subheaderRect
                    anchors.top: parent.top
                    width: parent.width
                    height: 30
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

                    Text {
                        id: headrTextPg1
                        anchors.centerIn: parent
                        color: "#76bbe9"
                        text: qsTr("Let's Get Started Setting Up Mycroft AI")
                        horizontalAlignment: Text.AlignHCenter
                        font.bold: true
                        font.family: "Tahoma"
                        font.pixelSize: 21
                    }
                }

                Item {
                    id: selectionPart
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: subheaderRect.bottom
                    anchors.topMargin: 10
                    anchors.bottom: parent.bottom

                    Text {
                        id: selectionheadr
                        color: "#fff"
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        text: qsTr("The first step to installing <b>Mycroft AI</b> on your computer is choosing your distribution and installation type.")
                    }

                    Rectangle {
                        id: rectSprtr01
                        anchors.top: selectionheadr.bottom
                        anchors.topMargin: 10
                        width: parent.width
                        height: 2
                        color: "#211e1e"
                    }

                    Rectangle {
                        id: rectSprtr02
                        anchors.top: pg1row.bottom
                        anchors.topMargin: 5
                        width: parent.width
                        height: 2
                        color: "#211e1e"
                    }

                    Button{
                        id: nxtBtn
                        text: "Continue"
                        width: 100
                        height: 40
                        anchors.top: rectSprtr02.bottom
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        onClicked: {
                        tabBar.currentIndex = 1
                        }
                    }

                    Row {
                        id: pg1row
                        spacing: 50
                        anchors.top: rectSprtr01.bottom
                        anchors.topMargin: 10
                        anchors.left: parent.left
                        anchors.leftMargin: 15
                        anchors.right: parent.right

                    Column {
                        id: columnOS
                        spacing: 6

                        Text {
                            id: text5p1
                            color: "#ffffff"
                            text: qsTr("Step 1: Select Distribution")
                            font.bold: true
                            font.italic: false
                            font.underline: true
                            font.family: "Tahoma"
                            font.pixelSize: 15
                        }

                        RadioButton {
                            id: sysselecter1
                            checked: true
                            objectName: "distrodebian"
                            text: "Debian / Kubuntu / KDE Neon"
                        }

                        RadioButton {
                            id: sysselecter2
                            objectName: "distrofedora"
                            text: "Fedora KDE Spin"
                        }

                        RadioButton {
                            id: sysselecter3
                            enabled: false
                            objectName: "distrosuse"
                            text: "OpenSuse Tumbleweed"
                            }
                        }
                    Column {
                        id: columnInstallType
                        spacing: 6


                        Text {
                            id: text6p1
                            color: "#ffffff"
                            text: qsTr("Step 2: Select Type")
                            font.bold: true
                            font.underline: true
                            font.italic: false
                            font.family: "Tahoma"
                            font.pixelSize: 15
                        }

                        RadioButton {
                            id: coreinstalltype
                            checked: true
                            objectName: "coreplasmoid"
                            text: "Install Mycroft Core + KDE Plasmoid"
                        }

                        RadioButton {
                            id: coreplasmoidinstalltype
                            checked: false
                            objectName: "coreonly"
                            text: "Install Mycroft Core"
                        }

                        RadioButton {
                            id: plasmoidinstalltype
                            objectName: "plasmoidonly"
                            text: "Install KDE Plasmoid"
                                }
                            }
                    Column {
                        id: columnUbuntuOsVersionType
                        spacing: 6
                        enabled: (sysselecter1.checked == true) ? true : false
                        visible: (sysselecter1.checked == true) ? true : false

                        Text {
                            id: text7p1
                            color: "#ffffff"
                            text: qsTr("Step 3: Select Distribution Version")
                            font.bold: true
                            font.underline: true
                            font.italic: false
                            font.family: "Tahoma"
                            font.pixelSize: 15
                        }

                        RadioButton {
                            id: ubver01
                            checked: true
                            objectName: "ubuntuxenial"
                            text: "16.04, 16.10, 17.04, 17.10"
                        }

                        RadioButton {
                            id: ubver02
                            checked: false
                            objectName: "ubuntubionic"
                            text: "18.04 ⤴"
                        }
                      }
                    Column {
                        id: columnFedoraOsVersionType
                        spacing: 6
                        enabled: (sysselecter2.checked == true) ? true : false
                        visible: (sysselecter2.checked == true) ? true : false

                        Text {
                            id: text8p1
                            color: "#ffffff"
                            text: qsTr("Step 3: Select Distribution Version")
                            font.bold: true
                            font.underline: true
                            font.italic: false
                            font.family: "Tahoma"
                            font.pixelSize: 15
                        }

                        RadioButton {
                            id: fdver01
                            checked: true
                            objectName: "fedora2526"
                            text: "Fedora 25, Fedroa 26"
                        }

                        RadioButton {
                            id: fdver02
                            checked: false
                            objectName: "Fedora27"
                            text: "Fedora 27 ⤴"
                        }
                      }
                    }
                  }
               }
            }

    Page {
      id: p2installer
      anchors.top: parent.top
      anchors.bottom: parent.bottom

      Rectangle {
          id: bgRectPage2
          anchors.fill: parent
          color: "#202328"

          Rectangle {
              id: subheaderRectPg2
              anchors.top: parent.top
              width: parent.width
              height: 30
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

              Text {
                  id: headrTextPg2
                  anchors.centerIn: parent
                  color: "#76bbe9"
                  text: qsTr("Continue Installation")
                  horizontalAlignment: Text.AlignHCenter
                  font.bold: true
                  font.family: "Tahoma"
                  font.pixelSize: 21
              }
          }
          Item {
              id: installPart
              anchors.left: parent.left
              anchors.right: parent.right
              anchors.top: subheaderRectPg2.bottom
              anchors.topMargin: 10
              anchors.bottom: parent.bottom
Column{
    id: page2infoclmn
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    spacing: 10

              Text {
                  id: subheadrpg2txt
                  anchors.left: parent.left
                  anchors.leftMargin: 10
                  anchors.right: parent.right
                  anchors.rightMargin: 10
                  color: "#ffffff"
                  text: qsTr("<b>Please Note</b>: This installation requires an <i><b>Active Internet Connection</i></b>. The installation procedure might require you to enter your administrator password multiple times to be able to successfully install Mycroft AI and its components. This Installation would take several minutes to complete.")
                  font.family: "Tahoma"
                  wrapMode: Text.WordWrap
                  font.pixelSize: 16
              }

              Text {
                  id: subheadrpg2txt2
                  anchors.left: parent.left
                  anchors.leftMargin: 10
                  anchors.right: parent.right
                  anchors.rightMargin: 10
                  color: "#ffffff"
                  text: qsTr("<i><b>Warning</b>: Cancelling/Interupting this installation will lead to a broken Mycroft install</i>")
                  font.family: "Tahoma"
                  wrapMode: Text.WordWrap
                  font.pixelSize: 16
              }
            }

              Rectangle {
                  id: rectSprtr2Pg01
                  anchors.top: page2infoclmn.bottom
                  anchors.topMargin: 10
                  width: parent.width
                  height: 2
                  color: "#211e1e"
              }

              Button{
                width: 200
                height: 50
                text: "Begin Installation!"
                anchors.top: rectSprtr2Pg01.bottom
                anchors.topMargin: 4
                anchors.right: parent.right
                anchors.rightMargin: 10

                onClicked: {
                mainInstallerDrawer.open()
                        switch(distrotype){
                        case "distrodebian":
                            console.log("debian")
                            gitInstallDebian()
                            break
                        case "distrofedora":
                            console.log("fedora")
                            gitInstallFedora()
                            break
                        }
                    }
                 }

             Loader{
                id: footerSlideShow
                source: "SlideshowArea.qml"
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                height: 125
             }

             Drawer{
                id: mainInstallerDrawer
                edge: Qt.BottomEdge
                width: root.width
                height: root.height / 1.4
                dragMargin: 0
                interactive: false

                Rectangle {
                    anchors.fill: parent
                    color: "#202328"

                    Text{
                      id: progressText
                      anchors.top: parent.top
                      anchors.topMargin: 10
                      anchors.left: parent.left
                      anchors.leftMargin: 12
                      color: "#fff"
                      text: qsTr("Starting Installation")
                      font.italic: true
                      font.bold: false
                      font.family: "Tahoma"
                      font.pixelSize: 14
                    }

                    ProgressBar {
                        id: progressBar1
                        anchors.top: progressText.bottom
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        width: parent.width / 1.2
                        height: 20
                        indeterminate: true
                    }

                    ToolButton {
                        id: exitinstallerbtn
                        anchors.verticalCenter: progressBar1.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 15
                        width: 120
                        height: 40
                        flat: false
                        highlighted: true
                        text: qsTr("Exit Installer")
                        enabled: false
                        visible: false
                        onClicked: {
                            Qt.quit()
                        }
                    }

                    QMLTermWidget {
                        id: terminal
                        anchors.top: progressBar1.bottom
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.margins: 12
                        font.family: "Monospace"
                        font.pointSize: 12
                        colorScheme: "cool-retro-term"
                        session: QMLTermSession{
                            id: mainsession
                            property bool hasFinished: false
                            initialWorkingDirectory: "$HOME"
                            onMatchFound: {
                                console.log("found at: %1 %2 %3 %4".arg(startColumn).arg(startLine).arg(endColumn).arg(endLine));
                             }
                             onNoMatchFound: {
                                console.log("not found");
                            }
                            onFinished: {
                                console.log("finished")
                                switch(currentPos){
                                case "debiangitInstallcompleted":
                                    hasFinished = true;
                                    debiancleanInstaller()
                                    break;
                                case "debiancleanInstallerCompleted":
                                    hasFinished = true;
                                    debiangetInstallers();
                                    break;
                                case "debiangetInstallerscompleted":
                                    hasFinished = true;
                                    debianCloneMycroftInstall();
                                    break;
                                case "debiangetMycroftcompleted":
                                    hasFinished = true;
                                    debianCopyInstallToHome();
                                    break;
                                case "debiancopyinstallercompleted":
                                    hasFinished = true;
                                    debianInstallSystemDeps();
                                    break;
                                case "debianinstallsysdepscompleted":
                                    hasFinished = true;
                                    debianInstallMycroft();
                                    break;
                                case "debianinstallmycroftcompleted":
                                    hasFinished = true;
                                    debianGetPlasmoid();
                                    break;
                                case "debiangetplasmoidcompleted":
                                    hasFinished = true;
                                    debianInstallPlasmoidDeps();
                                    break;
                                case "debianinstallplasmoiddepscompleted":
                                    hasFinished = true;
                                    debianInstallPlasmoid();
                                    break;
                                case "debianplasmoidinstallcompleted":
                                    hasFinished = true;
                                    installationCompleted();
                                    break;
                                case "debiangetInstallerscompletedcoreonly":
                                    hasFinished = true;
                                    debianCloneMycroftInstallcoreonly();
                                    break;
                                case "debiangetMycroftcompletedcoreonly":
                                    hasFinished = true;
                                    debianCopyInstallToHomecoreonly();
                                    break;
                                case "debiancopyinstallercompletedcoreonly":
                                    hasFinished = true;
                                    debianInstallSystemDepscoreonly();
                                    break;
                                case "debianinstallsysdepscompletedcoreonly":
                                    hasFinished = true;
                                    debianInstallMycroftCoreOnly();
                                    break;
                                case "debiancoreonlyinstallcompleted":
                                    hasFinished = true;
                                    installationCompleted();
                                    break;
                                case "fedoragitInstallcompleted":
                                    hasFinished = true;
                                    fedoracleanInstaller();
                                    break;
                                case "fedoracleanInstallerCompleted":
                                    hasFinished = true;
                                    fedoragetInstallers();
                                    break;
                                case "fedoragetInstallerscompleted":
                                    hasFinished = true;
                                    fedoraCloneMycroftInstall();
                                    break;
                                case "fedoragetMycroftcompleted":
                                    hasFinished = true;
                                    fedoraCopyInstallToHome();
                                    break;
                                case "fedoracopyinstallercompleted":
                                    hasFinished = true;
                                    fedoraInstallSystemDeps();
                                    break;
                                case "fedorainstallsysdepscompleted":
                                    hasFinished = true;
                                    fedoraInstallMycroft();
                                    break;
                                case "fedorainstallmycroftcompleted":
                                    hasFinished = true;
                                    fedoraGetPlasmoid();
                                    break;
                                case "fedoragetplasmoidcompleted":
                                    hasFinished = true;
                                    fedoraInstallPlasmoidDeps();
                                    break;
                                case "fedorainstallplasmoiddepscompleted":
                                    hasFinished = true;
                                    fedoraInstallPlasmoid();
                                    break;
                                case "fedoraplasmoidinstallcompleted":
                                    hasFinished = true;
                                    installationCompleted();
                                    break;
                                case "fedoragetInstallerscompletedcoreonly":
                                    hasFinished = true;
                                    fedoraCloneMycroftInstallcoreonly();
                                    break;
                                case "fedoragetMycroftcompletedcoreonly":
                                    hasFinished = true;
                                    fedoraCopyInstallToHomecoreonly();
                                    break;
                                case "fedoracopyinstallercompletedcoreonly":
                                    hasFinished = true;
                                    fedoraInstallSystemDepscoreonly();
                                    break;
                                case "fedorainstallsysdepscompletedcoreonly":
                                    hasFinished = true;
                                    fedoraInstallMycroftCoreOnly();
                                    break;
                                case "fedoracoreonlyinstallcompleted":
                                    hasFinished = true;
                                    installationCompleted();
                                    break;
                                }
                            }
                        }
                        onTerminalUsesMouseChanged: console.log(terminalUsesMouse);
                        onTerminalSizeChanged: console.log(terminalSize);
                        Component.onCompleted: {}

                        QMLTermScrollbar {
                            terminal: terminal
                            width: 20
                            Rectangle {
                                opacity: 0.4
                                anchors.margins: 5
                                radius: width * 0.5
                                anchors.fill: parent
                            }
                        }
                     }
                  }
               }
            }
         }
      }
   }
}

    header: Rectangle {
        id: headerRect
        anchors.top: parent.top
        width: parent.width
        height: 150
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

        Loader{
            id: bgldr
            anchors.fill: parent
            source: "CanBackground.qml"
        }

        Rectangle{
           id: logorect
           anchors.centerIn: parent
           width: logoimg.width + 10
           height: parent.height
           color: "#99211e1e"
           layer.enabled: true
           layer.effect: DropShadow {
               horizontalOffset: 0
               verticalOffset: 1
               radius: 10
               samples: 32
               spread: 0.1
               color: Qt.rgba(0, 0, 0, 0.3)
           }
           Rectangle {
            anchors.fill: parent
           color: Qt.darker("#99211e1e", 1.1)

            Image {
            id: logoimg
            anchors.centerIn: parent
            source: "qrc:images/mycroft_ai_logo.png"
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
