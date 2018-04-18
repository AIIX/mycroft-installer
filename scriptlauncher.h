#ifndef SCRIPTLAUNCHER_H
#define SCRIPTLAUNCHER_H

#include <QObject>
#include <QProcess>
#include <QDebug>

class ScriptLauncher : public QObject
{

    Q_OBJECT

public:
    explicit ScriptLauncher(QObject *parent = Q_NULLPTR);
    Q_INVOKABLE void launchScript(const QString &program);
    Q_INVOKABLE void getCurrentState(const QString &value);
    Q_INVOKABLE QString mText(const QString &txt);

private:
    QProcess *m_process;
    QString getText;

signals:
    void processed(const QString &str);

public slots:
    QString mFinished(int exitCode);
};

#endif

