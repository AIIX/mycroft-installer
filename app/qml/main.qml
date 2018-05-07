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
    minimumHeight: Screen.height / 1.15
    minimumWidth: Screen.width / 1.15
    width: Screen.width
    height: Screen.height
    maximumHeight: Screen.height
    maximumWidth: Screen.width
    title: qsTr("Mycroft AI Setup")

    property string distrotype: distrogroup.checkedButton.objectName
    property string installtype: installtypegroup.checkedButton.objectName
    property string debianversion: debianveriontypegroup.checkedButton.objectName
    property string neonversion: neonveriontypegroup.checkedButton.objectName
    property string ubuntuversion: ubuntuveriontypegroup.checkedButton.objectName
    property string fedoraversion: fedoraveriontypegroup.checkedButton.objectName
    property string installversion: installversiongroup.checkedButton.objectName
    property string currentPos
    property real dpiUnit: getDisplayUnit()

    function getDisplayUnit(){
        var displaydpi = Math.max(Screen.pixelDensity, Screen.logicalPixelDensity);
        if (displaydpi < 3.5){
            return 3.5
        } else if(displaydpi > 5.8){
            return 5
        }
        return displaydpi;
    }

    function gitInstallDebian(){
        progressText.text = qsTr("Installing Git")
        var installgitarg = ["-c", "pkexec apt install git -y"]
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

        switch(distrotype){
        case "distroubuntu":
            var copyinstallrubuntu = ["-c", "/tmp/installers/kde_plasmoid_ubuntu/copy.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(copyinstallrubuntu);
            mainsession.startShellProgram();
            currentPos = "debiancopyinstallercompleted"
            break
        case "distrodebian":
            var copyinstallrdebian = ["-c", "/tmp/installers/kde_plasmoid_debian/copy.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(copyinstallrdebian);
            mainsession.startShellProgram();
            currentPos = "debiancopyinstallercompleted"
            break
        case "distroneon":
            var copyinstallrneon = ["-c", "/tmp/installers/kde_plasmoid_neon/copy.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(copyinstallrneon);
            mainsession.startShellProgram();
            currentPos = "debiancopyinstallercompleted"
            break
        }
    }

    function debianCopyInstallToHomecoreonly(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = "Installing System Dependencies"

        switch(distrotype){
        case "distroubuntu":
            var copyinstallrubuntu = ["-c", "/tmp/installers/kde_plasmoid_ubuntu/copy.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(copyinstallrubuntu);
            mainsession.startShellProgram();
            currentPos = "debiancopyinstallercompletedcoreonly"
            break
        case "distrodebian":
            var copyinstallrdebian = ["-c", "/tmp/installers/kde_plasmoid_debian/copy.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(copyinstallrdebian);
            mainsession.startShellProgram();
            currentPos = "debiancopyinstallercompletedcoreonly"
            break
        case "distroneon":
            var copyinstallrneon = ["-c", "/tmp/installers/kde_plasmoid_neon/copy.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(copyinstallrneon);
            mainsession.startShellProgram();
            currentPos = "debiancopyinstallercompletedcoreonly"
            break
        }
    }

    function debianInstallSystemDeps(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = "Installing System Dependencies"

        switch(distrotype){
        case "distroubuntu":
        if(ubuntuversion === "ubuntuartful"){
            var installubuntusysdepargxenial = ["-c", "pkexec /home/$USER/mycroft-core/ubuntuArtful.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installubuntusysdepargxenial);
            mainsession.startShellProgram();
            currentPos = "debianinstallsysdepscompleted"
            }
        else if(ubuntuversion === "ubuntubionic"){
            var installubuntusysdepargbionic = ["-c", "pkexec /home/$USER/mycroft-core/ubuntuBionic.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installubuntusysdepargbionic);
            mainsession.startShellProgram();
            currentPos = "debianinstallsysdepscompleted"
            }
        break
        case "distrodebian":
        if(debianversion === "debianunstable"){
            var installdebiansysdepargstable = ["-c", "pkexec /home/$USER/mycroft-core/debianUnstable.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installdebiansysdepargstable);
            mainsession.startShellProgram();
            currentPos = "debianinstallsysdepscompleted"
            }
        break
        case "distroneon":
        if(neonversion === "neonxenial"){
            var installneonsysdepargxenial = ["-c", "pkexec /home/$USER/mycroft-core/neonXenial.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installneonsysdepargxenial);
            mainsession.startShellProgram();
            currentPos = "debianinstallsysdepscompleted"
            }
        else if(neonversion === "neonbionic"){
            var installneonsysdepargbionic = ["-c", "pkexec /home/$USER/mycroft-core/neonBionic.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installneonsysdepargbionic);
            mainsession.startShellProgram();
            currentPos = "debianinstallsysdepscompleted"
            }
        break
        }
    }

    function debianInstallSystemDepscoreonly(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = "Installing System Dependencies"

        switch(distrotype){
        case "distroubuntu":
        if(ubuntuversion === "ubuntuartful"){
            var installubuntusysdepargxenial = ["-c", "pkexec /home/$USER/mycroft-core/ubuntuArtful.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installubuntusysdepargxenial);
            mainsession.startShellProgram();
            currentPos = "debianinstallsysdepscompletedcoreonly"
            }
        else if(ubuntuversion === "ubuntubionic"){
            var installubuntusysdepargbionic = ["-c", "pkexec /home/$USER/mycroft-core/ubuntuBionic.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installubuntusysdepargbionic);
            mainsession.startShellProgram();
            currentPos = "debianinstallsysdepscompletedcoreonly"
            }
        break
        case "distrodebian":
        if(debianversion === "debianunstable"){
            var installdebiansysdepargstable = ["-c", "pkexec /home/$USER/mycroft-core/debianUnstable.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installdebiansysdepargstable);
            mainsession.startShellProgram();
            currentPos = "debianinstallsysdepscompletedcoreonly"
            }
        break
        case "distroneon":
        if(neonversion === "neonxenial"){
            var installneonsysdepargxenial = ["-c", "pkexec /home/$USER/mycroft-core/neonXenial.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installneonsysdepargxenial);
            mainsession.startShellProgram();
            currentPos = "debianinstallsysdepscompletedcoreonly"
            }
        else if(neonversion === "neonbionic"){
            var installneonsysdepargbionic = ["-c", "pkexec /home/$USER/mycroft-core/neonBionic.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installneonsysdepargbionic);
            mainsession.startShellProgram();
            currentPos = "debianinstallsysdepscompletedcoreonly"
            }
        break
        }
    }

    function debianInstallMycroft(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = "Installing Mycroft-Core"

        switch(installversion){
        case "fullver":
            var installmycroftsh = ["-c", "/home/$USER/mycroft-core/installmycroft.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installmycroftsh);
            mainsession.startShellProgram();
            currentPos = "debianinstallmycroftcompleted"
        break
        case "lowver":
            var installmycroftsh2 = ["-c", "/home/$USER/mycroft-core/installmycroftlw.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installmycroftsh2);
            mainsession.startShellProgram();
            currentPos = "debianinstallmycroftcompleted"
         break
        }
    }

    function debianInstallMycroftCoreOnly(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = "Installing Mycroft-Core"

        switch(installversion){
        case "fullver":
            var installmycroftsh = ["-c", "/home/$USER/mycroft-core/installmycroft.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installmycroftsh);
            mainsession.startShellProgram();
            currentPos = "debiancoreonlyinstallcompleted"
        break
        case "lowver":
            var installmycroftsh2 = ["-c", "/home/$USER/mycroft-core/installmycroftlw.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installmycroftsh2);
            mainsession.startShellProgram();
            currentPos = "debiancoreonlyinstallcompleted"
         break
        }
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

        switch(distrotype){
        case "distroubuntu":
        if(ubuntuversion === "ubuntuartful"){
            var installplasdepsart = ["-c", "pkexec /tmp/installers/kde_plasmoid_ubuntu/appletdepsart.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installplasdepsart);
            mainsession.startShellProgram();
            currentPos = "debianinstallplasmoiddepscompleted"
            }
        else if(ubuntuversion === "ubuntubionic"){
            var installplasdepsbio = ["-c", "pkexec /tmp/installers/kde_plasmoid_ubuntu/appletdepsbio.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installplasdepsbio);
            mainsession.startShellProgram();
            currentPos = "debianinstallplasmoiddepscompleted"
            }
        break
        case "distrodebian":
        if(debianversion === "debianunstable"){
            var installplasdepsdebu = ["-c", "pkexec /tmp/installers/kde_plasmoid_debian/appletdepsdebu.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installplasdepsdebu);
            mainsession.startShellProgram();
            currentPos = "debianinstallplasmoiddepscompleted"
            }
        break
        case "distroneon":
        if(neonversion === "neonxenial"){
            var installplasdepsneonx = ["-c", "pkexec /tmp/installers/kde_plasmoid_neon/appletdepsneonx.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installplasdepsneonx);
            mainsession.startShellProgram();
            currentPos = "debianinstallplasmoiddepscompleted"
            }
        else if(neonversion === "neonbionic"){
            var installplasdepsneonb = ["-c", "pkexec /tmp/installers/kde_plasmoid_neon/appletdepsneonb.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installplasdepsneonb);
            mainsession.startShellProgram();
            currentPos = "debianinstallplasmoiddepscompleted"
            }
        break
        }
    }

    function debianInstallPlasmoid(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = "Building & Installing Plasmoid"
        var installplasmoid = ["-c", "pkexec /tmp/installers/kde_plasmoid_debian/installPlasmoid.sh"]
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

        if(fedoraversion === "fedora27"){
            var installsysdeparg = ["-c", "pkexec /home/$USER/mycroft-core/depsFed27.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installsysdeparg);
            mainsession.startShellProgram();
            currentPos = "fedorainstallsysdepscompleted"
        }
        else if(fedoraversion === "fedora28"){
            var installsysdeparg2 = ["-c", "pkexec /home/$USER/mycroft-core/depsFed28.sh"]
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

        if(fedoraversion === "fedora27"){
            var installsysdeparg = ["-c", "pkexec /home/$USER/mycroft-core/depsFed27.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installsysdeparg);
            mainsession.startShellProgram();
            currentPos = "fedorainstallsysdepscompletedcoreonly"
        }
        else if(fedoraversion === "fedora28"){
            var installsysdeparg2 = ["-c", "pkexec /home/$USER/mycroft-core/depsFed28.sh"]
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


        switch(installversion){
        case "fullver":
            var installmycroftsh = ["-c", "/home/$USER/mycroft-core/installmycroft.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installmycroftsh);
            mainsession.startShellProgram();
            currentPos = "fedorainstallmycroftcompleted"
        break
        case "lowver":
            var installmycroftsh2 = ["-c", "/home/$USER/mycroft-core/installmycroftlw.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installmycroftsh2);
            mainsession.startShellProgram();
            currentPos = "fedorainstallmycroftcompleted"
         break
        }
    }

    function fedoraInstallMycroftCoreOnly(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = "Installing Mycroft-Core"

        switch(installversion){
        case "fullver":
            var installmycroftsh = ["-c", "/home/$USER/mycroft-core/installmycroft.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installmycroftsh);
            mainsession.startShellProgram();
            currentPos = "fedoracoreonlyinstallcompleted"
        break
        case "lowver":
            var installmycroftsh2 = ["-c", "/home/$USER/mycroft-core/installmycroftlw.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installmycroftsh2);
            mainsession.startShellProgram();
            currentPos = "fedoracoreonlyinstallcompleted"
         break
        }
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
        if(fedoraversion === "fedora27"){
            var installplasmoiddeps = ["-c", "pkexec /tmp/installers/kde_plasmoid_fedora/appletdepsf27.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installplasmoiddeps);
            mainsession.startShellProgram();
            currentPos = "fedorainstallplasmoiddepscompleted"
        }
        else if(fedoraversion === "fedora28"){
            var installplasmoiddeps2 = ["-c", "pkexec /tmp/installers/kde_plasmoid_fedora/appletdepsf28.sh"]
            mainsession.setShellProgram("bash");
            mainsession.setArgs(installplasmoiddeps2);
            mainsession.startShellProgram();
            currentPos = "fedorainstallplasmoiddepscompleted"
        }
    }

    function fedoraInstallPlasmoid(){
        mainsession.hasFinished = false
        currentPos = ""
        progressText.text = "Building & Installing Plasmoid"
        var installplasmoid = ["-c", "pkexec /tmp/installers/kde_plasmoid_fedora/installPlasmoid.sh"]
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
            id: debianveriontypegroup
            buttons: columnDebianOsVersionType.children
        }

        ButtonGroup {
            id: neonveriontypegroup
            buttons: columnNeonOsVersionType.children
        }

        ButtonGroup {
            id: fedoraveriontypegroup
            buttons: columnFedoraOsVersionType.children
        }

        ButtonGroup {
            id: installversiongroup
            buttons: columnInstallVersionType.children
        }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        interactive: false
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
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: headrTextPg1.contentHeight
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
                        font.pointSize: dpiUnit * 4
                    }
                }

                Item {
                    id: selectionPart
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: subheaderRect.bottom
                    anchors.topMargin: 10
                    anchors.bottom: parent.bottom

                    Rectangle {
                        id: infoPart
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: rectSprtr02.bottom
                        anchors.topMargin: 5
                        color: "#211e1e"
                        height: sbxtext.contentHeight + 5

                        Text {
                            id: sbxtext
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            color: "#fff"
                            font.pointSize: dpiUnit * 3
                            wrapMode: Text.Wrap
                            width: parent.width
                            text: qsTr("<b>Please Note</b>: Mycroft plasmoid requires distribution support with <b><i>Qt Version 5.9.x</b></i> or higher. Check your Qt Version in <b><i>About System.</i></b>")
                        }
                    }

                    Text {
                        id: selectionheadr
                        color: "#fff"
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        font.pointSize: dpiUnit * 3
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

                    Rectangle {
                        id: nxtBtn
                        height: ftxt.contentHeight + 5
                        color: "#211e1e"
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        anchors.left: parent.left

                        Text {
                        id: ftxt
                        color: "#fff"
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        font.pointSize: dpiUnit * 3
                        text: qsTr("After completing your selection click the <b><i>Install</i></b> tab to continue")
                        }
                    }

                    Row {
                        id: pg1row
                        spacing: 10
                        anchors.top: rectSprtr01.bottom
                        anchors.topMargin: 10
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        anchors.right: parent.right
                        anchors.rightMargin: 20

                    Column {
                        id: columnOS
                        spacing: 6
                        width: parent.width / 4

                        Text {
                            id: text5p1
                            color: "#ffffff"
                            text: qsTr("Step 1: Select Distribution")
                            font.bold: true
                            font.italic: false
                            font.underline: true
                            font.family: "Tahoma"
                            font.pointSize: dpiUnit * 3
                            wrapMode: Text.Wrap
                        }

                        RadioButton {
                            id: sysselecter1
                            checked: true
                            objectName: "distrodebian"
                            text: "Debian"
                            width: parent.width
                            font.pointSize: dpiUnit * 2.75
                        }

                        RadioButton {
                            id: sysselecter2
                            checked: false
                            objectName: "distroubuntu"
                            text: "Kubuntu"
                            width: parent.width
                            font.pointSize: dpiUnit * 2.75
                        }

                        RadioButton {
                            id: sysselecter3
                            checked: false
                            objectName: "distroneon"
                            text: "KDE Neon"
                            width: parent.width
                            font.pointSize: dpiUnit * 2.75
                        }

                        RadioButton {
                            id: sysselecter4
                            objectName: "distrofedora"
                            text: "Fedora KDE Spin"
                            width: parent.width
                            font.pointSize: dpiUnit * 2.75
                        }
                        }
                    Column {
                        id: columnInstallType
                        spacing: 6
                        width: parent.width / 4

                        Text {
                            id: text6p1
                            color: "#ffffff"
                            text: qsTr("Step 2: Select Type")
                            font.bold: true
                            font.underline: true
                            font.italic: false
                            font.family: "Tahoma"
                            font.pointSize: dpiUnit * 3
                            wrapMode: Text.Wrap
                        }

                        RadioButton {
                            id: coreinstalltype
                            checked: true
                            objectName: "coreplasmoid"
                            width: parent.width
                            text: "Install Mycroft Core + KDE Plasmoid"
                            font.pointSize: dpiUnit * 2.75
                        }

                        RadioButton {
                            id: coreplasmoidinstalltype
                            checked: false
                            objectName: "coreonly"
                            width: parent.width
                            text: "Install Mycroft Core"
                            font.pointSize: dpiUnit * 2.75
                        }

                        RadioButton {
                            id: plasmoidinstalltype
                            objectName: "plasmoidonly"
                            width: parent.width
                            text: "Install KDE Plasmoid"
                            font.pointSize: dpiUnit * 2.75
                                }
                            }
                    Column {
                        id: columnDebianOsVersionType
                        spacing: 6
                        width: parent.width / 4
                        enabled: (sysselecter1.checked == true) ? true : false
                        visible: (sysselecter1.checked == true) ? true : false

                        Text {
                            id: text8p1
                            color: "#ffffff"
                            text: qsTr("Step 3: Select Distribution Version")
                            font.bold: true
                            font.underline: true
                            font.italic: false
                            font.family: "Tahoma"
                            font.pointSize: dpiUnit * 3
                            wrapMode: Text.Wrap
                            width: parent.width
                        }

                        RadioButton {
                            id: debver01
                            checked: true
                            objectName: "debianunstable"
                            text: "Debian Testing (Unstable)"
                            width: parent.width
                            font.pointSize: dpiUnit * 2.75
                        }
                      }
                    Column {
                        id: columnUbuntuOsVersionType
                        spacing: 6
                        width: parent.width / 4
                        enabled: (sysselecter2.checked == true) ? true : false
                        visible: (sysselecter2.checked == true) ? true : false

                        Text {
                            id: text7p1
                            color: "#ffffff"
                            text: qsTr("Step 3: Select Distribution Version")
                            font.bold: true
                            font.underline: true
                            font.italic: false
                            font.family: "Tahoma"
                            font.pointSize: dpiUnit * 3
                            wrapMode: Text.Wrap
                            width: parent.width
                        }

                        RadioButton {
                            id: ubver01
                            checked: true
                            objectName: "ubuntuxenial"
                            text: "17.10"
                            width: parent.width
                            font.pointSize: dpiUnit * 2.75
                        }

                        RadioButton {
                            id: ubver02
                            checked: false
                            objectName: "ubuntubionic"
                            text: "18.04"
                            width: parent.width
                            font.pointSize: dpiUnit * 2.75
                        }
                      }
                    Column {
                        id: columnNeonOsVersionType
                        spacing: 6
                        width: parent.width / 4
                        enabled: (sysselecter3.checked == true) ? true : false
                        visible: (sysselecter3.checked == true) ? true : false

                        Text {
                            id: text7p1N
                            color: "#ffffff"
                            text: qsTr("Step 3: Select Distribution Version")
                            font.bold: true
                            font.underline: true
                            font.italic: false
                            font.family: "Tahoma"
                            font.pointSize: dpiUnit * 3
                            wrapMode: Text.Wrap
                            width: parent.width
                        }

                        RadioButton {
                            id: neonver01
                            checked: true
                            objectName: "neonxenial"
                            text: "Xenial"
                            width: parent.width
                            font.pointSize: dpiUnit * 2.75
                        }

                        RadioButton {
                            id: neonver02
                            checked: false
                            objectName: "neonbionic"
                            text: "Bionic"
                            width: parent.width
                            font.pointSize: dpiUnit * 2.75
                        }
                      }
                    Column {
                        id: columnFedoraOsVersionType
                        spacing: 6
                        width: parent.width / 4
                        enabled: (sysselecter4.checked == true) ? true : false
                        visible: (sysselecter4.checked == true) ? true : false

                        Text {
                            id: text8p1d
                            color: "#ffffff"
                            text: qsTr("Step 3: Select Distribution Version")
                            font.bold: true
                            font.underline: true
                            font.italic: false
                            font.family: "Tahoma"
                            font.pointSize: dpiUnit * 3
                            wrapMode: Text.Wrap
                            width: parent.width
                        }

                        RadioButton {
                            id: fdver01
                            checked: true
                            objectName: "fedora27"
                            text: "Fedroa 27"
                            width: parent.width
                            font.pointSize: dpiUnit * 2.75
                        }

                        RadioButton {
                            id: fdver02
                            checked: false
                            objectName: "fedora28"
                            text: "Fedora 28"
                            width: parent.width
                            font.pointSize: dpiUnit * 2.75
                        }
                      }
                    Column {
                        id: columnInstallVersionType
                        spacing: 6
                        width: parent.width / 4
                        enabled: (plasmoidinstalltype.checked == true) ? false : true
                        visible: (plasmoidinstalltype.checked == true) ? false : true

                        Text {
                            id: text9p1d
                            color: "#ffffff"
                            text: qsTr("Step 4: Select Install Version")
                            font.bold: true
                            font.underline: true
                            font.italic: false
                            font.family: "Tahoma"
                            font.pointSize: dpiUnit * 3
                            wrapMode: Text.Wrap
                            width: parent.width
                        }

                        RadioButton {
                            id: fullver0
                            checked: true
                            objectName: "fullver"
                            text: "Default Installation"
                            width: parent.width
                            font.pointSize: dpiUnit * 2.75
                        }

                        Text {
                            id: fullverlabel
                            color: "#ffffff"
                            text: qsTr("Installs Mimic with all default voices for Mycroft-Core")
                            font.italic: true
                            font.family: "Tahoma"
                            font.pointSize: dpiUnit * 2.5
                            wrapMode: Text.Wrap
                            width: parent.width
                        }

                        Text {
                            id: fullverlabel2
                            color: "#ffffff"
                            text: qsTr("<b>Recommended for x86-64 platform</b>")
                            font.italic: true
                            font.family: "Tahoma"
                            font.pointSize: dpiUnit * 2.5
                            wrapMode: Text.Wrap
                            width: parent.width
                        }


                        RadioButton {
                            id: lowver0
                            checked: false
                            objectName: "lowver"
                            text: "Low Powered H/W"
                            width: parent.width
                            font.pointSize: dpiUnit * 2.75
                        }

                        Text {
                            id: lowverlabel
                            color: "#ffffff"
                            text: qsTr("Installs Mimic with some voices disabled for Mycroft-Core")
                            font.italic: true
                            font.family: "Tahoma"
                            font.pointSize: dpiUnit * 2.5
                            wrapMode: Text.Wrap
                            width: parent.width
                        }
                        Text {
                            id: lowverlabel2
                            color: "#ffffff"
                            text: qsTr("<b>Recommended for Armhf/Arm64 platform</b>")
                            font.italic: true
                            font.family: "Tahoma"
                            font.pointSize: dpiUnit * 2.5
                            wrapMode: Text.Wrap
                            width: parent.width
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
              height: headrTextPg2.height
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
                  font.pointSize: dpiUnit * 4
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
                  font.pointSize: dpiUnit * 3
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
                  font.pointSize: dpiUnit * 3
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
                anchors.left: parent.left
                anchors.right: parent.right
                font.pointSize: dpiUnit * 2.75

                onClicked: {
                mainInstallerDrawer.open()
                        switch(distrotype){
                        case "distrodebian":
                            console.log("debian")
                            gitInstallDebian()
                            break
                        case "distroneon":
                            console.log("debian")
                            gitInstallDebian()
                            break
                        case "distroubuntu":
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
                height: dpiUnit * 34
             }

             Drawer{
                id: mainInstallerDrawer
                edge: Qt.BottomEdge
                width: root.width
                height: footer.height + bgRectPage2.height
                dragMargin: 0
                interactive: false
                dim: false

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
                      font.pointSize: dpiUnit * 2.75
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
                        //onTerminalUsesMouseChanged: console.log(terminalUsesMouse);
                        //onTerminalSizeChanged: console.log(terminalSize);
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
        anchors.left: parent.left
        anchors.right: parent.right
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
