#include "scriptlauncher.h"
#include <QDebug>
#include <QProcess>
#include <QProcessEnvironment>
#include <QThread>
#include <QMetaType>

ScriptLauncher::ScriptLauncher(QObject *parent) :
    QObject(parent),
    m_process(new QProcess(this))
{
    connect(m_process, SIGNAL(finished(int)), this, SLOT(mFinished(int)));
}

void ScriptLauncher::launchScript(const QString &program)
{
    QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
    m_process->setProcessEnvironment(env);
    m_process->start(program);
}

QString ScriptLauncher::mText(const QString &txt) {
    getText = txt;
    return txt;
}

QString ScriptLauncher::mFinished(int exitCode) {
    QString aText = QString::number(exitCode);
    getCurrentState(getText);
    qDebug() << getText << exitCode;
    return aText;
}

void ScriptLauncher::getCurrentState(const QString &value) {
    emit processed(value);
}
