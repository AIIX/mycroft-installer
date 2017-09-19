#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QIcon>
#include "scriptlauncher.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QGuiApplication::setWindowIcon(QIcon("qrc:/mycroft-plasma-appicon.png"));
    QQuickStyle::setStyle("Material");
    qmlRegisterType<ScriptLauncher>("MycroftLauncher", 1, 0, "ScriptLauncher");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    app.processEvents();
    return app.exec();
}
