#include "scriptlauncher.h"
#include <QDebug>
#include <QProcess>
#include <QThread>
#include <QMetaType>

ScriptLauncher::ScriptLauncher(QObject *parent) :
    QObject(parent),
    m_process(new QProcess(this))
{
    connect(m_process, SIGNAL(finished(int)), this, SLOT(mFinished(int)));
}

void ScriptLauncher::launchScriptDebianGit(const QString &program)
{
    m_process->start(program);
}

void ScriptLauncher::launchScriptDebianGetInstallers(const QString &program)
{
    m_process->start(program);
}

void ScriptLauncher::launchScriptDebianInstall(const QString &program)
{
    m_process->start(program);
}

void ScriptLauncher::launchScriptFedoraGit(const QString &program)
{
    m_process->start(program);
}

void ScriptLauncher::launchScriptFedoraGetInstallers(const QString &program)
{
    m_process->start(program);
}

void ScriptLauncher::launchScriptFedoraInstall(const QString &program)
{
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
